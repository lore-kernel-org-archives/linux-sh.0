From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 May 2010 14:27:28 +0000
Subject: [PATCH] sh: add romImage MMCIF boot for sh7724 and Ecovec
Message-Id: <20100513142728.20439.17880.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch extends the romImage code with MMCIF
support for sh7724 and the Ecovec board. With this
patch applied and CONFIG_ROMIMAGE_MMCIF selected
the romImage kernel image can be written to a
MMC card and booted directly by the sh7724 cpu.

The MMCIF loader is put under drivers/sh for 
easy sharing with the sh7372 processor.

Thanks to Jeremy Baker for the initial prototype.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the following:
 "[PATCH] sh: allow romImage data between head.S and the zero page"

 arch/sh/Kconfig                      |   11 ++
 arch/sh/boot/romimage/Makefile       |   11 ++
 arch/sh/boot/romimage/head.S         |   29 +++++
 arch/sh/boot/romimage/mmcif-sh7724.c |   94 +++++++++++++++++++
 arch/sh/boot/romimage/vmlinux.scr    |    1 
 arch/sh/include/cpu-sh4/cpu/sh7724.h |    1 
 drivers/sh/mmcif_loader.c            |  167 ++++++++++++++++++++++++++++++++++
 7 files changed, 312 insertions(+), 2 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2010-05-13 22:12:58.000000000 +0900
@@ -772,6 +772,17 @@ config ENTRY_OFFSET
 	default "0x00010000" if PAGE_SIZE_64KB
 	default "0x00000000"
 
+config ROMIMAGE_MMCIF
+	bool "Include MMCIF loader in romImage (EXPERIMENTAL)"
+	depends on CPU_SUBTYPE_SH7724 && EXPERIMENTAL
+	help
+	  Say Y here to include experimental MMCIF loading code in
+	  romImage. With this enabled it is possible to write the romImage
+	  kernel image to an MMC card and boot the kernel straight from
+	  the reset vector. At reset the processor Mask ROM will load the
+	  first part of the romImage which in turn loads the rest the kernel
+	  image to RAM using the MMCIF hardware block.
+
 choice
 	prompt "Kernel command line"
 	optional
--- 0001/arch/sh/boot/romimage/Makefile
+++ work/arch/sh/boot/romimage/Makefile	2010-05-13 22:12:58.000000000 +0900
@@ -6,8 +6,17 @@
 
 targets		:= vmlinux head.o zeropage.bin piggy.o
 
+IMAGE_ADDRESS	:= 0
 OBJECTS = $(obj)/head.o
-LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext 0 -e romstart \
+
+ifeq ($(CONFIG_ROMIMAGE_MMCIF),y)
+ifeq ($(CONFIG_CPU_SUBTYPE_SH7724),y)
+IMAGE_ADDRESS	:= 0xe5200000 # ILRAM
+OBJECTS += $(obj)/mmcif-sh7724.o
+endif
+endif
+
+LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_ADDRESS) -e romstart \
 		   -T $(obj)/../../kernel/vmlinux.lds
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
--- 0002/arch/sh/boot/romimage/head.S
+++ work/arch/sh/boot/romimage/head.S	2010-05-13 22:24:55.000000000 +0900
@@ -4,14 +4,41 @@
  * Board specific setup code, executed before zImage loader
  */
 
+#include <asm/page.h>
+#include <cpu/addrspace.h>
+
 .text
-	#include <asm/page.h>
 
 	.global	romstart
 romstart:
 	/* include board specific setup code */
 #include <mach/romimage.h>
 
+#ifdef CONFIG_ROMIMAGE_MMCIF
+	mov.l	load_mem_base, r4
+	mov.l	bytes_to_load, r5
+	mov.l	loader_function, r7
+	jsr	@r7
+	 mov	r4, r15
+
+	mov.l	load_mem_base, r4
+	mov.l	loaded_code_offs, r5
+	add	r4, r5
+	jmp	@r5
+	 nop
+
+        .balign 4
+load_mem_base:
+	.long	P1SEG | CONFIG_MEMORY_START | (1 << 20) /* 1 MiB offset */
+bytes_to_load:
+	.long	end_data - romstart
+loader_function:
+	.long	mmcif_loader
+loaded_code_offs:
+	.long	loaded_code - romstart
+loaded_code:
+#endif /* CONFIG_ROMIMAGE_MMCIF */
+
 	/* copy the empty_zero_page contents to where vmlinux expects it */
 	mova	extra_data_pos, r0
 	mov.l	extra_data_size, r1
--- /dev/null
+++ work/arch/sh/boot/romimage/mmcif-sh7724.c	2010-05-13 23:11:31.000000000 +0900
@@ -0,0 +1,94 @@
+/*
+ * sh7724 MMCIF loader
+ *
+ * Copyright (C) 2010 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/io.h>
+#include "../../../../drivers/sh/mmcif_loader.c"
+
+#define MMCIF_BASE      (void __iomem *)0xa4ca0000
+
+#define MSTPCR2		0xa4150038
+#define PGDR		0xa405012c
+#define PTWCR		0xa4050146
+#define PTXCR		0xa4050148
+#define PSELA		0xa405014e
+#define PSELE		0xa4050156
+#define HIZCRA		0xa4050158
+#define HIZCRC		0xa405015c
+#define DRVCRA		0xa405018a
+
+/* Ecovec board specific information:
+ *
+ * Set the following to enable MMCIF boot from the MMC card in CN12:
+ *
+ * DS1.5 = OFF (SH BOOT pin set to L)
+ * DS2.6 = OFF (Select MMCIF on CN12 instead of SDHI1)
+ * DS2.7 = ON  (Select MMCIF on CN12 instead of SDHI1)
+ *
+ */
+#ifdef CONFIG_SH_ECOVEC
+static void set_led(int nr)
+{
+	/* disable Hi-Z for LED pins */
+	__raw_writew(__raw_readw(HIZCRA) & ~(1 << 1), HIZCRA);
+
+	/* update progress on LED4, LED5, LED6 and LED7 */
+	__raw_writeb(1 << (nr - 1), PGDR);
+}
+#else
+#define set_led(nr) do { } while (0)
+#endif
+
+/* SH7724 specific MMCIF loader
+ *
+ * loads the romImage from an MMC card starting from block 512
+ * use the following line to write the romImage to an MMC card
+ * # dd if=arch/sh/boot/romImage of=/dev/sdx bsQ2 seekQ2
+ */
+void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
+{
+	/* update progress */
+	set_led(1);
+
+	/* enable clock to the MMCIF hardware block */
+	__raw_writel(__raw_readl(MSTPCR2) & ~0x20000000, MSTPCR2);
+
+	/* setup pins D7-D0 */
+	__raw_writew(0x0000, PTWCR);
+
+	/* setup pins MMC_CLK, MMC_CMD */
+	__raw_writew(__raw_readw(PTXCR) & ~0x000f, PTXCR);
+
+	/* select D3-D0 pin function */
+	__raw_writew(__raw_readw(PSELA) & ~0x2000, PSELA);
+
+	/* select D7-D4 pin function */
+	__raw_writew(__raw_readw(PSELE) & ~0x3000, PSELE);
+
+	/* disable Hi-Z for the MMC pins */
+	__raw_writew(__raw_readw(HIZCRC) & ~0x0620, HIZCRC);
+
+	/* high drive capability for MMC pins */
+	__raw_writew(__raw_readw(DRVCRA) | 0x3000, DRVCRA);
+
+	/* setup MMCIF hardware */
+	mmcif_init(MMCIF_BASE);
+
+	/* update progress */
+	set_led(2);
+
+	/* load kernel via MMCIF interface */
+	mmcif_slurp(MMCIF_BASE, buf, no_bytes);
+
+	/* disable clock to the MMCIF hardware block */
+	__raw_writel(__raw_readl(MSTPCR2) | 0x20000000, MSTPCR2);
+
+	/* update progress */
+	set_led(3);
+}
--- 0002/arch/sh/boot/romimage/vmlinux.scr
+++ work/arch/sh/boot/romimage/vmlinux.scr	2010-05-13 22:12:58.000000000 +0900
@@ -3,5 +3,6 @@ SECTIONS
   .text : {
 	zero_page_pos = .;
 	*(.data)
+	end_data = .;
 	}
 }
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7724.h	2010-05-13 22:17:05.000000000 +0900
@@ -9,6 +9,7 @@
  * MD3: BSC - Area0 Bus Width (16/32-bit) [CS0BCR.9,10]
  * MD5: BSC - Endian Mode (L: Big, H: Little) [CMNCR.3]
  * MD8: Test Mode
+ * BOOT: FBR - Boot Mode (L: MMCIF, H: Area0)
  */
 
 /* Pin Function Controller:
--- /dev/null
+++ work/drivers/sh/mmcif_loader.c	2010-05-13 22:55:23.000000000 +0900
@@ -0,0 +1,167 @@
+/*
+ * MMCIF loader
+ *
+ * Copyright (C) 2010 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/io.h>
+
+#define CE_CMD_SET 0x00
+#define CE_ARG 0x08
+#define CE_ARG_CMD12 0x0c
+#define CE_CMD_CTRL 0x10
+#define CE_BLOCK_SET 0x14
+#define CE_CLK_CTRL 0x18
+#define CE_BUF_ACC 0x1c
+#define CE_RESP3 0x20
+#define CE_RESP2 0x24
+#define CE_RESP1 0x28
+#define CE_RESP0 0x2c
+#define CE_RESP_CMD12 0x30
+#define CE_DATA 0x34
+#define CE_INT 0x40
+#define CE_INT_MASK 0x44
+#define CE_HOST_STS1 0x48
+#define CE_HOST_STS2 0x4c
+#define CE_VERSION 0x7c
+
+#define BLOCK_SIZE 512
+
+static unsigned long mmcif_read(void __iomem *base, int reg)
+{
+	return __raw_readl(base + reg);
+}
+
+static void mmcif_write(void __iomem *base, int reg, unsigned long value)
+{
+	__raw_writel(value, base + reg);
+}
+
+static void mmcif_cmd_send(void __iomem *base,
+			   unsigned long cmd, unsigned long arg)
+{
+	mmcif_write(base, CE_INT, 0);
+	mmcif_write(base, CE_ARG, arg);
+	mmcif_write(base, CE_CMD_SET, cmd);
+}
+
+static int mmcif_cmd_poll(void __iomem *base, unsigned long mask)
+{
+	unsigned long tmp;
+	int cnt;
+
+	for (cnt = 0; cnt < 1000000; cnt++) {
+		tmp = mmcif_read(base, CE_INT);
+		if (tmp & mask) {
+			mmcif_write(base, CE_INT, tmp & ~mask);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static int mmcif_cmd(void __iomem *base, unsigned long cmd, unsigned long arg)
+{
+	mmcif_cmd_send(base, cmd, arg);
+	return mmcif_cmd_poll(base, 0x00010000);
+}
+
+static int mmcif_do_read_single(void __iomem *base,
+				unsigned int block_nr,
+				unsigned long *buf)
+{
+	int k;
+
+	/* CMD13 - Status */
+	mmcif_cmd(base, 0x0d400000, 0x00010000);
+
+	if (mmcif_read(base, CE_RESP0) != 0x0900)
+		return -1;
+
+	/* CMD17 - Read */
+	mmcif_cmd(base, 0x11480000, block_nr * BLOCK_SIZE);
+	if (mmcif_cmd_poll(base, 0x00100000) < 0)
+		return -1;
+
+	for (k = 0; k < (BLOCK_SIZE / 4); k++)
+		buf[k] = mmcif_read(base, CE_DATA);
+
+	return 0;
+}
+
+static int mmcif_do_read(void __iomem *base,
+			 unsigned long first_block,
+			 unsigned long nr_blocks,
+			 void *buf)
+{
+	unsigned long k;
+	int ret = 0;
+
+	/* CMD16 - Set the block size */
+	mmcif_cmd(base, 0x10400000, BLOCK_SIZE);
+
+	for (k = 0; !ret && k < nr_blocks; k++)
+		ret = mmcif_do_read_single(base, first_block + k,
+				buf + (k * BLOCK_SIZE));
+
+	return ret;
+}
+
+static void mmcif_init(void __iomem *base)
+{
+	unsigned long tmp;
+
+	/* reset */
+	tmp = mmcif_read(base, CE_VERSION);
+	mmcif_write(base, CE_VERSION, tmp | 0x80000000);
+	mmcif_write(base, CE_VERSION, tmp & ~0x80000000);
+
+	/* byte swap */
+	mmcif_write(base, CE_BUF_ACC, 0x00010000);
+
+	/* Set block size in MMCIF hardware */
+	mmcif_write(base, CE_BLOCK_SET, BLOCK_SIZE);
+
+	/* Enable the clock, set it to Bus clock/256 (about 325Khz)*/
+	mmcif_write(base, CE_CLK_CTRL, 0x01072fff);
+
+	/* CMD0 */
+	mmcif_cmd(base, 0x00000040, 0);
+
+	/* CMD1 - Get OCR */
+	do {
+		mmcif_cmd(base, 0x01405040, 0x40300000); /* CMD1 */
+	} while ((mmcif_read(base, CE_RESP0) & 0x80000000) != 0x80000000);
+
+	/* CMD2 - Get CID */
+	mmcif_cmd(base, 0x02806040, 0);
+
+	/* CMD3 - Set card relative address */
+	mmcif_cmd(base, 0x03400040, 0x00010000);
+}
+
+static void mmcif_slurp(void __iomem *base,
+			unsigned char *buf,
+			unsigned long no_bytes)
+{
+	unsigned long tmp;
+
+	/* In data transfer mode: Set clock to Bus clock/4 (about 20Mhz) */
+	mmcif_write(base, CE_CLK_CTRL, 0x01012fff);
+
+	/* CMD9 - Get CSD */
+	mmcif_cmd(base, 0x09806000, 0x00010000);
+
+	/* CMD7 - Select the card */
+	mmcif_cmd(base, 0x07400000, 0x00010000);
+
+	tmp = no_bytes / BLOCK_SIZE;
+	tmp += (no_bytes % BLOCK_SIZE) ? 1 : 0;
+
+	mmcif_do_read(base, 512, tmp, buf);
+}

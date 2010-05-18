From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 May 2010 14:43:15 +0000
Subject: [PATCH 04/04] sh: add romImage MMCIF boot for sh7724 and Ecovec V2
Message-Id: <20100518144315.29239.91713.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch is V2 of the MMCIF romImage boot support
for sh7724 and the Ecovec board. With this patch
applied and CONFIG_ROMIMAGE_MMCIF selected the
romImage kernel image can be written to a MMC card
and booted directly by the sh7724 cpu.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1
 - major code update according to feedback from Paul Mundt

 arch/sh/Kconfig                               |   11 +++
 arch/sh/boot/romimage/Makefile                |   13 +++-
 arch/sh/boot/romimage/head.S                  |   30 ++++++++++
 arch/sh/boot/romimage/mmcif-sh7724.c          |   72 +++++++++++++++++++++++++
 arch/sh/boot/romimage/vmlinux.scr             |    1 
 arch/sh/include/cpu-sh4/cpu/sh7724.h          |    1 
 arch/sh/include/mach-common/mach/romimage.h   |   10 +++
 arch/sh/include/mach-ecovec24/mach/romimage.h |   27 +++++++++
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |   10 +++
 9 files changed, 171 insertions(+), 4 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2010-05-18 23:03:20.000000000 +0900
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
+++ work/arch/sh/boot/romimage/Makefile	2010-05-18 23:03:20.000000000 +0900
@@ -1,16 +1,21 @@
 #
 # linux/arch/sh/boot/romimage/Makefile
 #
-# create an image suitable for burning to flash from zImage
+# create an romImage file suitable for burning to flash/mmc from zImage
 #
 
 targets		:= vmlinux head.o zeropage.bin piggy.o
+load-y		:= 0
 
-OBJECTS = $(obj)/head.o
-LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext 0 -e romstart \
+mmcif-load-$(CONFIG_CPU_SUBTYPE_SH7724)	:= 0xe5200000 # ILRAM
+mmcif-obj-$(CONFIG_CPU_SUBTYPE_SH7724)	:= $(obj)/mmcif-sh7724.o
+load-$(CONFIG_ROMIMAGE_MMCIF)		:= $(mmcif-load-y)
+obj-$(CONFIG_ROMIMAGE_MMCIF)		:= $(mmcif-obj-y)
+
+LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(load-y) -e romstart \
 		   -T $(obj)/../../kernel/vmlinux.lds
 
-$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
+$(obj)/vmlinux: $(obj)/head.o $(obj-y) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
 	@:
 
--- 0002/arch/sh/boot/romimage/head.S
+++ work/arch/sh/boot/romimage/head.S	2010-05-18 23:12:43.000000000 +0900
@@ -12,6 +12,36 @@ romstart:
 	/* include board specific setup code */
 #include <mach/romimage.h>
 
+#ifdef CONFIG_ROMIMAGE_MMCIF
+	/* load the romImage to above the empty zero page */
+	mov.l	empty_zero_page_dst, r4
+	mov.l	empty_zero_page_dst_adj, r5
+	add	r5, r4
+	mov.l	bytes_to_load, r5
+	mov.l	loader_function, r7
+	jsr	@r7
+	 mov	r4, r15
+
+	mov.l	empty_zero_page_dst, r4
+	mov.l	empty_zero_page_dst_adj, r5
+	add	r5, r4
+	mov.l	loaded_code_offs, r5
+	add	r5, r4
+	jmp	@r4
+	 nop
+
+	.balign 4
+empty_zero_page_dst_adj:
+	.long	PAGE_SIZE
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
+++ work/arch/sh/boot/romimage/mmcif-sh7724.c	2010-05-18 23:03:21.000000000 +0900
@@ -0,0 +1,72 @@
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
+#include <linux/mmc/sh_mmcif.h>
+#include <mach/romimage.h>
+
+#define MMCIF_BASE      (void __iomem *)0xa4ca0000
+
+#define MSTPCR2		0xa4150038
+#define PTWCR		0xa4050146
+#define PTXCR		0xa4050148
+#define PSELA		0xa405014e
+#define PSELE		0xa4050156
+#define HIZCRC		0xa405015c
+#define DRVCRA		0xa405018a
+
+enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
+       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
+
+/* SH7724 specific MMCIF loader
+ *
+ * loads the romImage from an MMC card starting from block 512
+ * use the following line to write the romImage to an MMC card
+ * # dd if=arch/sh/boot/romImage of=/dev/sdx bsQ2 seekQ2
+ */
+asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
+{
+	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
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
+	mmcif_update_progress(MMCIF_PROGRESS_INIT);
+
+	/* setup MMCIF hardware */
+	sh_mmcif_boot_init(MMCIF_BASE);
+
+	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
+
+	/* load kernel via MMCIF interface */
+	sh_mmcif_boot_slurp(MMCIF_BASE, buf, no_bytes);
+
+	/* disable clock to the MMCIF hardware block */
+	__raw_writel(__raw_readl(MSTPCR2) | 0x20000000, MSTPCR2);
+
+	mmcif_update_progress(MMCIF_PROGRESS_DONE);
+}
--- 0002/arch/sh/boot/romimage/vmlinux.scr
+++ work/arch/sh/boot/romimage/vmlinux.scr	2010-05-18 23:03:20.000000000 +0900
@@ -3,5 +3,6 @@ SECTIONS
   .text : {
 	zero_page_pos = .;
 	*(.data)
+	end_data = .;
 	}
 }
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7724.h	2010-05-18 23:03:20.000000000 +0900
@@ -9,6 +9,7 @@
  * MD3: BSC - Area0 Bus Width (16/32-bit) [CS0BCR.9,10]
  * MD5: BSC - Endian Mode (L: Big, H: Little) [CMNCR.3]
  * MD8: Test Mode
+ * BOOT: FBR - Boot Mode (L: MMCIF, H: Area0)
  */
 
 /* Pin Function Controller:
--- 0001/arch/sh/include/mach-common/mach/romimage.h
+++ work/arch/sh/include/mach-common/mach/romimage.h	2010-05-18 23:03:20.000000000 +0900
@@ -1 +1,11 @@
+#ifdef __ASSEMBLY__
+
 /* do nothing here by default */
+
+#else /* __ASSEMBLY__ */
+
+extern inline void mmcif_update_progress(int nr)
+{
+}
+
+#endif /* __ASSEMBLY__ */
--- 0001/arch/sh/include/mach-ecovec24/mach/romimage.h
+++ work/arch/sh/include/mach-ecovec24/mach/romimage.h	2010-05-18 23:03:20.000000000 +0900
@@ -1,3 +1,5 @@
+#ifdef __ASSEMBLY__
+
 /* EcoVec board specific boot code:
  * converts the "partner-jet-script.txt" script into assembly
  * the assembly code is the first code to be executed in the romImage
@@ -18,3 +20,28 @@
 	.align 2
 1 :	.long 0xa8000000
 2 :
+
+#else /* __ASSEMBLY__ */
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
+#define HIZCRA		0xa4050158
+#define PGDR		0xa405012c
+
+extern inline void mmcif_update_progress(int nr)
+{
+	/* disable Hi-Z for LED pins */
+	__raw_writew(__raw_readw(HIZCRA) & ~(1 << 1), HIZCRA);
+
+	/* update progress on LED4, LED5, LED6 and LED7 */
+	__raw_writeb(1 << (nr - 1), PGDR);
+}
+
+#endif /* __ASSEMBLY__ */
--- 0001/arch/sh/include/mach-kfr2r09/mach/romimage.h
+++ work/arch/sh/include/mach-kfr2r09/mach/romimage.h	2010-05-18 23:03:20.000000000 +0900
@@ -1,3 +1,5 @@
+#ifdef __ASSEMBLY__
+
 /* kfr2r09 board specific boot code:
  * converts the "partner-jet-script.txt" script into assembly
  * the assembly code is the first code to be executed in the romImage
@@ -18,3 +20,11 @@
 	.align 2
 1:	.long 0xa8000000
 2:
+
+#else /* __ASSEMBLY__ */
+
+extern inline void mmcif_update_progress(int nr)
+{
+}
+
+#endif /* __ASSEMBLY__ */

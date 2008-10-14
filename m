From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 14 Oct 2008 12:23:26 +0000
Subject: [RESEND][PATCH v2] mtd: sh_flctl: add support for Renesas SuperH FLCTL
Message-Id: <48F48F3E.3080806@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw2@infradead.org
Cc: lethal@linux-sh.org, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Several Renesas SuperH CPU has FLCTL. The FLCTL support NAND Flash.
This driver support SH7723.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---

PATCH v2:
 - fix size of ioremap().

 drivers/mtd/nand/Kconfig     |    7 +
 drivers/mtd/nand/Makefile    |    1 +
 drivers/mtd/nand/sh_flctl.c  |  878 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/sh_flctl.h |  125 ++++++
 4 files changed, 1011 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/sh_flctl.c
 create mode 100644 include/linux/mtd/sh_flctl.h

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 41f361c..c3182de 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -406,4 +406,11 @@ config MTD_NAND_FSL_UPM
 	  Enables support for NAND Flash chips wired onto Freescale PowerPC
 	  processor localbus with User-Programmable Machine support.

+config MTD_NAND_SH_FLCTL
+	tristate "Support for NAND on Renesas SuperH FLCTL"
+	depends on MTD_NAND && SUPERH && CPU_SUBTYPE_SH7723
+	help
+	  Several Renesas SuperH CPU has FLCTL. This option enables support
+	  for NAND Flash using FLCTL. This driver support SH7723.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index b786c5d..2cc2d58 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
 obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_ELBC)		+= fsl_elbc_nand.o
 obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
+obj-$(CONFIG_MTD_NAND_SH_FLCTL)		+= sh_flctl.o

 nand-objs := nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
new file mode 100644
index 0000000..4cdb83d
--- /dev/null
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -0,0 +1,878 @@
+/*
+ * SuperH FLCTL nand controller
+ *
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ * Copyright (C) 2008 Atom Create Engineering Co., Ltd.
+ *
+ * Based on fsl_elbc_nand.c, Copyright (c) 2006-2007 Freescale Semiconductor
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/sh_flctl.h>
+
+static struct nand_ecclayout flctl_4secc_oob_16 = {
+	.eccbytes = 10,
+	.eccpos = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
+	.oobfree = {
+		{.offset = 12,
+		. length = 4} },
+};
+
+static struct nand_ecclayout flctl_4secc_oob_64 = {
+	.eccbytes = 10,
+	.eccpos = {48, 49, 50, 51, 52, 53, 54, 55, 56, 57},
+	.oobfree = {
+		{.offset = 60,
+		. length = 4} },
+};
+
+static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
+
+static struct nand_bbt_descr flctl_4secc_smallpage = {
+	.options = NAND_BBT_SCAN2NDPAGE,
+	.offs = 11,
+	.len = 1,
+	.pattern = scan_ff_pattern,
+};
+
+static struct nand_bbt_descr flctl_4secc_largepage = {
+	.options = 0,
+	.offs = 58,
+	.len = 2,
+	.pattern = scan_ff_pattern,
+};
+
+static void empty_fifo(struct sh_flctl *flctl)
+{
+	writel(0x000c0000, FLINTDMACR(flctl));	/* FIFO Clear */
+	writel(0x00000000, FLINTDMACR(flctl));	/* Clear Error flags */
+}
+
+static void start_translation(struct sh_flctl *flctl)
+{
+	writeb(TRSTRT, FLTRCR(flctl));
+}
+
+static void wait_completion(struct sh_flctl *flctl)
+{
+	u32 timeout = LOOP_TIMEOUT_MAX;
+
+	while (timeout--) {
+		if (readb(FLTRCR(flctl)) & TREND) {
+			writeb(0x0, FLTRCR(flctl));
+			return;
+		}
+		udelay(1);
+	}
+
+	printk(KERN_ERR "wait_completion(): Timeout occured \n");
+	writeb(0x0, FLTRCR(flctl));
+}
+
+static void set_addr(struct mtd_info *mtd, int column, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	u32 addr = 0;
+
+	if (column = -1) {
+		addr = page_addr;	/* ERASE1 */
+	} else if (page_addr != -1) {
+		/* SEQIN, READ0, etc.. */
+		if (flctl->page_size) {
+			addr = column & 0x0FFF;
+			addr |= (page_addr & 0xff) << 16;
+			addr |= ((page_addr >> 8) & 0xff) << 24;
+			/* big than 128MB */
+			if (flctl->rw_ADRCNT = ADRCNT2_E) {
+				u32 	addr2;
+				addr2 = (page_addr >> 16) & 0xff;
+				writel(addr2, FLADR2(flctl));
+			}
+		} else {
+			addr = column;
+			addr |= (page_addr & 0xff) << 8;
+			addr |= ((page_addr >> 8) & 0xff) << 16;
+			addr |= ((page_addr >> 16) & 0xff) << 24;
+		}
+	}
+	writel(addr, FLADR(flctl));
+}
+
+static void wait_rfifo_ready(struct sh_flctl *flctl)
+{
+	u32 timeout = LOOP_TIMEOUT_MAX;
+
+	while (timeout--) {
+		u32 val;
+		/* check FIFO */
+		val = readl(FLDTCNTR(flctl)) >> 16;
+		if (val & 0xFF)
+			return;
+		udelay(1);
+	}
+	printk(KERN_ERR "wait_rfifo_ready(): Timeout occured \n");
+}
+
+static void wait_wfifo_ready(struct sh_flctl *flctl)
+{
+	u32 len, timeout = LOOP_TIMEOUT_MAX;
+
+	while (timeout--) {
+		/* check FIFO */
+		len = (readl(FLDTCNTR(flctl)) >> 16) & 0xFF;
+		if (len >= 4)
+			return;
+		udelay(1);
+	}
+	printk(KERN_ERR "wait_wfifo_ready(): Timeout occured \n");
+}
+
+static int wait_recfifo_ready(struct sh_flctl *flctl)
+{
+	u32 timeout = LOOP_TIMEOUT_MAX;
+	int checked[4];
+	void __iomem *ecc_reg[4];
+	int i;
+	u32 data, size;
+
+	memset(checked, 0, sizeof(checked));
+
+	while (timeout--) {
+		size = readl(FLDTCNTR(flctl)) >> 24;
+		if (size & 0xFF)
+			return 0;	/* success */
+
+		if (readl(FL4ECCCR(flctl)) & _4ECCFA)
+			return 1;	/* can't correct */
+
+		udelay(1);
+		if (!(readl(FL4ECCCR(flctl)) & _4ECCEND))
+			continue;
+
+		/* start error correction */
+		ecc_reg[0] = FL4ECCRESULT0(flctl);
+		ecc_reg[1] = FL4ECCRESULT1(flctl);
+		ecc_reg[2] = FL4ECCRESULT2(flctl);
+		ecc_reg[3] = FL4ECCRESULT3(flctl);
+
+		for (i = 0; i < 3; i++) {
+			data = readl(ecc_reg[i]);
+			if (data != INIT_FL4ECCRESULT_VAL && !checked[i]) {
+				u8 org;
+				int index;
+
+				index = data >> 16;
+				org = flctl->done_buff[index];
+				flctl->done_buff[index] = org ^ (data & 0xFF);
+				checked[i] = 1;
+			}
+		}
+
+		writel(0, FL4ECCCR(flctl));
+	}
+
+	printk(KERN_ERR "wait_recfifo_ready(): Timeout occured \n");
+	return 1;	/* timeout */
+}
+
+static void wait_wecfifo_ready(struct sh_flctl *flctl)
+{
+	u32 timeout = LOOP_TIMEOUT_MAX;
+	u32 len;
+
+	while (timeout--) {
+		/* check FLECFIFO */
+		len = (readl(FLDTCNTR(flctl)) >> 24) & 0xFF;
+		if (len >= 4)
+			return;
+		udelay(1);
+	}
+	printk(KERN_ERR "wait_wecfifo_ready(): Timeout occured \n");
+}
+
+static void read_datareg(struct sh_flctl *flctl, int offset)
+{
+	unsigned long data;
+	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
+
+	wait_completion(flctl);
+
+	data = readl(FLDATAR(flctl));
+	*buf = le32_to_cpu(data);
+}
+
+static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
+{
+	int i, len_4align;
+	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
+	void *fifo_addr = (void *)FLDTFIFO(flctl);
+
+	len_4align = (rlen + 3) / 4;
+
+	for (i = 0; i < len_4align; i++) {
+		wait_rfifo_ready(flctl);
+		buf[i] = readl(fifo_addr);
+		buf[i] = be32_to_cpu(buf[i]);
+	}
+}
+
+static int read_ecfiforeg(struct sh_flctl *flctl, u8 *buff)
+{
+	int i;
+	unsigned long *ecc_buf = (unsigned long *)buff;
+	void *fifo_addr = (void *)FLECFIFO(flctl);
+
+	for (i = 0; i < 4; i++) {
+		if (wait_recfifo_ready(flctl))
+			return 1;
+		ecc_buf[i] = readl(fifo_addr);
+		ecc_buf[i] = be32_to_cpu(ecc_buf[i]);
+	}
+
+	return 0;
+}
+
+static void write_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
+{
+	int i, len_4align;
+	unsigned long *data = (unsigned long *)&flctl->done_buff[offset];
+	void *fifo_addr = (void *)FLDTFIFO(flctl);
+
+	len_4align = (rlen + 3) / 4;
+	for (i = 0; i < len_4align; i++) {
+		wait_wfifo_ready(flctl);
+		writel(cpu_to_be32(data[i]), fifo_addr);
+	}
+}
+
+static void set_cmd_regs(struct mtd_info *mtd, u32 cmd, u32 flcmcdr_val)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	u32 flcmncr_val = readl(FLCMNCR(flctl));
+	u32 flcmdcr_val, addr_len_bytes = 0;
+
+	/* Set SNAND bit if page size is 2048byte */
+	if (flctl->page_size)
+		flcmncr_val |= SNAND_E;
+	else
+		flcmncr_val &= ~SNAND_E;
+
+	/* default FLCMDCR val */
+	flcmdcr_val = DOCMD1_E | DOADR_E;
+
+	/* Set for FLCMDCR */
+	switch (cmd) {
+	case NAND_CMD_ERASE1:
+		addr_len_bytes = flctl->erase_ADRCNT;
+		flcmdcr_val |= DOCMD2_E;
+		break;
+	case NAND_CMD_READ0:
+	case NAND_CMD_READOOB:
+		addr_len_bytes = flctl->rw_ADRCNT;
+		flcmdcr_val |= CDSRC_E;
+		break;
+	case NAND_CMD_SEQIN:
+		/* This case is that cmd is READ0 or READ1 or READ00 */
+		flcmdcr_val &= ~DOADR_E;	/* ONLY execute 1st cmd */
+		break;
+	case NAND_CMD_PAGEPROG:
+		addr_len_bytes = flctl->rw_ADRCNT;

+		flcmdcr_val |= DOCMD2_E | CDSRC_E | SELRW;
+		break;
+	case NAND_CMD_READID:
+		flcmncr_val &= ~SNAND_E;
+		addr_len_bytes = ADRCNT_1;
+		break;
+	case NAND_CMD_STATUS:
+	case NAND_CMD_RESET:
+		flcmncr_val &= ~SNAND_E;
+		flcmdcr_val &= ~(DOADR_E | DOSR_E);
+		break;
+	default:
+		break;
+	}
+
+	/* Set address bytes parameter */
+	flcmdcr_val |= addr_len_bytes;
+
+	/* Now actually write */
+	writel(flcmncr_val, FLCMNCR(flctl));
+	writel(flcmdcr_val, FLCMDCR(flctl));
+	writel(flcmcdr_val, FLCMCDR(flctl));
+}
+
+static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+				uint8_t *buf)
+{
+	int i, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	uint8_t *p = buf;
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+
+	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
+		chip->read_buf(mtd, p, eccsize);
+
+	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
+		if (flctl->hwecc_cant_correct[i])
+			mtd->ecc_stats.failed++;
+		else
+			mtd->ecc_stats.corrected += 0;
+	}
+
+	return 0;
+}
+
+static void flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+				   const uint8_t *buf)
+{
+	int i, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	const uint8_t *p = buf;
+
+	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
+		chip->write_buf(mtd, p, eccsize);
+}
+
+static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int sector, page_sectors;
+
+	if (flctl->page_size)
+		page_sectors = 4;
+	else
+		page_sectors = 1;
+
+	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE | _4ECCCORRECT,
+		 FLCMNCR(flctl));
+
+	set_cmd_regs(mtd, NAND_CMD_READ0,
+		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
+
+	for (sector = 0; sector < page_sectors; sector++) {
+		int ret;
+
+		empty_fifo(flctl);
+		writel(readl(FLCMDCR(flctl)) | 1, FLCMDCR(flctl));
+		writel(page_addr << 2 | sector, FLADR(flctl));
+
+		start_translation(flctl);
+		read_fiforeg(flctl, 512, 512 * sector);
+
+		ret = read_ecfiforeg(flctl,
+			&flctl->done_buff[mtd->writesize + 16 * sector]);
+
+		if (ret)
+			flctl->hwecc_cant_correct[sector] = 1;
+
+		writel(0x0, FL4ECCCR(flctl));
+		wait_completion(flctl);
+	}
+	writel(readl(FLCMNCR(flctl)) & ~(ACM_SACCES_MODE | _4ECCCORRECT),
+			FLCMNCR(flctl));
+}
+
+static void execmd_read_oob(struct mtd_info *mtd, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+
+	set_cmd_regs(mtd, NAND_CMD_READ0,
+		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
+
+	empty_fifo(flctl);
+	if (flctl->page_size) {
+		int i;
+		/* In case that the page size is 2k */
+		for (i = 0; i < 16 * 3; i++)
+			flctl->done_buff[i] = 0xFF;
+
+		set_addr(mtd, 3 * 528 + 512, page_addr);
+		writel(16, FLDTCNTR(flctl));
+
+		start_translation(flctl);
+		read_fiforeg(flctl, 16, 16 * 3);
+		wait_completion(flctl);
+	} else {
+		/* In case that the page size is 512b */
+		set_addr(mtd, 512, page_addr);
+		writel(16, FLDTCNTR(flctl));
+
+		start_translation(flctl);
+		read_fiforeg(flctl, 16, 0);
+		wait_completion(flctl);
+	}
+}
+
+static void execmd_write_page_sector(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int i, page_addr = flctl->seqin_page_addr;
+	int sector, page_sectors;
+
+	if (flctl->page_size)
+		page_sectors = 4;
+	else
+		page_sectors = 1;
+
+	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE, FLCMNCR(flctl));
+
+	set_cmd_regs(mtd, NAND_CMD_PAGEPROG,
+			(NAND_CMD_PAGEPROG << 8) | NAND_CMD_SEQIN);
+
+	for (sector = 0; sector < page_sectors; sector++) {
+		empty_fifo(flctl);
+		writel(readl(FLCMDCR(flctl)) | 1, FLCMDCR(flctl));
+		writel(page_addr << 2 | sector, FLADR(flctl));
+
+		start_translation(flctl);
+		write_fiforeg(flctl, 512, 512 * sector);
+
+		for (i = 0; i < 4; i++) {
+			wait_wecfifo_ready(flctl); /* wait for write ready */
+			writel(0xFFFFFFFF, FLECFIFO(flctl));
+		}
+		wait_completion(flctl);
+	}
+
+	writel(readl(FLCMNCR(flctl)) & ~ACM_SACCES_MODE, FLCMNCR(flctl));
+}
+
+static void execmd_write_oob(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int page_addr = flctl->seqin_page_addr;
+	int sector, page_sectors;
+
+	if (flctl->page_size) {
+		sector = 3;
+		page_sectors = 4;
+	} else {
+		sector = 0;
+		page_sectors = 1;
+	}
+
+	set_cmd_regs(mtd, NAND_CMD_PAGEPROG,
+			(NAND_CMD_PAGEPROG << 8) | NAND_CMD_SEQIN);
+
+	for (; sector < page_sectors; sector++) {
+		empty_fifo(flctl);
+		set_addr(mtd, sector * 528 + 512, page_addr);
+		writel(16, FLDTCNTR(flctl));	/* set read size */
+
+		start_translation(flctl);
+		write_fiforeg(flctl, 16, 16 * sector);
+		wait_completion(flctl);
+	}
+}
+
+static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
+			int column, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	u32 read_cmd = 0;
+
+	flctl->read_bytes = 0;
+	if (command != NAND_CMD_PAGEPROG)
+		flctl->index = 0;
+
+	switch (command) {
+	case NAND_CMD_READ1:
+	case NAND_CMD_READ0:
+		if (flctl->hwecc) {
+			/* read page with hwecc */
+			execmd_read_page_sector(mtd, page_addr);
+			break;
+		}
+		empty_fifo(flctl);
+		if (flctl->page_size)
+			set_cmd_regs(mtd, command, (NAND_CMD_READSTART << 8)
+				| command);
+		else
+			set_cmd_regs(mtd, command, command);
+
+		set_addr(mtd, 0, page_addr);
+
+		flctl->read_bytes = mtd->writesize + mtd->oobsize;
+		flctl->index += column;
+		goto read_normal_exit;
+
+	case NAND_CMD_READOOB:
+		if (flctl->hwecc) {
+			/* read page with hwecc */
+			execmd_read_oob(mtd, page_addr);
+			break;
+		}
+
+		empty_fifo(flctl);
+		if (flctl->page_size) {
+			set_cmd_regs(mtd, command, (NAND_CMD_READSTART << 8)
+				| NAND_CMD_READ0);
+			set_addr(mtd, mtd->writesize, page_addr);
+		} else {
+			set_cmd_regs(mtd, command, command);
+			set_addr(mtd, 0, page_addr);
+		}
+		flctl->read_bytes = mtd->oobsize;
+		goto read_normal_exit;
+
+	case NAND_CMD_READID:
+		empty_fifo(flctl);
+		set_cmd_regs(mtd, command, command);
+		set_addr(mtd, 0, 0);
+
+		flctl->read_bytes = 4;
+		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
+		start_translation(flctl);
+		read_datareg(flctl, 0);	/* read and end */
+		break;
+
+	case NAND_CMD_ERASE1:
+		flctl->erase1_page_addr = page_addr;
+		break;
+
+	case NAND_CMD_ERASE2:
+		set_cmd_regs(mtd, NAND_CMD_ERASE1,
+			(command << 8) | NAND_CMD_ERASE1);
+		set_addr(mtd, -1, flctl->erase1_page_addr);
+		start_translation(flctl);
+		wait_completion(flctl);
+		break;
+
+	case NAND_CMD_SEQIN:
+		if (!flctl->page_size) {
+			/* output read command */
+			if (column >= mtd->writesize) {
+				column -= mtd->writesize;
+				read_cmd = NAND_CMD_READOOB;
+			} else if (column < 256) {
+				read_cmd = NAND_CMD_READ0;
+			} else {
+				column -= 256;
+				read_cmd = NAND_CMD_READ1;
+			}
+		}
+		flctl->seqin_column = column;
+		flctl->seqin_page_addr = page_addr;
+		flctl->seqin_read_cmd = read_cmd;
+		break;
+
+	case NAND_CMD_PAGEPROG:
+		empty_fifo(flctl);
+		if (!flctl->page_size) {
+			set_cmd_regs(mtd, NAND_CMD_SEQIN,
+					flctl->seqin_read_cmd);
+			set_addr(mtd, -1, -1);
+			writel(0, FLDTCNTR(flctl));	/* set 0 size */
+			start_translation(flctl);
+			wait_completion(flctl);
+		}
+		if (flctl->hwecc) {
+			/* write page with hwecc */
+			if (flctl->seqin_column = mtd->writesize)
+				execmd_write_oob(mtd);
+			else if (!flctl->seqin_column)
+				execmd_write_page_sector(mtd);
+			else
+				printk(KERN_ERR "Invalid address !?\n");
+			break;
+		}
+		set_cmd_regs(mtd, command, (command << 8) | NAND_CMD_SEQIN);
+		set_addr(mtd, flctl->seqin_column, flctl->seqin_page_addr);
+		writel(flctl->index, FLDTCNTR(flctl));	/* set write size */
+		start_translation(flctl);
+		write_fiforeg(flctl, flctl->index, 0);
+		wait_completion(flctl);
+		break;
+
+	case NAND_CMD_STATUS:
+		set_cmd_regs(mtd, command, command);
+		set_addr(mtd, -1, -1);
+
+		flctl->read_bytes = 1;
+		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
+		start_translation(flctl);
+		read_datareg(flctl, 0); /* read and end */
+		break;
+
+	case NAND_CMD_RESET:
+		set_cmd_regs(mtd, command, command);
+		set_addr(mtd, -1, -1);
+
+		writel(0, FLDTCNTR(flctl));	/* set 0 size */
+		start_translation(flctl);
+		wait_completion(flctl);
+		break;
+
+	default:
+		break;
+	}
+	return;
+
+read_normal_exit:
+	writel(flctl->read_bytes, FLDTCNTR(flctl));	/* set read size */
+	start_translation(flctl);
+	read_fiforeg(flctl, flctl->read_bytes, 0);
+	wait_completion(flctl);
+	return;
+}
+
+static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	u32 flcmncr_val = readl(FLCMNCR(flctl));
+
+	switch (chipnr) {
+	case -1:
+		flcmncr_val &= ~CE0_ENABLE;
+		writel(flcmncr_val, FLCMNCR(flctl));
+		break;
+	case 0:
+		flcmncr_val |= CE0_ENABLE;
+		writel(flcmncr_val, FLCMNCR(flctl));
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void flctl_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int i, index = flctl->index;
+
+	for (i = 0; i < len; i++)
+		flctl->done_buff[index + i] = buf[i];
+	flctl->index += len;
+}
+
+static u8 flctl_read_byte(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int index = flctl->index;
+	u8 data;
+
+	data = flctl->done_buff[index];
+	flctl->index++;
+	return data;
+}
+
+static void flctl_read_buf(struct mtd_info *mtd, u8 *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = flctl_read_byte(mtd);
+}
+
+static int flctl_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (buf[i] != flctl_read_byte(mtd))
+			return -EFAULT;
+	return 0;
+}
+
+static void flctl_register_init(struct sh_flctl *flctl, unsigned long val)
+{

+	writel(val, FLCMNCR(flctl));
+}
+
+static int flctl_chip_init_tail(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	struct nand_chip *chip = &flctl->chip;
+
+	if (mtd->writesize = 512) {
+		flctl->page_size = 0;
+		if (chip->chipsize > (32 << 20)) {
+			/* big than 32MB */
+			flctl->rw_ADRCNT = ADRCNT_4;
+			flctl->erase_ADRCNT = ADRCNT_3;
+		} else if (chip->chipsize > (2 << 16)) {
+			/* big than 128KB */
+			flctl->rw_ADRCNT = ADRCNT_3;
+			flctl->erase_ADRCNT = ADRCNT_2;
+		} else {
+			flctl->rw_ADRCNT = ADRCNT_2;
+			flctl->erase_ADRCNT = ADRCNT_1;
+		}
+	} else {
+		flctl->page_size = 1;
+		if (chip->chipsize > (128 << 20)) {
+			/* big than 128MB */
+			flctl->rw_ADRCNT = ADRCNT2_E;
+			flctl->erase_ADRCNT = ADRCNT_3;
+		} else if (chip->chipsize > (8 << 16)) {
+			/* big than 512KB */
+			flctl->rw_ADRCNT = ADRCNT_4;
+			flctl->erase_ADRCNT = ADRCNT_2;
+		} else {
+			flctl->rw_ADRCNT = ADRCNT_3;
+			flctl->erase_ADRCNT = ADRCNT_1;
+		}
+	}
+
+	if (flctl->hwecc) {
+		if (mtd->writesize = 512) {
+			chip->ecc.layout = &flctl_4secc_oob_16;
+			chip->badblock_pattern = &flctl_4secc_smallpage;
+		} else {
+			chip->ecc.layout = &flctl_4secc_oob_64;
+			chip->badblock_pattern = &flctl_4secc_largepage;
+		}
+
+		chip->ecc.size = 512;
+		chip->ecc.bytes = 10;
+		chip->ecc.read_page = flctl_read_page_hwecc;
+		chip->ecc.write_page = flctl_write_page_hwecc;
+		chip->ecc.mode = NAND_ECC_HW;
+
+		/* 4 symbols ECC enabled */
+		writel(readl(FLCMNCR(flctl)) | _4ECCEN | ECCPOS2 | ECCPOS_02,
+				FLCMNCR(flctl));
+	} else {
+		chip->ecc.mode = NAND_ECC_SOFT;
+	}
+
+	return 0;
+}
+
+static int __init flctl_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct sh_flctl *flctl;
+	struct mtd_info *flctl_mtd;
+	struct nand_chip *nand;
+	struct sh_flctl_platform_data *pdata;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata = NULL) {
+		printk(KERN_ERR "sh_flctl platform_data not found.\n");
+		return -ENODEV;
+	}
+
+	flctl = kzalloc(sizeof(struct sh_flctl), GFP_KERNEL);
+	if (!flctl) {
+		printk(KERN_ERR "Unable to allocate NAND MTD dev structure.\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		printk(KERN_ERR "%s: resource not found.\n", __func__);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	flctl->reg = ioremap(res->start, res->end - res->start + 1);
+	if (flctl->reg = NULL) {
+		printk(KERN_ERR "%s: ioremap error.\n", __func__);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, flctl);
+	flctl_mtd = &flctl->mtd;
+	nand = &flctl->chip;
+	flctl_mtd->priv = nand;
+	flctl->hwecc = pdata->has_hwecc;
+
+	flctl_register_init(flctl, pdata->flcmncr_val);
+
+	nand->options = NAND_NO_AUTOINCR;
+
+	/* Set address of hardware control function */
+	/* 20 us command delay time */
+	nand->chip_delay = 20;
+
+	nand->read_byte = flctl_read_byte;
+	nand->write_buf = flctl_write_buf;
+	nand->read_buf = flctl_read_buf;
+	nand->verify_buf = flctl_verify_buf;
+	nand->select_chip = flctl_select_chip;
+	nand->cmdfunc = flctl_cmdfunc;
+
+	ret = nand_scan_ident(flctl_mtd, 1);
+	if (ret)
+		goto err;
+
+	ret = flctl_chip_init_tail(flctl_mtd);
+	if (ret)
+		goto err;
+
+	ret = nand_scan_tail(flctl_mtd);
+	if (ret)
+		goto err;
+
+	add_mtd_partitions(flctl_mtd, pdata->parts, pdata->nr_parts);
+
+	return 0;
+
+err:
+	kfree(flctl);
+	return ret;
+}
+
+static int __exit flctl_remove(struct platform_device *pdev)
+{
+	struct sh_flctl *flctl = platform_get_drvdata(pdev);
+
+	nand_release(&flctl->mtd);
+	kfree(flctl);
+
+	return 0;
+}
+
+static struct platform_driver flctl_driver = {
+	.probe		= flctl_probe,
+	.remove		= flctl_remove,
+	.driver = {
+		.name	= "sh_flctl",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init flctl_nand_init(void)
+{
+	return platform_driver_register(&flctl_driver);
+}
+
+static void __exit flctl_nand_cleanup(void)
+{
+	platform_driver_unregister(&flctl_driver);
+}
+
+module_init(flctl_nand_init);
+module_exit(flctl_nand_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yoshihiro Shimoda");
+MODULE_DESCRIPTION("SuperH FLCTL driver");
+MODULE_ALIAS("platform:sh_flctl");
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
new file mode 100644
index 0000000..d0ec3e3
--- /dev/null
+++ b/include/linux/mtd/sh_flctl.h
@@ -0,0 +1,125 @@
+/*
+ * SuperH FLCTL nand controller
+ *
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __SH_FLCTL_H__
+#define __SH_FLCTL_H__
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+/* FLCTL registers */
+#define FLCMNCR(f)		(f->reg + 0x0)
+#define FLCMDCR(f)		(f->reg + 0x4)
+#define FLCMCDR(f)		(f->reg + 0x8)
+#define FLADR(f)		(f->reg + 0xC)
+#define FLADR2(f)		(f->reg + 0x3C)
+#define FLDATAR(f)		(f->reg + 0x10)
+#define FLDTCNTR(f)		(f->reg + 0x14)
+#define FLINTDMACR(f)		(f->reg + 0x18)
+#define FLBSYTMR(f)		(f->reg + 0x1C)
+#define FLBSYCNT(f)		(f->reg + 0x20)
+#define FLDTFIFO(f)		(f->reg + 0x24)
+#define FLECFIFO(f)		(f->reg + 0x28)
+#define FLTRCR(f)		(f->reg + 0x2C)
+#define	FL4ECCRESULT0(f)	(f->reg + 0x80)
+#define	FL4ECCRESULT1(f)	(f->reg + 0x84)
+#define	FL4ECCRESULT2(f)	(f->reg + 0x88)
+#define	FL4ECCRESULT3(f)	(f->reg + 0x8C)
+#define	FL4ECCCR(f)		(f->reg + 0x90)
+#define	FL4ECCCNT(f)		(f->reg + 0x94)
+#define	FLERRADR(f)		(f->reg + 0x98)
+
+/* FLCMNCR control bits */
+#define ECCPOS2		(0x1 << 25)
+#define _4ECCCNTEN	(0x1 << 24)
+#define _4ECCEN		(0x1 << 23)
+#define _4ECCCORRECT	(0x1 << 22)
+#define SNAND_E		(0x1 << 18)	/* SNAND (0Q2 1 48)*/
+#define QTSEL_E		(0x1 << 17)
+#define ENDIAN		(0x1 << 16)	/* 1 = little endian */
+#define FCKSEL_E	(0x1 << 15)
+#define ECCPOS_00	(0x00 << 12)
+#define ECCPOS_01	(0x01 << 12)
+#define ECCPOS_02	(0x02 << 12)
+#define ACM_SACCES_MODE	(0x01 << 10)
+#define NANWF_E		(0x1 << 9)
+#define SE_D		(0x1 << 8)	/* Spare area disable */
+#define	CE1_ENABLE	(0x1 << 4)	/* Chip Enable 1 */
+#define	CE0_ENABLE	(0x1 << 3)	/* Chip Enable 0 */
+#define	TYPESEL_SET	(0x1 << 0)
+
+/* FLCMDCR control bits */
+#define ADRCNT2_E	(0x1 << 31)	/* 5byte address enable */
+#define ADRMD_E		(0x1 << 26)	/* Sector address access */
+#define CDSRC_E		(0x1 << 25)	/* Data buffer selection */
+#define DOSR_E		(0x1 << 24)	/* Status read check */
+#define SELRW		(0x1 << 21)	/*  0:read 1:write */
+#define DOADR_E		(0x1 << 20)	/* Address stage execute */
+#define ADRCNT_1	(0x00 << 18)	/* Address data bytes: 1byte */
+#define ADRCNT_2	(0x01 << 18)	/* Address data bytes: 2byte */
+#define ADRCNT_3	(0x02 << 18)	/* Address data bytes: 3byte */
+#define ADRCNT_4	(0x03 << 18)	/* Address data bytes: 4byte */
+#define DOCMD2_E	(0x1 << 17)	/* 2nd cmd stage execute */
+#define DOCMD1_E	(0x1 << 16)	/* 1st cmd stage execute */
+
+/* FLTRCR control bits */
+#define TRSTRT		(0x1 << 0)	/* translation start */
+#define TREND		(0x1 << 1)	/* translation end */
+
+/* FL4ECCCR control bits */
+#define	_4ECCFA		(0x1 << 2)	/* 4 symbols correct fault */
+#define	_4ECCEND	(0x1 << 1)	/* 4 symbols end */
+#define	_4ECCEXST	(0x1 << 0)	/* 4 symbols exist */
+
+#define INIT_FL4ECCRESULT_VAL	0x03FF03FF
+#define LOOP_TIMEOUT_MAX	0x00010000
+
+#define mtd_to_flctl(mtd)	container_of(mtd, struct sh_flctl, mtd)
+
+struct sh_flctl {
+	struct mtd_info		mtd;
+	struct nand_chip	chip;
+	void __iomem		*reg;
+
+	u8	done_buff[2048 + 64];	/* max size 2048 + 64 */
+	int	read_bytes;
+	int	index;
+	int	seqin_column;		/* column in SEQIN cmd */
+	int	seqin_page_addr;	/* page_addr in SEQIN cmd */
+	u32	seqin_read_cmd;		/* read cmd in SEQIN cmd */
+	int	erase1_page_addr;	/* page_addr in ERASE1 cmd */
+	u32	erase_ADRCNT;		/* bits of FLCMDCR in ERASE1 cmd */
+	u32	rw_ADRCNT;	/* bits of FLCMDCR in READ WRITE cmd */
+
+	int	hwecc_cant_correct[4];
+
+	unsigned page_size:1;	/* NAND page size (0 = 512, 1 = 2048) */
+	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
+};
+
+struct sh_flctl_platform_data {
+	struct mtd_partition	*parts;
+	int			nr_parts;
+	unsigned long		flcmncr_val;
+
+	unsigned has_hwecc:1;
+};
+
+#endif	/* __SH_FLCTL_H__ */
--
1.5.5

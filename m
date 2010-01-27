From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Jan 2010 09:17:21 +0000
Subject: [PATCH] mtd: sh_flctl SHBUSSEL and SEL_16BIT support
Message-Id: <20100127091721.21320.90312.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, shimoda.yoshihiro@renesas.com, dwmw2@infradead.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch extends the sh_flctl driver with support
for 16-bit bus configuration using SEL_16BIT and
support for multiplexed pins using SHBUSSEL.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mtd/nand/sh_flctl.c  |   27 ++++++++++++++++++++++++++-
 include/linux/mtd/sh_flctl.h |    2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

--- 0015/drivers/mtd/nand/sh_flctl.c
+++ work/drivers/mtd/nand/sh_flctl.c	2010-01-26 23:25:33.000000000 +0900
@@ -105,6 +105,8 @@ static void set_addr(struct mtd_info *mt
 		addr = page_addr;	/* ERASE1 */
 	} else if (page_addr != -1) {
 		/* SEQIN, READ0, etc.. */
+		if (flctl->chip.options & NAND_BUSWIDTH_16)
+			column >>= 1;
 		if (flctl->page_size) {
 			addr = column & 0x0FFF;
 			addr |= (page_addr & 0xff) << 16;
@@ -280,7 +282,7 @@ static void write_fiforeg(struct sh_flct
 static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_val)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	uint32_t flcmncr_val = readl(FLCMNCR(flctl));
+	uint32_t flcmncr_val = readl(FLCMNCR(flctl)) & ~SEL_16BIT;
 	uint32_t flcmdcr_val, addr_len_bytes = 0;
 
 	/* Set SNAND bit if page size is 2048byte */
@@ -302,6 +304,8 @@ static void set_cmd_regs(struct mtd_info
 	case NAND_CMD_READOOB:
 		addr_len_bytes = flctl->rw_ADRCNT;
 		flcmdcr_val |= CDSRC_E;
+		if (flctl->chip.options & NAND_BUSWIDTH_16)
+			flcmncr_val |= SEL_16BIT;
 		break;
 	case NAND_CMD_SEQIN:
 		/* This case is that cmd is READ0 or READ1 or READ00 */
@@ -310,6 +314,8 @@ static void set_cmd_regs(struct mtd_info
 	case NAND_CMD_PAGEPROG:
 		addr_len_bytes = flctl->rw_ADRCNT;
 		flcmdcr_val |= DOCMD2_E | CDSRC_E | SELRW;
+		if (flctl->chip.options & NAND_BUSWIDTH_16)
+			flcmncr_val |= SEL_16BIT;
 		break;
 	case NAND_CMD_READID:
 		flcmncr_val &= ~SNAND_E;
@@ -528,6 +534,8 @@ static void flctl_cmdfunc(struct mtd_inf
 		set_addr(mtd, 0, page_addr);
 
 		flctl->read_bytes = mtd->writesize + mtd->oobsize;
+		if (flctl->chip.options & NAND_BUSWIDTH_16)
+			column >>= 1;
 		flctl->index += column;
 		goto read_normal_exit;
 
@@ -691,6 +699,18 @@ static uint8_t flctl_read_byte(struct mt
 	return data;
 }
 
+static uint16_t flctl_read_word(struct mtd_info *mtd)
+{
+       struct sh_flctl *flctl = mtd_to_flctl(mtd);
+       int index = flctl->index;
+       uint16_t data;
+       uint16_t *buf = (uint16_t *)&flctl->done_buff[index];
+
+       data = *buf;
+       flctl->index += 2;
+       return data;
+}
+
 static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	int i;
@@ -829,6 +849,11 @@ static int __devinit flctl_probe(struct 
 	nand->select_chip = flctl_select_chip;
 	nand->cmdfunc = flctl_cmdfunc;
 
+	if (pdata->flcmncr_val & SEL_16BIT) {
+		nand->options |= NAND_BUSWIDTH_16;
+		nand->read_word = flctl_read_word;
+	}
+
 	ret = nand_scan_ident(flctl_mtd, 1);
 	if (ret)
 		goto err;
--- 0015/include/linux/mtd/sh_flctl.h
+++ work/include/linux/mtd/sh_flctl.h	2010-01-26 22:54:42.000000000 +0900
@@ -51,6 +51,8 @@
 #define _4ECCCNTEN	(0x1 << 24)
 #define _4ECCEN		(0x1 << 23)
 #define _4ECCCORRECT	(0x1 << 22)
+#define SHBUSSEL	(0x1 << 20)
+#define SEL_16BIT	(0x1 << 19)
 #define SNAND_E		(0x1 << 18)	/* SNAND (0Q2 1 48)*/
 #define QTSEL_E		(0x1 << 17)
 #define ENDIAN		(0x1 << 16)	/* 1 = little endian */

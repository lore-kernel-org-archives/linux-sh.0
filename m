From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 14 May 2012 12:14:47 +0000
Subject: [PATCH v4 8/8] mtd: sh_flctl: Use user oob data in hardware ECC mode
Message-Id: <1336997687-6868-9-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org

In hardware ecc mode, the flctl now writes and reads the oob data
provided by the user. Additionally the ECC is now returned in normal
page reads, not only when using the explicit NAND_CMD_READOOB command.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 631f7ed..8a07212 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -275,13 +275,12 @@ static void read_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 {
 	int i, len_4align;
 	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
-	void *fifo_addr = (void *)FLDTFIFO(flctl);
 
 	len_4align = (rlen + 3) / 4;
 
 	for (i = 0; i < len_4align; i++) {
 		wait_rfifo_ready(flctl);
-		buf[i] = readl(fifo_addr);
+		buf[i] = readl(FLDTFIFO(flctl));
 		buf[i] = be32_to_cpu(buf[i]);
 	}
 }
@@ -318,6 +317,18 @@ static void write_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
 	}
 }
 
+static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
+{
+	int i, len_4align;
+	unsigned long *data = (unsigned long *)&flctl->done_buff[offset];
+
+	len_4align = (rlen + 3) / 4;
+	for (i = 0; i < len_4align; i++) {
+		wait_wecfifo_ready(flctl);
+		writel(cpu_to_be32(data[i]), FLECFIFO(flctl));
+	}
+}
+
 static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_val)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
@@ -384,6 +395,7 @@ static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
 	chip->read_buf(mtd, buf, mtd->writesize);
+	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	return 0;
 }
 
@@ -391,6 +403,7 @@ static void flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				   const uint8_t *buf, int oob_required)
 {
 	chip->write_buf(mtd, buf, mtd->writesize);
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
 }
 
 static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
@@ -466,7 +479,7 @@ static void execmd_read_oob(struct mtd_info *mtd, int page_addr)
 static void execmd_write_page_sector(struct mtd_info *mtd)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	int i, page_addr = flctl->seqin_page_addr;
+	int page_addr = flctl->seqin_page_addr;
 	int sector, page_sectors;
 
 	page_sectors = flctl->page_size ? 4 : 1;
@@ -482,11 +495,7 @@ static void execmd_write_page_sector(struct mtd_info *mtd)
 
 	for (sector = 0; sector < page_sectors; sector++) {
 		write_fiforeg(flctl, 512, 512 * sector);
-
-		for (i = 0; i < 4; i++) {
-			wait_wecfifo_ready(flctl); /* wait for write ready */
-			writel(0xFFFFFFFF, FLECFIFO(flctl));
-		}
+		write_ec_fiforeg(flctl, 16, mtd->writesize + 16 * sector);
 	}
 
 	wait_completion(flctl);
-- 
1.7.5.4


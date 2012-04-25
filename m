From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 25 Apr 2012 14:03:35 +0000
Subject: [PATCH v2 07/10] mtd: sh_flctl: Group sector accesses into a single transfer
Message-Id: <1335362618-4559-8-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

When we use hardware ecc, the flctl is run in so-called "sector access
mode". We can bundle 4 sector accesses when using 2k page sizes to read
a whole page at once and speed up things.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |   44 ++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index b027370..96c88b8 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -368,25 +368,21 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	int sector, page_sectors;
 
-	if (flctl->page_size)
-		page_sectors = 4;
-	else
-		page_sectors = 1;
+	page_sectors = flctl->page_size ? 4 : 1;
+
+	set_cmd_regs(mtd, NAND_CMD_READ0,
+		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
 
 	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE | _4ECCCORRECT,
 		 FLCMNCR(flctl));
+	writel(readl(FLCMDCR(flctl)) | page_sectors, FLCMDCR(flctl));
+	writel(page_addr << 2, FLADR(flctl));
 
-	set_cmd_regs(mtd, NAND_CMD_READ0,
-		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
+	empty_fifo(flctl);
+	start_translation(flctl);
 
 	for (sector = 0; sector < page_sectors; sector++) {
 		int ret;
-
-		empty_fifo(flctl);
-		writel(readl(FLCMDCR(flctl)) | 1, FLCMDCR(flctl));
-		writel(page_addr << 2 | sector, FLADR(flctl));
-
-		start_translation(flctl);
 		read_fiforeg(flctl, 512, 512 * sector);
 
 		ret = read_ecfiforeg(flctl,
@@ -397,8 +393,10 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 			flctl->hwecc_cant_correct[sector] = 1;
 
 		writel(0x0, FL4ECCCR(flctl));
-		wait_completion(flctl);
 	}
+
+	wait_completion(flctl);
+
 	writel(readl(FLCMNCR(flctl)) & ~(ACM_SACCES_MODE | _4ECCCORRECT),
 			FLCMNCR(flctl));
 }
@@ -430,31 +428,27 @@ static void execmd_write_page_sector(struct mtd_info *mtd)
 	int i, page_addr = flctl->seqin_page_addr;
 	int sector, page_sectors;
 
-	if (flctl->page_size)
-		page_sectors = 4;
-	else
-		page_sectors = 1;
-
-	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE, FLCMNCR(flctl));
+	page_sectors = flctl->page_size ? 4 : 1;
 
 	set_cmd_regs(mtd, NAND_CMD_PAGEPROG,
 			(NAND_CMD_PAGEPROG << 8) | NAND_CMD_SEQIN);
 
-	for (sector = 0; sector < page_sectors; sector++) {
-		empty_fifo(flctl);
-		writel(readl(FLCMDCR(flctl)) | 1, FLCMDCR(flctl));
-		writel(page_addr << 2 | sector, FLADR(flctl));
+	empty_fifo(flctl);
+	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE, FLCMNCR(flctl));
+	writel(readl(FLCMDCR(flctl)) | page_sectors, FLCMDCR(flctl));
+	writel(page_addr << 2, FLADR(flctl));
+	start_translation(flctl);
 
-		start_translation(flctl);
+	for (sector = 0; sector < page_sectors; sector++) {
 		write_fiforeg(flctl, 512, 512 * sector);
 
 		for (i = 0; i < 4; i++) {
 			wait_wecfifo_ready(flctl); /* wait for write ready */
 			writel(0xFFFFFFFF, FLECFIFO(flctl));
 		}
-		wait_completion(flctl);
 	}
 
+	wait_completion(flctl);
 	writel(readl(FLCMNCR(flctl)) & ~ACM_SACCES_MODE, FLCMNCR(flctl));
 }
 
-- 
1.7.5.4


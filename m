From: Bastian Hecht <hechtb@googlemail.com>
Date: Fri, 20 Apr 2012 09:13:45 +0000
Subject: [PATCH 4/9] mtd: sh_flctl: Fix hardware ECC behaviour
Message-Id: <1334913230-23615-5-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

The flctl uses 10 bytes ECC data for every 512 bytes sector. This patch
makes the controller write all 40 bytes instead of 10 bytes only.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 411d783..c16479c 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -427,30 +427,20 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 static void execmd_read_oob(struct mtd_info *mtd, int page_addr)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int page_sectors = flctl->page_size ? 4 : 1;
+	int i;
 
 	set_cmd_regs(mtd, NAND_CMD_READ0,
 		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
 
 	empty_fifo(flctl);
-	if (flctl->page_size) {
-		int i;
-		/* In case that the page size is 2k */
-		for (i = 0; i < 16 * 3; i++)
-			flctl->done_buff[i] = 0xFF;
-
-		set_addr(mtd, 3 * 528 + 512, page_addr);
-		writel(16, FLDTCNTR(flctl));
 
-		start_translation(flctl);
-		read_fiforeg(flctl, 16, 16 * 3);
-		wait_completion(flctl);
-	} else {
-		/* In case that the page size is 512b */
-		set_addr(mtd, 512, page_addr);
+	for (i = 0; i < page_sectors; i++) {
+		set_addr(mtd, (512 + 16) * i + 512 , page_addr);
 		writel(16, FLDTCNTR(flctl));
 
 		start_translation(flctl);
-		read_fiforeg(flctl, 16, 0);
+		read_fiforeg(flctl, 16, 16 * i);
 		wait_completion(flctl);
 	}
 }
@@ -495,18 +485,12 @@ static void execmd_write_oob(struct mtd_info *mtd)
 	int page_addr = flctl->seqin_page_addr;
 	int sector, page_sectors;
 
-	if (flctl->page_size) {
-		sector = 3;
-		page_sectors = 4;
-	} else {
-		sector = 0;
-		page_sectors = 1;
-	}
+	page_sectors = flctl->page_size ? 4 : 1;
 
 	set_cmd_regs(mtd, NAND_CMD_PAGEPROG,
 			(NAND_CMD_PAGEPROG << 8) | NAND_CMD_SEQIN);
 
-	for (; sector < page_sectors; sector++) {
+	for (sector = 0; sector < page_sectors; sector++) {
 		empty_fifo(flctl);
 		set_addr(mtd, sector * 528 + 512, page_addr);
 		writel(16, FLDTCNTR(flctl));	/* set read size */
-- 
1.7.5.4


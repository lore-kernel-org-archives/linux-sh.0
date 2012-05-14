From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 14 May 2012 12:14:44 +0000
Subject: [PATCH v4 5/8] mtd: sh_flctl: Simplify the hardware ecc page read/write
Message-Id: <1336997687-6868-6-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org

As the equation mtd->writesize = eccsteps * eccsize holds, we can
simplify the code. The second loop of the 1st hunk is never entered,
so we delete it.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |   25 ++-----------------------
 1 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 642986f..b28b53f 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -353,35 +353,14 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_va
 static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
-	uint8_t *p = buf;
-	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-
-	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->read_buf(mtd, p, eccsize);
-
-	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
-		if (flctl->hwecc_cant_correct[i])
-			mtd->ecc_stats.failed++;
-		else
-			mtd->ecc_stats.corrected += 0; /* FIXME */
-	}
-
+	chip->read_buf(mtd, buf, mtd->writesize);
 	return 0;
 }
 
 static void flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				   const uint8_t *buf, int oob_required)
 {
-	int i, eccsize = chip->ecc.size;
-	int eccbytes = chip->ecc.bytes;
-	int eccsteps = chip->ecc.steps;
-	const uint8_t *p = buf;
-
-	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
-		chip->write_buf(mtd, p, eccsize);
+	chip->write_buf(mtd, buf, mtd->writesize);
 }
 
 static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
-- 
1.7.5.4


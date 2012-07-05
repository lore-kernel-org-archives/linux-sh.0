From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 05 Jul 2012 10:41:02 +0000
Subject: [PATCH 2/2] mtd: sh_flctl: Only copy OOB data if it is required
Message-Id: <1341484862-24033-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>

Check the new oob_required flag and only copy the OOB data to the internal
buffer if needed.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
I did this only for reading, as for writing the current code would write random data to the non-ECC OOB area when oob_required is false, so I preferred taking the data from the nand_base layer.

 drivers/mtd/nand/sh_flctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index e4f31ef..0b798fb 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -398,7 +398,8 @@ static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
 	chip->read_buf(mtd, buf, mtd->writesize);
-	chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
+	if (oob_required)
+		chip->read_buf(mtd, chip->oob_poi, mtd->oobsize);
 	return 0;
 }
 
-- 
1.7.9.5


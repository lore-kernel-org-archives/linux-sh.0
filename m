From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 25 Apr 2012 14:03:32 +0000
Subject: [PATCH v2 04/10] mtd: sh_flctl: Use different OOB layout
Message-Id: <1335362618-4559-5-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

The flctl hardware has changed and a new OOB layout must be adapted for
2k page size NAND chips when using hardware ECC.
The related bit fields ECCPOS[0-2] are gone - the bits are marked as
reserved now in the datasheet. As there are no official users of the
hardware ECC so far, they are completely removed.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c  |   18 ++++++++++++------
 include/linux/mtd/sh_flctl.h |    4 ----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index dd00853..dda34a2 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -44,11 +44,17 @@ static struct nand_ecclayout flctl_4secc_oob_16 = {
 };
 
 static struct nand_ecclayout flctl_4secc_oob_64 = {
-	.eccbytes = 10,
-	.eccpos = {48, 49, 50, 51, 52, 53, 54, 55, 56, 57},
+	.eccbytes = 4 * 10,
+	.eccpos = {
+		 6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+		38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
+		54, 55, 56, 57, 58, 59, 60, 61, 62, 63 },
 	.oobfree = {
-		{.offset = 60,
-		. length = 4} },
+		{.offset =  2, .length = 4},
+		{.offset = 16, .length = 6},
+		{.offset = 32, .length = 6},
+		{.offset = 48, .length = 6} },
 };
 
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
@@ -62,7 +68,7 @@ static struct nand_bbt_descr flctl_4secc_smallpage = {
 
 static struct nand_bbt_descr flctl_4secc_largepage = {
 	.options = NAND_BBT_SCAN2NDPAGE,
-	.offs = 58,
+	.offs = 0,
 	.len = 2,
 	.pattern = scan_ff_pattern,
 };
@@ -831,7 +837,7 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 		chip->ecc.mode = NAND_ECC_HW;
 
 		/* 4 symbols ECC enabled */
-		flctl->flcmncr_base |= _4ECCEN | ECCPOS2 | ECCPOS_02;
+		flctl->flcmncr_base |= _4ECCEN;
 	} else {
 		chip->ecc.mode = NAND_ECC_SOFT;
 	}
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 2daa43e..3feaae0 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -49,7 +49,6 @@
 #define	FLERRADR(f)		(f->reg + 0x98)
 
 /* FLCMNCR control bits */
-#define ECCPOS2		(0x1 << 25)
 #define _4ECCCNTEN	(0x1 << 24)
 #define _4ECCEN		(0x1 << 23)
 #define _4ECCCORRECT	(0x1 << 22)
@@ -59,9 +58,6 @@
 #define QTSEL_E		(0x1 << 17)
 #define ENDIAN		(0x1 << 16)	/* 1 = little endian */
 #define FCKSEL_E	(0x1 << 15)
-#define ECCPOS_00	(0x00 << 12)
-#define ECCPOS_01	(0x01 << 12)
-#define ECCPOS_02	(0x02 << 12)
 #define ACM_SACCES_MODE	(0x01 << 10)
 #define NANWF_E		(0x1 << 9)
 #define SE_D		(0x1 << 8)	/* Spare area disable */
-- 
1.7.5.4


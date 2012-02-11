From: Bastian Hecht <hechtb@googlemail.com>
Date: Sat, 11 Feb 2012 11:45:04 +0000
Subject: [PATCH v2 6/7] mtd: sh_flctl: Add FLHOLDCR register
Message-Id: <1328960705-18699-7-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Add a register used in new FLCTL hardware and a feature flag for it.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: the write to the register has been moved due to patch 5.

 drivers/mtd/nand/sh_flctl.c  |    3 +++
 include/linux/mtd/sh_flctl.h |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 1af41fd..40dda26 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -688,6 +688,8 @@ static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 		break;
 	case 0:
 		writel(flctl->flcmncr_val | CE0_ENABLE, FLCMNCR(flctl));
+		if (flctl->holden)
+			writel(HOLDEN, FLHOLDCR(flctl));
 		break;
 	default:
 		BUG();
@@ -845,6 +847,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	flctl->pdev = pdev;
 	flctl->flcmncr_val = pdata->flcmncr_val;
 	flctl->hwecc = pdata->has_hwecc;
+	flctl->holden = pdata->use_holden;
 
 	nand->options = NAND_NO_AUTOINCR;
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 107fd8a..6046443 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -38,6 +38,7 @@
 #define FLDTFIFO(f)		(f->reg + 0x24)
 #define FLECFIFO(f)		(f->reg + 0x28)
 #define FLTRCR(f)		(f->reg + 0x2C)
+#define FLHOLDCR(f)		(f->reg + 0x38)
 #define	FL4ECCRESULT0(f)	(f->reg + 0x80)
 #define	FL4ECCRESULT1(f)	(f->reg + 0x84)
 #define	FL4ECCRESULT2(f)	(f->reg + 0x88)
@@ -109,6 +110,15 @@
 #define TRSTRT		(0x1 << 0)	/* translation start */
 #define TREND		(0x1 << 1)	/* translation end */
 
+/*
+ * FLHOLDCR control bits
+ *
+ * HOLDEN: Bus Occupancy Enable (inverted)
+ * Enable this bit when the external bus might be used in between transfers.
+ * If not set and the bus gets used by other modules, a deadlock occurs.
+ */
+#define HOLDEN		(0x1 << 0)
+
 /* FL4ECCCR control bits */
 #define	_4ECCFA		(0x1 << 2)	/* 4 symbols correct fault */
 #define	_4ECCEND	(0x1 << 1)	/* 4 symbols end */
@@ -138,6 +148,7 @@ struct sh_flctl {
 
 	unsigned page_size:1;	/* NAND page size (0 = 512, 1 = 2048) */
 	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
+	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
 };
 
 struct sh_flctl_platform_data {
@@ -146,6 +157,7 @@ struct sh_flctl_platform_data {
 	unsigned long		flcmncr_val;
 
 	unsigned has_hwecc:1;
+	unsigned use_holden:1;
 };
 
 static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
-- 
1.7.5.4


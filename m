From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 08 Feb 2012 12:16:49 +0000
Subject: [PATCH 5/7] mtd: sh_flctl: Add FLHOLDCR register
Message-Id: <1328703411-3452-5-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com

Add a register used in new FLCTL hardware and a feature flag for it.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c  |    3 +++
 include/linux/mtd/sh_flctl.h |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 5c3e71f..70ca40d 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -751,6 +751,8 @@ static int flctl_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
 static void flctl_register_init(struct sh_flctl *flctl, unsigned long val)
 {
 	writel(val, FLCMNCR(flctl));
+	if (flctl->holden)
+		writel(HOLDEN, FLHOLDCR(flctl));
 }
 
 static int flctl_chip_init_tail(struct mtd_info *mtd)
@@ -852,6 +854,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	flctl_mtd->priv = nand;
 	flctl->pdev = pdev;
 	flctl->hwecc = pdata->has_hwecc;
+	flctl->holden = pdata->use_holden;
 
 	flctl_register_init(flctl, pdata->flcmncr_val);
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index ecbf3e6..fc77017 100644
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
@@ -137,6 +147,7 @@ struct sh_flctl {
 
 	unsigned page_size:1;	/* NAND page size (0 = 512, 1 = 2048) */
 	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
+	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
 };
 
 struct sh_flctl_platform_data {
@@ -145,6 +156,7 @@ struct sh_flctl_platform_data {
 	unsigned long		flcmncr_val;
 
 	unsigned has_hwecc:1;
+	unsigned use_holden:1;
 };
 
 static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
-- 
1.7.5.4


From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 24 May 2011 07:16:21 +0000
Subject: [PATCH 3/3] sh_mobile_meram: Back up and restore device registers on suspend
Message-Id: <1306221381-30083-4-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_meram.c |   85 +++++++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_meram.h |    8 ----
 2 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sh_mobile_meram.c b/drivers/video/sh_mobile_meram.c
index 25b4a88..867a2ed 100644
--- a/drivers/video/sh_mobile_meram.c
+++ b/drivers/video/sh_mobile_meram.c
@@ -37,6 +37,39 @@
 #define MEQSEL1 0x40
 #define MEQSEL2 0x44
 
+#define WRITEBACK_DONE	0x40
+#define WRITE_DONE	0x20
+#define READ_DONE	0x10
+
+#define ALL_TRANS_DONE	(WRITEBACK_DONE | WRITE_DONE | READ_DONE)
+
+static unsigned long common_regs[] = {
+	MEVCR1,
+	MEQSEL1,
+	MEQSEL2,
+};
+#define CMN_REGS_SIZE ARRAY_SIZE(common_regs)
+
+static unsigned long icb_regs[] = {
+	MExxCTL,
+	MExxBSIZE,
+	MExxMNCF,
+	MExxSARA,
+	MExxSARB,
+	MExxSBSIZE,
+};
+#define ICB_REGS_SIZE ARRAY_SIZE(icb_regs)
+
+struct sh_mobile_meram_priv {
+	void __iomem	*base;
+	struct mutex	lock;
+	unsigned long	used_icb;
+	int		used_meram_cache_regions;
+	unsigned long	used_meram_cache[SH_MOBILE_MERAM_ICB_NUM];
+	unsigned long	cmn_saved_regs[CMN_REGS_SIZE];
+	unsigned long	icb_saved_regs[ICB_REGS_SIZE * SH_MOBILE_MERAM_ICB_NUM];
+};
+
 /* settings */
 #define MERAM_SEC_LINE 15
 #define MERAM_LINE_WIDTH 2048
@@ -481,6 +514,57 @@ int sh_mobile_meram_clk_off(struct sh_mobile_meram_info *pdata)
 	return 0;
 }
 
+static int sh_mobile_meram_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
+	int k, j;
+
+	for (k = 0; k < CMN_REGS_SIZE; k++)
+		priv->cmn_saved_regs[k] = meram_read_reg(priv->base,
+			common_regs[k]);
+
+	for (j = 0; j < 32; j++) {
+		if (!test_bit(j, &priv->used_icb))
+			continue;
+		for (k = 0; k < ICB_REGS_SIZE; k++) {
+			priv->icb_saved_regs[j * ICB_REGS_SIZE + k] +				meram_read_icb(priv->base, j, icb_regs[k]);
+			/* Reset ICB on resume */
+			if (icb_regs[k] = MExxCTL)
+				priv->icb_saved_regs[j * ICB_REGS_SIZE + k] |+					ALL_TRANS_DONE;
+		}
+	}
+	return 0;
+}
+
+static int sh_mobile_meram_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mobile_meram_priv *priv = platform_get_drvdata(pdev);
+	int k, j;
+
+	for (j = 0; j < 32; j++) {
+		if (!test_bit(j, &priv->used_icb))
+			continue;
+		for (k = 0; k < ICB_REGS_SIZE; k++) {
+			meram_write_icb(priv->base, j, icb_regs[k],
+			priv->icb_saved_regs[j * ICB_REGS_SIZE + k]);
+		}
+	}
+
+	for (k = 0; k < CMN_REGS_SIZE; k++)
+		meram_write_reg(priv->base, common_regs[k],
+			priv->cmn_saved_regs[k]);
+	return 0;
+}
+
+static const struct dev_pm_ops sh_mobile_meram_dev_pm_ops = {
+	.runtime_suspend = sh_mobile_meram_runtime_suspend,
+	.runtime_resume = sh_mobile_meram_runtime_resume,
+};
+
 static struct sh_mobile_meram_ops sh_mobile_meram_ops = {
 	.module			= THIS_MODULE,
 	.meram_register		= sh_mobile_meram_register,
@@ -571,6 +655,7 @@ static struct platform_driver sh_mobile_meram_driver = {
 	.driver	= {
 		.name		= "sh_mobile_meram",
 		.owner		= THIS_MODULE,
+		.pm		= &sh_mobile_meram_dev_pm_ops,
 	},
 	.probe		= sh_mobile_meram_probe,
 	.remove		= sh_mobile_meram_remove,
diff --git a/drivers/video/sh_mobile_meram.h b/drivers/video/sh_mobile_meram.h
index 82c54fb..1615204 100644
--- a/drivers/video/sh_mobile_meram.h
+++ b/drivers/video/sh_mobile_meram.h
@@ -17,14 +17,6 @@
 #define SH_MOBILE_MERAM_CACHE_OFFSET(p)	((p) >> 16)
 #define SH_MOBILE_MERAM_CACHE_SIZE(p)	((p) & 0xffff)
 
-struct sh_mobile_meram_priv {
-	void __iomem	*base;
-	struct mutex	lock;
-	unsigned long	used_icb;
-	int		used_meram_cache_regions;
-	unsigned long	used_meram_cache[SH_MOBILE_MERAM_ICB_NUM];
-};
-
 int sh_mobile_meram_alloc_icb(const struct sh_mobile_meram_cfg *cfg,
 		   int xres,
 		   int yres,
-- 
1.7.1


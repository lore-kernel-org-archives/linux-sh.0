From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 05 Dec 2008 01:56:41 +0000
Subject: [PATCH] Add icb clk setting for SH7723 on sh_mobile_lcdcfb.c
Message-Id: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


ICB clock is needed when you use LCDC on SH7723
This patch add support it.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index c81ee00..90ceef9 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <video/sh_mobile_lcdc.h>
+#include <asm/processor.h>
 
 #define PALETTE_NR 16
 
@@ -36,6 +37,7 @@ struct sh_mobile_lcdc_priv {
 	void __iomem *base;
 #ifdef CONFIG_HAVE_CLK
 	struct clk *dot_clk;
+	struct clk *icb_clk;
 	struct clk *clk;
 #endif
 	unsigned long lddckr;
@@ -210,6 +212,8 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 #ifdef CONFIG_HAVE_CLK
 	clk_enable(priv->clk);
+	if (priv->icb_clk)
+		clk_enable(priv->icb_clk);
 	if (priv->dot_clk)
 		clk_enable(priv->dot_clk);
 #endif
@@ -381,6 +385,8 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 #ifdef CONFIG_HAVE_CLK
 	if (priv->dot_clk)
 		clk_disable(priv->dot_clk);
+	if (priv->icb_clk)
+		clk_disable(priv->icb_clk);
 	clk_disable(priv->clk);
 #endif
 }
@@ -452,11 +458,23 @@ static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
 		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
 		return PTR_ERR(priv->clk);
 	}
-	
+
+	if (CPU_SH7723 = current_cpu_data.type) {
+		snprintf(clk_name, sizeof(clk_name), "icb%d", pdev->id);
+		priv->icb_clk = clk_get(&pdev->dev, clk_name);
+		if (IS_ERR(priv->icb_clk)) {
+			dev_err(&pdev->dev,
+				"cannot get clock \"%s\"\n", clk_name);
+			return PTR_ERR(priv->icb_clk);
+		}
+	}
+
 	if (str) {
 		priv->dot_clk = clk_get(&pdev->dev, str);
 		if (IS_ERR(priv->dot_clk)) {
 			dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
+			if (priv->icb_clk)
+				clk_put(priv->icb_clk);
 			clk_put(priv->clk);
 			return PTR_ERR(priv->dot_clk);
 		}
@@ -720,6 +738,8 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 #ifdef CONFIG_HAVE_CLK
 	if (priv->dot_clk)
 		clk_put(priv->dot_clk);
+	if (priv->icb_clk)
+		clk_put(priv->icb_clk);
 	clk_put(priv->clk);
 #endif
 
-- 
1.5.6.3


From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:23:26 +0000
Subject: [PATCH] sh: sh_mobile lcdc clock framework support
Message-Id: <20081031112326.2994.49596.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clock framework support to the lcdc driver and
adjust the board specific code accordingly.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c   |    1 
 arch/sh/boards/mach-migor/setup.c |    1 
 drivers/video/sh_mobile_lcdcfb.c  |   46 ++++++++++++++++++++++++++-----------
 3 files changed, 33 insertions(+), 15 deletions(-)

--- 0011/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2008-10-31 16:18:33.000000000 +0900
@@ -345,7 +345,6 @@ static int __init ap325rxa_devices_setup
 	gpio_export(GPIO_PTF7, 0);
 
 	/* LCDC */
-	clk_always_enable("mstp200");
 	gpio_request(GPIO_FN_LCDD15, NULL);
 	gpio_request(GPIO_FN_LCDD14, NULL);
 	gpio_request(GPIO_FN_LCDD13, NULL);
--- 0011/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-31 16:18:33.000000000 +0900
@@ -502,7 +502,6 @@ static int __init migor_devices_setup(vo
 	gpio_request(GPIO_FN_IRQ6, NULL);
 
 	/* LCD Panel */
-	clk_always_enable("mstp200"); /* LCDC */
 #ifdef CONFIG_SH_MIGOR_QVGA /* LCDC - QVGA - Enable SYS Interface signals */
 	gpio_request(GPIO_FN_LCDD17, NULL);
 	gpio_request(GPIO_FN_LCDD16, NULL);
--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-10-31 16:18:33.000000000 +0900
@@ -35,6 +35,7 @@ struct sh_mobile_lcdc_chan {
 struct sh_mobile_lcdc_priv {
 	void __iomem *base;
 #ifdef CONFIG_HAVE_CLK
+	struct clk *dot_clk;
 	struct clk *clk;
 #endif
 	unsigned long lddckr;
@@ -207,6 +208,11 @@ static int sh_mobile_lcdc_start(struct s
 	int k, m;
 	int ret = 0;
 
+#ifdef CONFIG_HAVE_CLK
+	clk_enable(priv->clk);
+	if (priv->dot_clk)
+		clk_enable(priv->dot_clk);
+#endif
 	/* reset */
 	lcdc_write(priv, _LDCNT2R, lcdc_read(priv, _LDCNT2R) | LCDC_RESET);
 	lcdc_wait_bit(priv, _LDCNT2R, LCDC_RESET, 0);
@@ -371,6 +377,12 @@ static void sh_mobile_lcdc_stop(struct s
 
 	/* stop the lcdc */
 	sh_mobile_lcdc_start_stop(priv, 0);
+
+#ifdef CONFIG_HAVE_CLK
+	if (priv->dot_clk)
+		clk_disable(priv->dot_clk);
+	clk_disable(priv->clk);
+#endif
 }
 
 static int sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
@@ -413,9 +425,13 @@ static int sh_mobile_lcdc_check_interfac
 	return -EINVAL;
 }
 
-static int sh_mobile_lcdc_setup_clocks(struct device *dev, int clock_source,
+static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
+				       int clock_source,
 				       struct sh_mobile_lcdc_priv *priv)
 {
+#ifdef CONFIG_HAVE_CLK
+	char clk_name[8];
+#endif
 	char *str;
 	int icksel;
 
@@ -430,14 +446,20 @@ static int sh_mobile_lcdc_setup_clocks(s
 	priv->lddckr = icksel << 16;
 
 #ifdef CONFIG_HAVE_CLK
+	snprintf(clk_name, sizeof(clk_name), "lcdc%d", pdev->id);
+	priv->clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		return PTR_ERR(priv->clk);
+	}
+	
 	if (str) {
-		priv->clk = clk_get(dev, str);
-		if (IS_ERR(priv->clk)) {
-			dev_err(dev, "cannot get clock %s\n", str);
-			return PTR_ERR(priv->clk);
+		priv->dot_clk = clk_get(&pdev->dev, str);
+		if (IS_ERR(priv->dot_clk)) {
+			dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
+			clk_put(priv->clk);
+			return PTR_ERR(priv->dot_clk);
 		}
-
-		clk_enable(priv->clk);
 	}
 #endif
 
@@ -587,8 +609,7 @@ static int __init sh_mobile_lcdc_probe(s
 		goto err1;
 	}
 
-	error = sh_mobile_lcdc_setup_clocks(&pdev->dev,
-					    pdata->clock_source, priv);
+	error = sh_mobile_lcdc_setup_clocks(pdev, pdata->clock_source, priv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to setup clocks\n");
 		goto err1;
@@ -697,10 +718,9 @@ static int sh_mobile_lcdc_remove(struct 
 	}
 
 #ifdef CONFIG_HAVE_CLK
-	if (priv->clk) {
-		clk_disable(priv->clk);
-		clk_put(priv->clk);
-	}
+	if (priv->dot_clk)
+		clk_put(priv->dot_clk);
+	clk_put(priv->clk);
 #endif
 
 	if (priv->base)

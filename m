From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:33:13 +0000
Subject: [PATCH 1/6] fbdev: sh_mobile_lcdcfb: add struct sh_mobile_lcdc_clock_source
Message-Id: <87mxdmctve.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LCDC clock sorce on SH-Mobile/R-Mobile chip is
not same as SH chip.
This patch adds struct sh_mobile_lcdc_clock_source so that
clock source will be selected more flexibly.

This patch has LCDC_CLK_xxx for compatibility.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c   |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c   |    4 ++--
 arch/arm/mach-shmobile/board-kota2.c    |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 drivers/video/sh_mobile_lcdcfb.c        |   17 ++++-------------
 include/video/sh_mobile_lcdc.h          |   14 +++++++++++---
 6 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index b36dc61..2cbf158 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -262,7 +262,7 @@ static const struct fb_videomode lcdc0_modes[] = {
 };
 
 static struct sh_mobile_lcdc_info lcdc0_info = {
-	.clock_source = LCDC_CLK_PERIPHERAL,
+	.clock_source = LCDC_CLK_SRC(1, NULL), /* HSbyteCLK */
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.interface_type = RGB24,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5aa5ddd..1c997b8 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -806,7 +806,7 @@ static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 };
 
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
-	.clock_source = LCDC_CLK_EXTERNAL,
+	.clock_source = LCDC_CLK_SRC(2, NULL), /* HDMI */
 	.meram_dev = &meram_info,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
@@ -1343,7 +1343,7 @@ static void __init ap4evb_init(void)
 	i2c_register_board_info(1, &tsc_device, 1);
 
 	/* LCDC0 */
-	lcdc_info.clock_source			= LCDC_CLK_PERIPHERAL;
+	lcdc_info.clock_source			= LCDC_CLK_SRC(1, NULL);
 	lcdc_info.ch[0].interface_type		= RGB24;
 	lcdc_info.ch[0].clock_divider		= 1;
 	lcdc_info.ch[0].flags			= LCDC_FLAGS_DWPOL;
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 5b76d5d..b7a1d23 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -306,7 +306,7 @@ static struct fb_videomode lcdc0_modes[] = {
 };
 
 static struct sh_mobile_lcdc_info lcdc0_info = {
-	.clock_source	= LCDC_CLK_PERIPHERAL,
+	.clock_source	= LCDC_CLK_SRC(1, NULL), /* HSbyteCLK */
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 32,
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d41c01f..b7efd26 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -447,7 +447,7 @@ static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 /* HDMI */
 static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
 	.meram_dev = &mackerel_meram_info,
-	.clock_source = LCDC_CLK_EXTERNAL,
+	.clock_source = LCDC_CLK_SRC(2, NULL), /* HDMI */
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 8cda40c..38dd2d0 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -815,21 +815,12 @@ static int sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
 }
 
 static int sh_mobile_lcdc_setup_clocks(struct platform_device *pdev,
-				       int clock_source,
+				       struct sh_mobile_lcdc_clk_src *clk_src,
 				       struct sh_mobile_lcdc_priv *priv)
 {
-	char *str;
-	int icksel;
+	char *str = clk_src->str;
 
-	switch (clock_source) {
-	case LCDC_CLK_BUS: str = "bus_clk"; icksel = 0; break;
-	case LCDC_CLK_PERIPHERAL: str = "peripheral_clk"; icksel = 1; break;
-	case LCDC_CLK_EXTERNAL: str = NULL; icksel = 2; break;
-	default:
-		return -EINVAL;
-	}
-
-	priv->lddckr = icksel << 16;
+	priv->lddckr = clk_src->icksel << 16;
 
 	if (str) {
 		priv->dot_clk = clk_get(&pdev->dev, str);
@@ -1498,7 +1489,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	if (!priv->base)
 		goto err1;
 
-	error = sh_mobile_lcdc_setup_clocks(pdev, pdata->clock_source, priv);
+	error = sh_mobile_lcdc_setup_clocks(pdev, &pdata->clock_source, priv);
 	if (error) {
 		dev_err(&pdev->dev, "unable to setup clocks\n");
 		goto err1;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index d964e68..602286c 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -30,8 +30,6 @@ enum { LCDC_CHAN_DISABLED = 0,
        LCDC_CHAN_MAINLCD,
        LCDC_CHAN_SUBLCD };
 
-enum { LCDC_CLK_BUS, LCDC_CLK_PERIPHERAL, LCDC_CLK_EXTERNAL };
-
 #define LCDC_FLAGS_DWPOL (1 << 0) /* Rising edge dot clock data latch */
 #define LCDC_FLAGS_DIPOL (1 << 1) /* Active low display enable polarity */
 #define LCDC_FLAGS_DAPOL (1 << 2) /* Active low display data polarity */
@@ -91,8 +89,18 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_meram_cfg *meram_cfg;
 };
 
+struct sh_mobile_lcdc_clk_src {
+	char *str;
+	int icksel;
+};
+
+#define LCDC_CLK_SRC(i, s)	{ .icksel = i, .str = s }
+#define LCDC_CLK_BUS		LCDC_CLK_SRC(0, "bus_clk")
+#define LCDC_CLK_PERIPHERAL	LCDC_CLK_SRC(1, "peripheral_clk")
+#define LCDC_CLK_EXTERNAL	LCDC_CLK_SRC(2, NULL)
+
 struct sh_mobile_lcdc_info {
-	int clock_source;
+	struct sh_mobile_lcdc_clk_src clock_source;
 	struct sh_mobile_lcdc_chan_cfg ch[2];
 	struct sh_mobile_meram_info *meram_dev;
 };
-- 
1.7.4.1


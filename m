From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 02:30:22 +0000
Subject: [PATCH 11/11] ARM: mach-shmobile: armadillo800eva: add FSI-HDMI support
Message-Id: <87396taqx0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   82 +++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index d09953e..4cdbdc8 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -732,10 +732,42 @@ static struct platform_device ceu0_device = {
 };
 
 /* FSI */
+static int fsi_hdmi_set_rate(struct device *dev, int rate, int enable)
+{
+	struct clk *fsib;
+	int ret;
+
+	/* it support 48KHz only */
+	if (48000 != rate)
+		return -EINVAL;
+
+	fsib = clk_get(dev, "ickb");
+	if (IS_ERR(fsib))
+		return -EINVAL;
+
+	if (enable) {
+		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
+		clk_enable(fsib);
+	} else {
+		ret = 0;
+		clk_disable(fsib);
+	}
+
+	clk_put(fsib);
+
+	return ret;
+}
+
 static struct sh_fsi_platform_info fsi_info = {
 	/* FSI-WM8978 */
 	.port_a = {
 	},
+	/* FSI-HDMI */
+	.port_b = {
+		.flags		= SH_FSI_FMT_SPDIF |
+				  SH_FSI_ENABLE_STREAM_MODE,
+		.set_rate	= fsi_hdmi_set_rate,
+	}
 };
 
 static struct resource fsi_resources[] = {
@@ -787,6 +819,29 @@ static struct platform_device fsi_wm8978_device = {
 	},
 };
 
+/* FSI-HDMI */
+static struct asoc_simple_dai_init_info fsi2_hdmi_init_info = {
+	.cpu_daifmt	= SND_SOC_DAIFMT_CBM_CFM,
+};
+
+static struct asoc_simple_card_info fsi2_hdmi_info = {
+	.name		= "HDMI",
+	.card		= "FSI2B-HDMI",
+	.cpu_dai	= "fsib-dai",
+	.codec		= "sh-mobile-hdmi",
+	.platform	= "sh_fsi2",
+	.codec_dai	= "sh_mobile_hdmi-hifi",
+	.init		= &fsi2_hdmi_init_info,
+};
+
+static struct platform_device fsi_hdmi_device = {
+	.name	= "asoc-simple-card",
+	.id	= 1,
+	.dev	= {
+		.platform_data	= &fsi2_hdmi_info,
+	},
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -812,6 +867,7 @@ static struct platform_device *eva_devices[] __initdata = {
 	&camera_device,
 	&ceu0_device,
 	&fsi_device,
+	&fsi_hdmi_device,
 	&fsi_wm8978_device,
 };
 
@@ -820,10 +876,14 @@ static void __init eva_clock_init(void)
 	struct clk *system	= clk_get(NULL, "system_clk");
 	struct clk *xtal1	= clk_get(NULL, "extal1");
 	struct clk *usb24s	= clk_get(NULL, "usb24s");
+	struct clk *fsibck	= clk_get(NULL, "fsibck");
+	struct clk *fsib	= clk_get(&fsi_device.dev, "ickb");
 
 	if (IS_ERR(system)	||
 	    IS_ERR(xtal1)	||
-	    IS_ERR(usb24s)) {
+	    IS_ERR(usb24s)	||
+	    IS_ERR(fsibck)	||
+	    IS_ERR(fsib)) {
 		pr_err("armadillo800eva board clock init failed\n");
 		goto clock_error;
 	}
@@ -843,6 +903,11 @@ static void __init eva_clock_init(void)
 	/* video1 (= CON1 camera) expect 24MHz */
 	clk_set_rate(cam1_mclk, clk_round_rate(cam1_mclk, 24000000));
 
+	/* FSIBCK is 12.288MHz, and it is parent of FSI-B */
+	clk_set_parent(fsib, fsibck);
+	clk_set_rate(fsibck, 12288000);
+	clk_set_rate(fsib,   12288000);
+
 clock_error:
 	if (!IS_ERR(system))
 		clk_put(system);
@@ -850,6 +915,10 @@ clock_error:
 		clk_put(xtal1);
 	if (!IS_ERR(usb24s))
 		clk_put(usb24s);
+	if (!IS_ERR(fsibck))
+		clk_put(fsibck);
+	if (!IS_ERR(fsib))
+		clk_put(fsib);
 }
 
 /*
@@ -859,8 +928,6 @@ clock_error:
 #define GPIO_PORT8CR	0xe6050008
 static void __init eva_init(void)
 {
-	eva_clock_init();
-
 	r8a7740_pinmux_init();
 
 	/* SCIFA1 */
@@ -1017,6 +1084,13 @@ static void __init eva_init(void)
 	gpio_no_direction(GPIO_PORT7CR); /* FSIAOBT needs no direction */
 	gpio_no_direction(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
+	/* FSI-HDMI */
+	gpio_request(GPIO_FN_FSIBCK,		NULL);
+
+	/* HDMI */
+	gpio_request(GPIO_FN_HDMI_HPD,		NULL);
+	gpio_request(GPIO_FN_HDMI_CEC,		NULL);
+
 	/*
 	 * CAUTION
 	 *
@@ -1063,6 +1137,8 @@ static void __init eva_init(void)
 
 	platform_add_devices(eva_devices,
 			     ARRAY_SIZE(eva_devices));
+
+	eva_clock_init();
 }
 
 static void __init eva_earlytimer_init(void)
-- 
1.7.5.4


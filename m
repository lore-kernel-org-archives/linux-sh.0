From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Jun 2010 03:15:09 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add LCD panel selection
Message-Id: <w3pfx13wksi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On AP4EVB board, it is possible to select LCD panel type
which are parallel or MIPI by SW3, SW43 dip-switch.
This patch add parallel LCD settings and
select menu to Kconfig.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig        |   13 ++
 arch/arm/mach-shmobile/board-ap4evb.c |  346 ++++++++++++++++++++-------------
 2 files changed, 227 insertions(+), 132 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 1de8d17..bd6cc6d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -44,6 +44,19 @@ config MACH_AP4EVB
 	select ARCH_REQUIRE_GPIOLIB
 	select SH_LCD_MIPI_DSI
 
+choice
+	prompt "AP4EVB LCD panel selection"
+	default AP4EVB_QHD
+	depends on MACH_AP4EVB
+
+config AP4EVB_QHD
+	bool "MIPI-DSI QHD (960x540)"
+
+config AP4EVB_WVGA
+	bool "Parallel WVGA (800x480)"
+
+endchoice
+
 comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5d24d4e..e8a9d79 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -101,14 +101,20 @@
 /*
  * LCD / IRQ / KEYSC / IrDA
  *
- * IRQ = IRQ26 (TS), IRQ27 (VIO), IRQ28 (TouchScreen)
- * LCD = 2nd LCDC
+ * IRQ = IRQ26 (TS), IRQ27 (VIO), IRQ28 (QHD-TouchScreen)
+ * LCD = 2nd LCDC (WVGA)
  *
  * 		|		SW43			|
  * SW3		|	ON		|	OFF	|
  * -------------+-----------------------+---------------+
  * ON		| KEY / IrDA		| LCD		|
  * OFF		| KEY / IrDA / IRQ	| IRQ		|
+ *
+ *
+ * QHD / WVGA display
+ *
+ * You can choice display type on menuconfig.
+ * Then, check above dip-switch.
  */
 
 /*
@@ -226,43 +232,6 @@ static struct platform_device smc911x_device = {
 	},
 };
 
-/* KEYSC (Needs SW43 set to ON) */
-static struct sh_keysc_info keysc_info = {
-	.mode		= SH_KEYSC_MODE_1,
-	.scan_timing	= 3,
-	.delay		= 2500,
-	.keycodes = {
-		KEY_0, KEY_1, KEY_2, KEY_3, KEY_4,
-		KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,
-		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E,
-		KEY_F, KEY_G, KEY_H, KEY_I, KEY_J,
-		KEY_K, KEY_L, KEY_M, KEY_N, KEY_O,
-	},
-};
-
-static struct resource keysc_resources[] = {
-	[0] = {
-		.name	= "KEYSC",
-		.start  = 0xe61b0000,
-		.end    = 0xe61b0063,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start  = evt2irq(0x0be0), /* KEYSC_KEY */
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device keysc_device = {
-	.name           = "sh_keysc",
-	.id             = 0, /* "keysc0" clock */
-	.num_resources  = ARRAY_SIZE(keysc_resources),
-	.resource       = keysc_resources,
-	.dev	= {
-		.platform_data	= &keysc_info,
-	},
-};
-
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -402,30 +371,10 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
-static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
-	.clock_source = LCDC_CLK_PERIPHERAL, /* One of interface clocks */
+static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
-		.interface_type = RGB24,
-		.clock_divider = 1,
-		.flags = LCDC_FLAGS_DWPOL,
-		.lcd_cfg = {
-			.name = "R63302(QHD)",
-			.xres = 544,
-			.yres = 961,
-			.left_margin = 72,
-			.right_margin = 600,
-			.hsync_len = 16,
-			.upper_margin = 8,
-			.lower_margin = 8,
-			.vsync_len = 2,
-			.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
-		},
-		.lcd_size_cfg = {
-			.width = 44,
-			.height = 79,
-		},
 	}
 };
 
@@ -447,11 +396,54 @@ static struct platform_device lcdc_device = {
 	.num_resources	= ARRAY_SIZE(lcdc_resources),
 	.resource	= lcdc_resources,
 	.dev	= {
-		.platform_data	= &sh_mobile_lcdc_info,
+		.platform_data	= &lcdc_info,
 		.coherent_dma_mask = ~0,
 	},
 };
 
+/*
+ * QHD display
+ */
+#ifdef CONFIG_AP4EVB_QHD
+
+/* KEYSC (Needs SW43 set to ON) */
+static struct sh_keysc_info keysc_info = {
+	.mode		= SH_KEYSC_MODE_1,
+	.scan_timing	= 3,
+	.delay		= 2500,
+	.keycodes = {
+		KEY_0, KEY_1, KEY_2, KEY_3, KEY_4,
+		KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,
+		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E,
+		KEY_F, KEY_G, KEY_H, KEY_I, KEY_J,
+		KEY_K, KEY_L, KEY_M, KEY_N, KEY_O,
+	},
+};
+
+static struct resource keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start  = 0xe61b0000,
+		.end    = 0xe61b0063,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0x0be0), /* KEYSC_KEY */
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device keysc_device = {
+	.name           = "sh_keysc",
+	.id             = 0, /* "keysc0" clock */
+	.num_resources  = ARRAY_SIZE(keysc_resources),
+	.resource       = keysc_resources,
+	.dev	= {
+		.platform_data	= &keysc_info,
+	},
+};
+
+/* MIPI-DSI */
 static struct resource mipidsi0_resources[] = {
 	[0] = {
 		.start  = 0xffc60000,
@@ -462,7 +454,7 @@ static struct resource mipidsi0_resources[] = {
 
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
-	.lcd_chan	= &sh_mobile_lcdc_info.ch[0],
+	.lcd_chan	= &lcdc_info.ch[0],
 };
 
 static struct platform_device mipidsi0_device = {
@@ -475,6 +467,50 @@ static struct platform_device mipidsi0_device = {
 	},
 };
 
+/* This function will disappear when we switch to (runtime) PM */
+static int __init ap4evb_init_display_clk(void)
+{
+	struct clk *lcdc_clk;
+	struct clk *dsitx_clk;
+	int ret;
+
+	lcdc_clk = clk_get(&lcdc_device.dev, "sh_mobile_lcdc_fb.0");
+	if (IS_ERR(lcdc_clk))
+		return PTR_ERR(lcdc_clk);
+
+	dsitx_clk = clk_get(&mipidsi0_device.dev, "sh-mipi-dsi.0");
+	if (IS_ERR(dsitx_clk)) {
+		ret = PTR_ERR(dsitx_clk);
+		goto eclkdsitxget;
+	}
+
+	ret = clk_enable(lcdc_clk);
+	if (ret < 0)
+		goto eclklcdcon;
+
+	ret = clk_enable(dsitx_clk);
+	if (ret < 0)
+		goto eclkdsitxon;
+
+	return 0;
+
+eclkdsitxon:
+	clk_disable(lcdc_clk);
+eclklcdcon:
+	clk_put(dsitx_clk);
+eclkdsitxget:
+	clk_put(lcdc_clk);
+
+	return ret;
+}
+device_initcall(ap4evb_init_display_clk);
+
+static struct platform_device *qhd_devices[] __initdata = {
+	&mipidsi0_device,
+	&keysc_device,
+};
+#endif /* CONFIG_AP4EVB_QHD */
+
 /* FSI */
 #define IRQ_FSI		evt2irq(0x1840)
 #define FSIACKCR	0xE6150018
@@ -532,23 +568,29 @@ static struct platform_device fsi_device = {
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
-	&keysc_device,
 	&sdhi0_device,
 	&sdhi1_device,
 	&usb1_host_device,
 	&lcdc_device,
-	&mipidsi0_device,
 	&fsi_device,
 	&sh_mmcif_device
 };
 
-/* TouchScreen (Needs SW3 set to OFF) */
+/* TouchScreen */
 #define IRQ28	evt2irq(0x3380) /* IRQ28A */
+#define IRQ7	evt2irq(0x02e0) /* IRQ7A */
 static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
 };
 
+static struct i2c_board_info tsc_device = {
+	I2C_BOARD_INFO("tsc2007", 0x48),
+	.type		= "tsc2007",
+	.platform_data	= &tsc2007_info,
+	/*.irq is selected on ap4evb_init */
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -560,12 +602,6 @@ static struct i2c_board_info i2c1_devices[] = {
 	{
 		I2C_BOARD_INFO("r2025sd", 0x32),
 	},
-	{
-		I2C_BOARD_INFO("tsc2007", 0x48),
-		.type		= "tsc2007",
-		.platform_data	= &tsc2007_info,
-		.irq		= IRQ28,
-	},
 };
 
 static struct map_desc ap4evb_io_desc[] __initdata = {
@@ -589,45 +625,6 @@ static void __init ap4evb_map_io(void)
 	shmobile_setup_console();
 }
 
-/* This function will disappear when we switch to (runtime) PM */
-static int __init ap4evb_init_display_clk(void)
-{
-	struct clk *lcdc_clk;
-	struct clk *dsitx_clk;
-	int ret;
-
-	lcdc_clk = clk_get(&lcdc_device.dev, "sh_mobile_lcdc_fb.0");
-	if (IS_ERR(lcdc_clk))
-		return PTR_ERR(lcdc_clk);
-
-	dsitx_clk = clk_get(&mipidsi0_device.dev, "sh-mipi-dsi.0");
-	if (IS_ERR(dsitx_clk)) {
-		ret = PTR_ERR(dsitx_clk);
-		goto eclkdsitxget;
-	}
-
-	ret = clk_enable(lcdc_clk);
-	if (ret < 0)
-		goto eclklcdcon;
-
-	ret = clk_enable(dsitx_clk);
-	if (ret < 0)
-		goto eclkdsitxon;
-
-	return 0;
-
-eclkdsitxon:
-	clk_disable(lcdc_clk);
-eclklcdcon:
-	clk_put(dsitx_clk);
-eclkdsitxget:
-	clk_put(lcdc_clk);
-
-	return ret;
-}
-
-device_initcall(ap4evb_init_display_clk);
-
 /*
  * FIXME !!
  *
@@ -687,18 +684,6 @@ static void __init ap4evb_init(void)
 	gpio_export(GPIO_PORT34, 0);
 	gpio_export(GPIO_PORT35, 0);
 
-	/* enable KEYSC */
-	gpio_request(GPIO_FN_KEYOUT0, NULL);
-	gpio_request(GPIO_FN_KEYOUT1, NULL);
-	gpio_request(GPIO_FN_KEYOUT2, NULL);
-	gpio_request(GPIO_FN_KEYOUT3, NULL);
-	gpio_request(GPIO_FN_KEYOUT4, NULL);
-	gpio_request(GPIO_FN_KEYIN0_136, NULL);
-	gpio_request(GPIO_FN_KEYIN1_135, NULL);
-	gpio_request(GPIO_FN_KEYIN2_134, NULL);
-	gpio_request(GPIO_FN_KEYIN3_133, NULL);
-	gpio_request(GPIO_FN_KEYIN4,     NULL);
-
 	/* SDHI0 */
 	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
@@ -709,9 +694,13 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-	/* enable TouchScreen */
-	gpio_request(GPIO_FN_IRQ28_123, NULL);
-	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
+	/* SDHI1 */
+	gpio_request(GPIO_FN_SDHICMD1, NULL);
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHID1_3, NULL);
+	gpio_request(GPIO_FN_SDHID1_2, NULL);
+	gpio_request(GPIO_FN_SDHID1_1, NULL);
+	gpio_request(GPIO_FN_SDHID1_0, NULL);
 
 	/* MMCIF */
 	gpio_request(GPIO_FN_MMCD0_0, NULL);
@@ -777,13 +766,106 @@ static void __init ap4evb_init(void)
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
 
-	/* SDHI1 */
-	gpio_request(GPIO_FN_SDHICMD1, NULL);
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHID1_3, NULL);
-	gpio_request(GPIO_FN_SDHID1_2, NULL);
-	gpio_request(GPIO_FN_SDHID1_1, NULL);
-	gpio_request(GPIO_FN_SDHID1_0, NULL);
+#ifdef CONFIG_AP4EVB_QHD
+	/*
+	 * QHD
+	 */
+
+	/* enable KEYSC */
+	gpio_request(GPIO_FN_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_KEYOUT4, NULL);
+	gpio_request(GPIO_FN_KEYIN0_136, NULL);
+	gpio_request(GPIO_FN_KEYIN1_135, NULL);
+	gpio_request(GPIO_FN_KEYIN2_134, NULL);
+	gpio_request(GPIO_FN_KEYIN3_133, NULL);
+	gpio_request(GPIO_FN_KEYIN4,     NULL);
+
+	/* enable TouchScreen */
+	gpio_request(GPIO_FN_IRQ28_123, NULL);
+	set_irq_type(IRQ28, IRQ_TYPE_LEVEL_LOW);
+
+	tsc_device.irq = IRQ28;
+	i2c_register_board_info(1, &tsc_device, 1);
+
+	/* LCDC0 */
+	lcdc_info.clock_source			= LCDC_CLK_PERIPHERAL;
+	lcdc_info.ch[0].interface_type		= RGB24;
+	lcdc_info.ch[0].clock_divider		= 1;
+	lcdc_info.ch[0].flags			= LCDC_FLAGS_DWPOL;
+	lcdc_info.ch[0].lcd_cfg.name		= "R63302(QHD)";
+	lcdc_info.ch[0].lcd_cfg.xres		= 544;
+	lcdc_info.ch[0].lcd_cfg.yres		= 961;
+	lcdc_info.ch[0].lcd_cfg.left_margin	= 72;
+	lcdc_info.ch[0].lcd_cfg.right_margin	= 600;
+	lcdc_info.ch[0].lcd_cfg.hsync_len	= 16;
+	lcdc_info.ch[0].lcd_cfg.upper_margin	= 8;
+	lcdc_info.ch[0].lcd_cfg.lower_margin	= 8;
+	lcdc_info.ch[0].lcd_cfg.vsync_len	= 2;
+	lcdc_info.ch[0].lcd_cfg.sync		= FB_SYNC_VERT_HIGH_ACT |
+						  FB_SYNC_HOR_HIGH_ACT;
+	lcdc_info.ch[0].lcd_size_cfg.width	= 44;
+	lcdc_info.ch[0].lcd_size_cfg.height	= 79;
+
+	platform_add_devices(qhd_devices, ARRAY_SIZE(qhd_devices));
+
+#else
+	/*
+	 * WVGA
+	 */
+	gpio_request(GPIO_FN_LCDD17,   NULL);
+	gpio_request(GPIO_FN_LCDD16,   NULL);
+	gpio_request(GPIO_FN_LCDD15,   NULL);
+	gpio_request(GPIO_FN_LCDD14,   NULL);
+	gpio_request(GPIO_FN_LCDD13,   NULL);
+	gpio_request(GPIO_FN_LCDD12,   NULL);
+	gpio_request(GPIO_FN_LCDD11,   NULL);
+	gpio_request(GPIO_FN_LCDD10,   NULL);
+	gpio_request(GPIO_FN_LCDD9,    NULL);
+	gpio_request(GPIO_FN_LCDD8,    NULL);
+	gpio_request(GPIO_FN_LCDD7,    NULL);
+	gpio_request(GPIO_FN_LCDD6,    NULL);
+	gpio_request(GPIO_FN_LCDD5,    NULL);
+	gpio_request(GPIO_FN_LCDD4,    NULL);
+	gpio_request(GPIO_FN_LCDD3,    NULL);
+	gpio_request(GPIO_FN_LCDD2,    NULL);
+	gpio_request(GPIO_FN_LCDD1,    NULL);
+	gpio_request(GPIO_FN_LCDD0,    NULL);
+	gpio_request(GPIO_FN_LCDDISP,  NULL);
+	gpio_request(GPIO_FN_LCDDCK,   NULL);
+
+	gpio_request(GPIO_PORT189, NULL); /* backlight */
+	gpio_direction_output(GPIO_PORT189, 1);
+
+	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
+	gpio_direction_output(GPIO_PORT151, 1);
+
+	lcdc_info.clock_source			= LCDC_CLK_BUS;
+	lcdc_info.ch[0].interface_type		= RGB18;
+	lcdc_info.ch[0].clock_divider		= 2;
+	lcdc_info.ch[0].flags			= 0;
+	lcdc_info.ch[0].lcd_cfg.name		= "WVGA Panel";
+	lcdc_info.ch[0].lcd_cfg.xres		= 800;
+	lcdc_info.ch[0].lcd_cfg.yres		= 480;
+	lcdc_info.ch[0].lcd_cfg.left_margin	= 220;
+	lcdc_info.ch[0].lcd_cfg.right_margin	= 110;
+	lcdc_info.ch[0].lcd_cfg.hsync_len	= 70;
+	lcdc_info.ch[0].lcd_cfg.upper_margin	= 20;
+	lcdc_info.ch[0].lcd_cfg.lower_margin	= 5;
+	lcdc_info.ch[0].lcd_cfg.vsync_len	= 5;
+	lcdc_info.ch[0].lcd_cfg.sync		= 0;
+	lcdc_info.ch[0].lcd_size_cfg.width	= 152;
+	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
+
+	/* enable TouchScreen */
+	gpio_request(GPIO_FN_IRQ7_40, NULL);
+	set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
+
+	tsc_device.irq = IRQ7;
+	i2c_register_board_info(0, &tsc_device, 1);
+#endif /* CONFIG_AP4EVB_QHD */
 
 	sh7372_add_standard_devices();
 
-- 
1.7.0.4


From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 18 May 2011 11:10:09 +0000
Subject: [PATCH 4/6 v2] sh_mobile_meram: MERAM platform data for LCDC
Message-Id: <1305717011-20742-5-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Based on the patch by Takanari Hayama <taki@igel.co.jp>

Add the necessary platform data to add MERAM functionality to LCDC

Includes platform data for both the AP4EVB and mackerel

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
Changed from V1
==* Changed .id from -1 to 0 in platform data
* Added mackerel platform data

 arch/arm/mach-shmobile/board-ap4evb.c   |   73 ++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c |   74 +++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1e35fa9..d7bbca9 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -249,6 +249,31 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 {
 	return !gpio_get_value(GPIO_PORT41);
 }
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+/* MERAM */
+static struct sh_mobile_meram_info meram_info = {
+	.addr_mode      = SH_MOBILE_MERAM_MODE1,
+};
+
+static struct resource meram_resources[] = {
+	[0] = {
+		.name   = "MERAM",
+		.start  = 0xe8000000,
+		.end    = 0xe81fffff,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device meram_device = {
+	.name           = "sh_mobile_meram",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(meram_resources),
+	.resource       = meram_resources,
+	.dev            = {
+		.platform_data = &meram_info,
+	},
+};
+#endif
 
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
@@ -431,13 +456,35 @@ const static struct fb_videomode ap4evb_lcdc_modes[] = {
 #endif
 	},
 };
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+static struct sh_mobile_meram_cfg lcd_meram_cfg = {
+	.icb[0] = {
+		.marker_icb     = 28,
+		.cache_icb      = 24,
+		.meram_offset   = 0x0,
+		.meram_size     = 0x40,
+	},
+	.icb[1] = {
+		.marker_icb     = 29,
+		.cache_icb      = 25,
+		.meram_offset   = 0x40,
+		.meram_size     = 0x40,
+	},
+};
+#endif
 
 static struct sh_mobile_lcdc_info lcdc_info = {
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	.meram_dev = &meram_info,
+#endif
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.lcd_cfg = ap4evb_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(ap4evb_lcdc_modes),
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+		.meram_cfg = &lcd_meram_cfg,
+#endif
 	}
 };
 
@@ -708,15 +755,38 @@ static struct platform_device fsi_device = {
 static struct platform_device fsi_ak4643_device = {
 	.name		= "sh_fsi2_a_ak4643",
 };
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
+	.icb[0] = {
+		.marker_icb     = 30,
+		.cache_icb      = 26,
+		.meram_offset   = 0x80,
+		.meram_size     = 0x100,
+	},
+	.icb[1] = {
+		.marker_icb     = 31,
+		.cache_icb      = 27,
+		.meram_offset   = 0x180,
+		.meram_size     = 0x100,
+	},
+};
+#endif
 
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	.meram_dev = &meram_info,
+#endif
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+		.meram_cfg = &hdmi_meram_cfg,
+#endif
+
 	}
 };
 
@@ -945,6 +1015,9 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&csi2_device,
 	&ceu_device,
 	&ap4evb_camera,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	&meram_device,
+#endif
 };
 
 static void __init hdmi_init_pm_clock(void)
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7da2ca2..1117ca5 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -279,6 +279,32 @@ static struct platform_device smc911x_device = {
 	},
 };
 
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+/* MERAM */
+static struct sh_mobile_meram_info mackerel_meram_info = {
+	.addr_mode	= SH_MOBILE_MERAM_MODE1,
+};
+
+static struct resource meram_resources[] = {
+	[0] = {
+		.name	= "MERAM",
+		.start	= 0xe8000000,
+		.end	= 0xe81fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device meram_device = {
+	.name		= "sh_mobile_meram",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(meram_resources),
+	.resource	= meram_resources,
+	.dev		= {
+		.platform_data = &mackerel_meram_info,
+	},
+};
+#endif
+
 /* LCDC */
 static struct fb_videomode mackerel_lcdc_modes[] = {
 	{
@@ -307,7 +333,27 @@ static int mackerel_get_brightness(void *board_data)
 	return gpio_get_value(GPIO_PORT31);
 }
 
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+static struct sh_mobile_meram_cfg lcd_meram_cfg = {
+	.icb[0] = {
+		.marker_icb     = 28,
+		.cache_icb      = 24,
+		.meram_offset   = 0x0,
+		.meram_size     = 0x40,
+	},
+	.icb[1] = {
+		.marker_icb     = 29,
+		.cache_icb      = 25,
+		.meram_offset   = 0x40,
+		.meram_size     = 0x40,
+	},
+};
+#endif
+
 static struct sh_mobile_lcdc_info lcdc_info = {
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	.meram_dev = &mackerel_meram_info,
+#endif
 	.clock_source = LCDC_CLK_BUS,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
@@ -327,6 +373,9 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
 		},
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+		.meram_cfg = &lcd_meram_cfg,
+#endif
 	}
 };
 
@@ -353,8 +402,27 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
+	.icb[0] = {
+		.marker_icb     = 30,
+		.cache_icb      = 26,
+		.meram_offset   = 0x80,
+		.meram_size     = 0x100,
+	},
+	.icb[1] = {
+		.marker_icb     = 31,
+		.cache_icb      = 27,
+		.meram_offset   = 0x180,
+		.meram_size     = 0x100,
+	},
+};
+#endif
 /* HDMI */
 static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	.meram_dev = &mackerel_meram_info,
+#endif
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
@@ -362,6 +430,9 @@ static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+		.meram_cfg = &hdmi_meram_cfg,
+#endif
 	}
 };
 
@@ -949,6 +1020,9 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&mackerel_camera,
 	&hdmi_lcdc_device,
 	&hdmi_device,
+#ifdef CONFIG_FB_SH_MOBILE_MERAM
+	&meram_device,
+#endif
 };
 
 /* Keypad Initialization */
-- 
1.7.1


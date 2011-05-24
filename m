From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 24 May 2011 06:58:58 +0000
Subject: [PATCH 3/3 v3] sh_mobile_meram: MERAM platform data for LCDC
Message-Id: <1306220482-29107-4-git-send-email-dhobsong@igel.co.jp>
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
 Changed from V2
 == * Always define the MERAM platform data (remove CONFIG_FB_SH_MOBILE_MERAM 
   #ifdef's)
 
 Changed from V1
 == * Changed .id from -1 to 0 in platform data
 * Added mackerel platform data

 arch/arm/mach-shmobile/board-ap4evb.c   |   56 +++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c |   58 +++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1e35fa9..c9aad5e 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -249,6 +249,29 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 {
 	return !gpio_get_value(GPIO_PORT41);
 }
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
 
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
@@ -431,13 +454,29 @@ const static struct fb_videomode ap4evb_lcdc_modes[] = {
 #endif
 	},
 };
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
 
 static struct sh_mobile_lcdc_info lcdc_info = {
+	.meram_dev = &meram_info,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.lcd_cfg = ap4evb_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(ap4evb_lcdc_modes),
+		.meram_cfg = &lcd_meram_cfg,
 	}
 };
 
@@ -708,15 +747,31 @@ static struct platform_device fsi_device = {
 static struct platform_device fsi_ak4643_device = {
 	.name		= "sh_fsi2_a_ak4643",
 };
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
 
 static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 	.clock_source = LCDC_CLK_EXTERNAL,
+	.meram_dev = &meram_info,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
+		.meram_cfg = &hdmi_meram_cfg,
 	}
 };
 
@@ -945,6 +1000,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&csi2_device,
 	&ceu_device,
 	&ap4evb_camera,
+	&meram_device,
 };
 
 static void __init hdmi_init_pm_clock(void)
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7da2ca2..a165a9e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -279,6 +279,30 @@ static struct platform_device smc911x_device = {
 	},
 };
 
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
+
 /* LCDC */
 static struct fb_videomode mackerel_lcdc_modes[] = {
 	{
@@ -307,7 +331,23 @@ static int mackerel_get_brightness(void *board_data)
 	return gpio_get_value(GPIO_PORT31);
 }
 
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
+
 static struct sh_mobile_lcdc_info lcdc_info = {
+	.meram_dev = &mackerel_meram_info,
 	.clock_source = LCDC_CLK_BUS,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
@@ -327,6 +367,7 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.name = "sh_mobile_lcdc_bl",
 			.max_brightness = 1,
 		},
+		.meram_cfg = &lcd_meram_cfg,
 	}
 };
 
@@ -353,8 +394,23 @@ static struct platform_device lcdc_device = {
 	},
 };
 
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
 /* HDMI */
 static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
+	.meram_dev = &mackerel_meram_info,
 	.clock_source = LCDC_CLK_EXTERNAL,
 	.ch[0] = {
 		.chan = LCDC_CHAN_MAINLCD,
@@ -362,6 +418,7 @@ static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
 		.interface_type = RGB24,
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
+		.meram_cfg = &hdmi_meram_cfg,
 	}
 };
 
@@ -949,6 +1006,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&mackerel_camera,
 	&hdmi_lcdc_device,
 	&hdmi_device,
+	&meram_device,
 };
 
 /* Keypad Initialization */
-- 
1.7.1


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Dec 2010 08:08:41 +0000
Subject: about sh_mobile_lcdcfb.c :: lcd_size_cfg
Message-Id: <w3pd3ow6f3t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Guennadi, Magnus, Paul
and SuperH ML members

I noticed that current sh_mobile_lcdcfb.c driver seems doesn't use lcd_size_cfg.
maybe turning point is

--------------
commit 14177a5e56904a584f3777f36b50c8d7bfde5810
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Fri Sep 3 07:19:49 2010 +0000

    fbdev: sh_mobile_lcdcfb: use fb_videomode_to_var() instead of open-coding
    
    Use the standard fb_videomode_to_var() instead of filling fb_var_screeninfo
    fields manually in, also remove a redundant memset(0).
    
    Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
--------------

So, I created below patch.
Is this correct ?
-------------------------
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5b07952..d523c68 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1264,8 +1264,6 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].interface_type		= RGB24;
 	lcdc_info.ch[0].clock_divider		= 1;
 	lcdc_info.ch[0].flags			= LCDC_FLAGS_DWPOL;
-	lcdc_info.ch[0].lcd_size_cfg.width	= 44;
-	lcdc_info.ch[0].lcd_size_cfg.height	= 79;
 
 	platform_add_devices(qhd_devices, ARRAY_SIZE(qhd_devices));
 
@@ -1306,8 +1304,6 @@ static void __init ap4evb_init(void)
 	lcdc_info.ch[0].interface_type		= RGB18;
 	lcdc_info.ch[0].clock_divider		= 2;
 	lcdc_info.ch[0].flags			= 0;
-	lcdc_info.ch[0].lcd_size_cfg.width	= 152;
-	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
 
 	/* enable TouchScreen */
 	set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3e30a52..9c504b4 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -262,8 +262,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.interface_type		= RGB24,
 		.clock_divider		= 2,
 		.flags			= 0,
-		.lcd_size_cfg.width	= 152,
-		.lcd_size_cfg.height	= 91,
 	}
 };
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 07ea908..ee24818 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -200,10 +200,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.clock_divider = 1,
 		.lcd_cfg = ap325rxa_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(ap325rxa_lcdc_modes),
-		.lcd_size_cfg = { /* 7.0 inch */
-			.width = 152,
-			.height = 91,
-		},
 		.board_cfg = {
 			.display_on = ap320_wvga_power_on,
 			.display_off = ap320_wvga_power_off,
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 2eaeb9e..d18c0b5 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -266,10 +266,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.interface_type = RGB18,
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
-		.lcd_size_cfg = { /* 7.0 inch */
-			.width = 152,
-			.height = 91,
-		},
 		.board_cfg = {
 		},
 	}
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 9b60eaa..6ac9ff5 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -151,10 +151,6 @@ static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
 		.flags = LCDC_FLAGS_DWPOL,
 		.lcd_cfg = kfr2r09_lcdc_modes,
 		.num_cfg = ARRAY_SIZE(kfr2r09_lcdc_modes),
-		.lcd_size_cfg = {
-			.width = 35,
-			.height = 58,
-		},
 		.board_cfg = {
 			.setup_sys = kfr2r09_lcd_setup,
 			.start_transfer = kfr2r09_lcd_start,
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index c8acfec..61f2ff2 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -248,10 +248,6 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
 		.clock_divider = 2,
 		.lcd_cfg = migor_lcd_modes,
 		.num_cfg = ARRAY_SIZE(migor_lcd_modes),
-		.lcd_size_cfg = { /* 7.0 inch */
-			.width = 152,
-			.height = 91,
-		},
 	}
 #elif defined(CONFIG_SH_MIGOR_QVGA)
 	.clock_source = LCDC_CLK_PERIPHERAL,
@@ -262,10 +258,6 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
 		.clock_divider = 10,
 		.lcd_cfg = migor_lcd_modes,
 		.num_cfg = ARRAY_SIZE(migor_lcd_modes),
-		.lcd_size_cfg = { /* 2.4 inch */
-			.width = 49,
-			.height = 37,
-		},
 		.board_cfg = {
 			.setup_sys = migor_lcd_qvga_setup,
 		},
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index c31d228..bb3527a 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -180,10 +180,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
 		.clock_divider = 1,
-		.lcd_size_cfg = { /* 7.0 inch */
-			.width = 152,
-			.height = 91,
-		},
 		.board_cfg = {
 		},
 	}
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index daabae5..8bf2bfe 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -74,7 +74,6 @@ struct sh_mobile_lcdc_chan_cfg {
 	unsigned long flags; /* LCDC_FLAGS_... */
 	const struct fb_videomode *lcd_cfg;
 	int num_cfg;
-	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
 };
-------------------------

Best regards
--
Kuninori Morimoto
 

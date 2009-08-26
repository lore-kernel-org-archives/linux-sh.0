From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:39 +0000
Subject: [PATCH 6/6] sh: Add LCDC Panel support for EcoVec24
Message-Id: <u63cahm48.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 55ff735..428d118 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -219,7 +219,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		.interface_type = RGB18,
 		.chan = LCDC_CHAN_MAINLCD,
 		.bpp = 16,
-		.clock_divider = 1,
 		.lcd_cfg = {
 			.sync = 0, /* hsync and vsync are active low */
 		},
@@ -337,6 +336,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 };
 
 #define PORT_HIZA 0xA4050158
+#define IODRIVEA  0xA405018A
 static int __init devices_setup(void)
 {
 	/* enable SCIFA0 */
@@ -422,9 +422,13 @@ static int __init devices_setup(void)
 	gpio_direction_output(GPIO_PTR1, 0);
 	gpio_direction_output(GPIO_PTA2, 0);
 
+	/* I/O buffer drive ability is low */
+	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x00c0) | 0x0040 , IODRIVEA);
+
 	if (gpio_get_value(GPIO_PTE6)) {
 		/* DVI */
 		lcdc_info.clock_source			= LCDC_CLK_EXTERNAL;
+		lcdc_info.ch[0].clock_divider		= 1,
 		lcdc_info.ch[0].lcd_cfg.name		= "DVI";
 		lcdc_info.ch[0].lcd_cfg.xres		= 1280;
 		lcdc_info.ch[0].lcd_cfg.yres		= 720;
@@ -439,7 +443,29 @@ static int __init devices_setup(void)
 		gpio_set_value(GPIO_PTU1, 1);
 	} else {
 		/* Panel */
-		/* not supported */
+
+		lcdc_info.clock_source			= LCDC_CLK_PERIPHERAL;
+		lcdc_info.ch[0].clock_divider		= 2,
+		lcdc_info.ch[0].lcd_cfg.name		= "Panel";
+		lcdc_info.ch[0].lcd_cfg.xres		= 800;
+		lcdc_info.ch[0].lcd_cfg.yres		= 480;
+		lcdc_info.ch[0].lcd_cfg.left_margin	= 220;
+		lcdc_info.ch[0].lcd_cfg.right_margin	= 110;
+		lcdc_info.ch[0].lcd_cfg.hsync_len	= 70;
+		lcdc_info.ch[0].lcd_cfg.upper_margin	= 20;
+		lcdc_info.ch[0].lcd_cfg.lower_margin	= 5;
+		lcdc_info.ch[0].lcd_cfg.vsync_len	= 5;
+
+		gpio_set_value(GPIO_PTR1, 1);
+
+		/* FIXME
+		 *
+		 * LCDDON control is needed for Panel,
+		 * but current sh_mobile_lcdc driver doesn't control it.
+		 * It is temporary correspondence
+		 */
+		gpio_request(GPIO_PTF4, NULL);
+		gpio_direction_output(GPIO_PTF4, 1);
 	}
 
 	/* enable CEU0 */
-- 
1.6.0.4


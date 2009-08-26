From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:34 +0000
Subject: [PATCH 4/6] sh: Add support LCDC for EcoVec24
Message-Id: <u8wh6hm4d.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |  109 ++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 7850818..a575b38 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/r8a66597.h>
+#include <video/sh_mobile_lcdc.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <cpu/sh7724.h>
@@ -211,14 +212,60 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+/* LCDC */
+static struct sh_mobile_lcdc_info lcdc_info = {
+	.ch[0] = {
+		.interface_type = RGB18,
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.clock_divider = 1,
+		.lcd_cfg = {
+			.sync = 0, /* hsync and vsync are active low */
+		},
+		.lcd_size_cfg = { /* 7.0 inch */
+			.width = 152,
+			.height = 91,
+		},
+		.board_cfg = {
+		},
+	}
+};
+
+static struct resource lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000,
+		.end	= 0xfe941fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 106,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc_resources),
+	.resource	= lcdc_resources,
+	.dev		= {
+		.platform_data	= &lcdc_info,
+	},
+	.archdata = {
+		.hwblk_id = HWBLK_LCDC,
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
 	&sh_eth_device,
 	&usb0_host_device,
 	&usb1_host_device, /* USB1 host support */
+	&lcdc_device,
 };
 
+#define PORT_HIZA 0xA4050158
 static int __init devices_setup(void)
 {
 	/* enable SCIFA0 */
@@ -262,6 +309,68 @@ static int __init devices_setup(void)
 	ctrl_outw(0x0600, 0xa40501d4);
 	ctrl_outw(0x0600, 0xa4050192);
 
+	/* enable LCDC */
+	gpio_request(GPIO_FN_LCDD23,   NULL);
+	gpio_request(GPIO_FN_LCDD22,   NULL);
+	gpio_request(GPIO_FN_LCDD21,   NULL);
+	gpio_request(GPIO_FN_LCDD20,   NULL);
+	gpio_request(GPIO_FN_LCDD19,   NULL);
+	gpio_request(GPIO_FN_LCDD18,   NULL);
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
+	gpio_request(GPIO_FN_LCDHSYN,  NULL);
+	gpio_request(GPIO_FN_LCDDCK,   NULL);
+	gpio_request(GPIO_FN_LCDVSYN,  NULL);
+	gpio_request(GPIO_FN_LCDDON,   NULL);
+	gpio_request(GPIO_FN_LCDLCLK,  NULL);
+	ctrl_outw((ctrl_inw(PORT_HIZA) & ~0x0001), PORT_HIZA);
+
+	gpio_request(GPIO_PTE6, NULL);
+	gpio_request(GPIO_PTU1, NULL);
+	gpio_request(GPIO_PTR1, NULL);
+	gpio_request(GPIO_PTA2, NULL);
+	gpio_direction_input(GPIO_PTE6);
+	gpio_direction_output(GPIO_PTU1, 0);
+	gpio_direction_output(GPIO_PTR1, 0);
+	gpio_direction_output(GPIO_PTA2, 0);
+
+	if (gpio_get_value(GPIO_PTE6)) {
+		/* DVI */
+		lcdc_info.clock_source			= LCDC_CLK_EXTERNAL;
+		lcdc_info.ch[0].lcd_cfg.name		= "DVI";
+		lcdc_info.ch[0].lcd_cfg.xres		= 1280;
+		lcdc_info.ch[0].lcd_cfg.yres		= 720;
+		lcdc_info.ch[0].lcd_cfg.left_margin	= 220;
+		lcdc_info.ch[0].lcd_cfg.right_margin	= 110;
+		lcdc_info.ch[0].lcd_cfg.hsync_len	= 40;
+		lcdc_info.ch[0].lcd_cfg.upper_margin	= 20;
+		lcdc_info.ch[0].lcd_cfg.lower_margin	= 5;
+		lcdc_info.ch[0].lcd_cfg.vsync_len	= 5;
+
+		gpio_set_value(GPIO_PTA2, 1);
+		gpio_set_value(GPIO_PTU1, 1);
+	} else {
+		/* Panel */
+		/* not supported */
+	}
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
1.6.0.4


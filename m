From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 02:21:43 +0000
Subject: [PATCH 3/5] ARM: mach-shmobile: mackerel: Add LCDC support
Message-Id: <w3peia450p5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   86 +++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index e2def7e..21443fe 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -34,6 +34,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/smsc911x.h>
 
+#include <video/sh_mobile_lcdc.h>
+
 #include <mach/common.h>
 #include <mach/sh7372.h>
 
@@ -138,9 +140,64 @@ static struct platform_device smc911x_device = {
 	},
 };
 
+/* LCDC */
+static struct fb_videomode mackerel_lcdc_modes[] = {
+	{
+		.name		= "WVGA Panel",
+		.xres		= 800,
+		.yres		= 480,
+		.left_margin	= 220,
+		.right_margin	= 110,
+		.hsync_len	= 70,
+		.upper_margin	= 20,
+		.lower_margin	= 5,
+		.vsync_len	= 5,
+		.sync		= 0,
+	},
+};
+
+static struct sh_mobile_lcdc_info lcdc_info = {
+	.clock_source = LCDC_CLK_BUS,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.lcd_cfg = mackerel_lcdc_modes,
+		.num_cfg = ARRAY_SIZE(mackerel_lcdc_modes),
+		.interface_type		= RGB24,
+		.clock_divider		= 2,
+		.flags			= 0,
+		.lcd_size_cfg.width	= 152,
+		.lcd_size_cfg.height	= 91,
+	}
+};
+
+static struct resource lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000,
+		.end	= 0xfe943fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc_resources),
+	.resource	= lcdc_resources,
+	.dev	= {
+		.platform_data	= &lcdc_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
+	&lcdc_device,
 };
 
 static struct map_desc mackerel_io_desc[] __initdata = {
@@ -176,6 +233,35 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
+	/* LCDC */
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
+	gpio_request(GPIO_PORT31, NULL); /* backlight */
+	gpio_direction_output(GPIO_PORT31, 1);
+
+	gpio_request(GPIO_PORT151, NULL); /* LCDDON */
+	gpio_direction_output(GPIO_PORT151, 1);
+
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
-- 
1.7.0.4


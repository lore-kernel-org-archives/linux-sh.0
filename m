From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jun 2011 06:08:18 +0000
Subject: [PATCH 1/3] sh: ecovec: Add renesas_usbhs support
Message-Id: <w3plix362zx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   48 ++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 3a32741..513cb1a 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/r8a66597.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/spi/spi.h>
@@ -232,6 +233,52 @@ static struct platform_device usb1_common_device = {
 	.resource	= usb1_common_resources,
 };
 
+/*
+ * USBHS
+ */
+static int usbhs_get_id(struct platform_device *pdev)
+{
+	return gpio_get_value(GPIO_PTB3);
+}
+
+static struct renesas_usbhs_platform_info usbhs_info = {
+	.platform_callback = {
+		.get_id		= usbhs_get_id,
+	},
+	.driver_param = {
+		.buswait_bwait		= 4,
+		.detection_delay	= 5,
+	},
+};
+
+static struct resource usbhs_resources[] = {
+	[0] = {
+		.start	= 0xa4d90000,
+		.end	= 0xa4d90124 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 66,
+		.end	= 66,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usbhs_device = {
+	.name	= "renesas_usbhs",
+	.id	= 1,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &usbhs_info,
+	},
+	.num_resources	= ARRAY_SIZE(usbhs_resources),
+	.resource	= usbhs_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_USB1,
+	},
+};
+
 /* LCDC */
 const static struct fb_videomode ecovec_lcd_modes[] = {
 	{
@@ -897,6 +944,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&sh_eth_device,
 	&usb0_host_device,
 	&usb1_common_device,
+	&usbhs_device,
 	&lcdc_device,
 	&ceu0_device,
 	&ceu1_device,
-- 
1.7.4.1


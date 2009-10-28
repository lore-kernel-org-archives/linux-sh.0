From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 28 Oct 2009 06:31:57 +0000
Subject: [PATCH] sh: mach-ecovec24: Add USB1 gadget support
Message-Id: <u3a54jag2.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB1 can change to host/function by checking PTB3.
This patch add USB1 gadget support and check PTB3 when boot,
and change name to usb1_common_XXX from usb1_host_XXX.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   38 +++++++++++++++------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 9d1ccb1..5eeb544 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -174,30 +174,18 @@ static struct platform_device usb0_host_device = {
 	.resource	= usb0_host_resources,
 };
 
-/*
- * USB1
- *
- * CN5 can use both host/function,
- * and we can determine it by checking PTB[3]
- *
- * This time only USB1 host is supported.
- */
+/* USB1 host/function */
 void usb1_port_power(int port, int power)
 {
-	if (!gpio_get_value(GPIO_PTB3)) {
-		printk(KERN_ERR "USB1 function is not supported\n");
-		return;
-	}
-
 	gpio_set_value(GPIO_PTB5, power);
 }
 
-static struct r8a66597_platdata usb1_host_data = {
+static struct r8a66597_platdata usb1_common_data = {
 	.on_chip = 1,
 	.port_power = usb1_port_power,
 };
 
-static struct resource usb1_host_resources[] = {
+static struct resource usb1_common_resources[] = {
 	[0] = {
 		.start	= 0xa4d90000,
 		.end	= 0xa4d90124 - 1,
@@ -210,16 +198,16 @@ static struct resource usb1_host_resources[] = {
 	},
 };
 
-static struct platform_device usb1_host_device = {
-	.name		= "r8a66597_hcd",
+static struct platform_device usb1_common_device = {
+	/* .name will be added in arch_setup */
 	.id		= 1,
 	.dev = {
 		.dma_mask		= NULL,         /*  not use dma */
 		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &usb1_host_data,
+		.platform_data		= &usb1_common_data,
 	},
-	.num_resources	= ARRAY_SIZE(usb1_host_resources),
-	.resource	= usb1_host_resources,
+	.num_resources	= ARRAY_SIZE(usb1_common_resources),
+	.resource	= usb1_common_resources,
 };
 
 /* LCDC */
@@ -605,7 +593,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&nor_flash_device,
 	&sh_eth_device,
 	&usb0_host_device,
-	&usb1_host_device, /* USB1 host support */
+	&usb1_common_device,
 	&lcdc_device,
 	&ceu0_device,
 	&ceu1_device,
@@ -734,6 +722,14 @@ static int __init arch_setup(void)
 	ctrl_outw(0x0600, 0xa40501d4);
 	ctrl_outw(0x0600, 0xa4050192);
 
+	if (gpio_get_value(GPIO_PTB3)) {
+		printk(KERN_INFO "USB1 function is selected\n");
+		usb1_common_device.name = "r8a66597_udc";
+	} else {
+		printk(KERN_INFO "USB1 host is selected\n");
+		usb1_common_device.name = "r8a66597_hcd";
+	}
+
 	/* enable LCDC */
 	gpio_request(GPIO_FN_LCDD23,   NULL);
 	gpio_request(GPIO_FN_LCDD22,   NULL);
-- 
1.6.0.4


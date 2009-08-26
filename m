From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:31 +0000
Subject: [PATCH 3/6] sh: Add USB support for EcoVec24
Message-Id: <uab1mhm4g.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   97 ++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 8c0c845..7850818 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/usb/r8a66597.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <cpu/sh7724.h>
@@ -126,10 +127,96 @@ static struct platform_device sh_eth_device = {
 	.resource = sh_eth_resources,
 };
 
+/* USB0 host */
+void usb0_port_power(int port, int power)
+{
+	gpio_set_value(GPIO_PTB4, power);
+}
+
+static struct r8a66597_platdata usb0_host_data = {
+	.on_chip = 1,
+	.port_power = usb0_port_power,
+};
+
+static struct resource usb0_host_resources[] = {
+	[0] = {
+		.start	= 0xa4d80000,
+		.end	= 0xa4d80124 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 65,
+		.end	= 65,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct platform_device usb0_host_device = {
+	.name		= "r8a66597_hcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &usb0_host_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb0_host_resources),
+	.resource	= usb0_host_resources,
+};
+
+/*
+ * USB1
+ *
+ * CN5 can use both host/function,
+ * and we can determine it by checking PTB[3]
+ *
+ * This time only USB1 host is supported.
+ */
+void usb1_port_power(int port, int power)
+{
+	if (!gpio_get_value(GPIO_PTB3)) {
+		printk(KERN_ERR "USB1 function is not supported\n");
+		return;
+	}
+
+	gpio_set_value(GPIO_PTB5, power);
+}
+
+static struct r8a66597_platdata usb1_host_data = {
+	.on_chip = 1,
+	.port_power = usb1_port_power,
+};
+
+static struct resource usb1_host_resources[] = {
+	[0] = {
+		.start	= 0xa4d90000,
+		.end	= 0xa4d90124 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 66,
+		.end	= 66,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct platform_device usb1_host_device = {
+	.name		= "r8a66597_hcd",
+	.id		= 1,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &usb1_host_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb1_host_resources),
+	.resource	= usb1_host_resources,
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
 	&sh_eth_device,
+	&usb0_host_device,
+	&usb1_host_device, /* USB1 host support */
 };
 
 static int __init devices_setup(void)
@@ -165,6 +252,16 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_MDC,          NULL);
 	gpio_request(GPIO_FN_LNKSTA,       NULL);
 
+	/* enable USB */
+	gpio_request(GPIO_PTB3,  NULL);
+	gpio_request(GPIO_PTB4,  NULL);
+	gpio_request(GPIO_PTB5,  NULL);
+	gpio_direction_input(GPIO_PTB3);
+	gpio_direction_output(GPIO_PTB4, 0);
+	gpio_direction_output(GPIO_PTB5, 0);
+	ctrl_outw(0x0600, 0xa40501d4);
+	ctrl_outw(0x0600, 0xa4050192);
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
1.6.0.4


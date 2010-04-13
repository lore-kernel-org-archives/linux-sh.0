From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Apr 2010 06:16:32 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: ap4evb: Add USB host support
Message-Id: <ueiijyj0h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   63 +++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index e760294..d3b8ca5 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -33,6 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/usb/r8a66597.h>
 #include <mach/common.h>
 #include <mach/sh7372.h>
 #include <asm/mach-types.h>
@@ -94,6 +95,15 @@
  * OFF		| KEY / IrDA / IRQ	| IRQ		|
  */
 
+/*
+ * USB
+ *
+ * J7 : 1-2  MAX3355E VBUS
+ *      2-3  DC 5.0V
+ *
+ * S39: bit2: off
+ */
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -233,11 +243,53 @@ static struct platform_device sdhi0_device = {
 	.id             = 0,
 };
 
+/* USB1 */
+void usb1_host_port_power(int port, int power)
+{
+	if (!power) /* only power-on supported for now */
+		return;
+
+	/* set VBOUT/PWEN and EXTLP1 in DVSTCTR */
+	__raw_writew(__raw_readw(0xE68B0008) | 0x600, 0xE68B0008);
+}
+
+static struct r8a66597_platdata usb1_host_data = {
+	.on_chip	= 1,
+	.port_power	= usb1_host_port_power,
+};
+
+static struct resource usb1_host_resources[] = {
+	[0] = {
+		.name	= "USBHS",
+		.start	= 0xE68B0000,
+		.end	= 0xE68B00E6 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 215,
+		.end	= 215,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb1_host_device = {
+	.name	= "r8a66597_hcd",
+	.id	= 1,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &usb1_host_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb1_host_resources),
+	.resource	= usb1_host_resources,
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&keysc_device,
 	&sdhi0_device,
+	&usb1_host_device,
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
@@ -351,6 +403,17 @@ static void __init ap4evb_init(void)
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
 
+	/* USB enable */
+	gpio_request(GPIO_FN_VBUS0_1,    NULL);
+	gpio_request(GPIO_FN_IDIN_1_18,  NULL);
+	gpio_request(GPIO_FN_PWEN_1_115, NULL);
+	gpio_request(GPIO_FN_OVCN_1_114, NULL);
+	gpio_request(GPIO_FN_EXTLP_1,    NULL);
+	gpio_request(GPIO_FN_OVCN2_1,    NULL);
+
+	/* setup USB phy */
+	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.3.3


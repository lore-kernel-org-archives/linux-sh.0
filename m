From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Jan 2012 01:32:05 +0000
Subject: [PATCH v2] ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd
Message-Id: <87d3ag7a0e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D087CC8.6020803@renesas.com>
In-Reply-To: <4D087CC8.6020803@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current renesas_usbhs driver can use both USB host/gadget.
This patch removes current r8a66597_hcd driver settings,
and adds renesas_usbhs host driver settings for mackerel USB1 port.
You can still use this port as "gadget" with small modify.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- remove r8a66597 comment
- remove r8a66597 header

 arch/arm/mach-shmobile/board-mackerel.c |   73 ++++---------------------------
 1 files changed, 9 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 95ba9b8..c4a6a9b 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -43,7 +43,6 @@
 #include <linux/smsc911x.h>
 #include <linux/sh_intc.h>
 #include <linux/tca6416_keypad.h>
-#include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/dma-mapping.h>
 
@@ -145,11 +144,6 @@
  * 1-2 short | VBUS 5V       | Host
  * open      | external VBUS | Function
  *
- * *1
- * CN31 is used as
- * CONFIG_USB_R8A66597_HCD	Host
- * CONFIG_USB_RENESAS_USBHS	Function
- *
  * CAUTION
  *
  * renesas_usbhs driver can use external interrupt mode
@@ -161,15 +155,6 @@
  * mackerel can not use external interrupt (IRQ7-PORT167) mode on "USB0",
  * because Touchscreen is using IRQ7-PORT40.
  * It is impossible to use IRQ7 demux on this board.
- *
- * We can use external interrupt mode USB-Function on "USB1".
- * USB1 can become Host by r8a66597, and become Function by renesas_usbhs.
- * But don't select both drivers in same time.
- * These uses same IRQ number for request_irq(), and aren't supporting
- * IRQF_SHARED / IORESOURCE_IRQ_SHAREABLE.
- *
- * Actually these are old/new version of USB driver.
- * This mean its register will be broken if it supports shared IRQ,
  */
 
 /*
@@ -686,51 +671,16 @@ static struct platform_device usbhs0_device = {
  * Use J30 to select between Host and Function. This setting
  * can however not be detected by software. Hotplug of USBHS1
  * is provided via IRQ8.
+ *
+ * Current USB1 works as "USB Host".
+ *  - set J30 "short"
+ *
+ * If you want to use it as "USB gadget",
+ *  - J30 "open"
+ *  - modify usbhs1_get_id() USBHS_HOST -> USBHS_GADGET
+ *  - add .get_vbus = usbhs_get_vbus in usbhs1_private
  */
 #define IRQ8 evt2irq(0x0300)
-
-/* USBHS1 USB Host support via r8a66597_hcd */
-static void usb1_host_port_power(int port, int power)
-{
-	if (!power) /* only power-on is supported for now */
-		return;
-
-	/* set VBOUT/PWEN and EXTLP1 in DVSTCTR */
-	__raw_writew(__raw_readw(0xE68B0008) | 0x600, 0xE68B0008);
-}
-
-static struct r8a66597_platdata usb1_host_data = {
-	.on_chip	= 1,
-	.port_power	= usb1_host_port_power,
-};
-
-static struct resource usb1_host_resources[] = {
-	[0] = {
-		.name	= "USBHS1",
-		.start	= 0xe68b0000,
-		.end	= 0xe68b00e6 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= evt2irq(0x1ce0) /* USB1_USB1I0 */,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device usb1_host_device = {
-	.name	= "r8a66597_hcd",
-	.id	= 1,
-	.dev = {
-		.dma_mask		= NULL,         /*  not use dma */
-		.coherent_dma_mask	= 0xffffffff,
-		.platform_data		= &usb1_host_data,
-	},
-	.num_resources	= ARRAY_SIZE(usb1_host_resources),
-	.resource	= usb1_host_resources,
-};
-
-/* USBHS1 USB Function support via renesas_usbhs */
-
 #define USB_PHY_MODE		(1 << 4)
 #define USB_PHY_INT_EN		((1 << 3) | (1 << 2))
 #define USB_PHY_ON		(1 << 1)
@@ -786,7 +736,7 @@ static void usbhs1_hardware_exit(struct platform_device *pdev)
 
 static int usbhs1_get_id(struct platform_device *pdev)
 {
-	return USBHS_GADGET;
+	return USBHS_HOST;
 }
 
 static u32 usbhs1_pipe_cfg[] = {
@@ -817,7 +767,6 @@ static struct usbhs_private usbhs1_private = {
 			.hardware_exit	= usbhs1_hardware_exit,
 			.get_id		= usbhs1_get_id,
 			.phy_reset	= usbhs_phy_reset,
-			.get_vbus	= usbhs_get_vbus,
 		},
 		.driver_param = {
 			.buswait_bwait	= 4,
@@ -1321,7 +1270,6 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
-	&usb1_host_device,
 	&usbhs1_device,
 	&usbhs0_device,
 	&leds_device,
@@ -1483,9 +1431,6 @@ static void __init mackerel_init(void)
 	gpio_pull_down(GPIO_PORT167CR); /* VBUS0_1 pull down */
 	gpio_request(GPIO_FN_IDIN_1_113, NULL);
 
-	/* USB phy tweak to make the r8a66597_hcd host driver work */
-	__raw_writew(0x8a0a, 0xe6058130);       /* USBCR4 */
-
 	/* enable FSI2 port A (ak4643) */
 	gpio_request(GPIO_FN_FSIAIBT,	NULL);
 	gpio_request(GPIO_FN_FSIAILR,	NULL);
-- 
1.7.5.4


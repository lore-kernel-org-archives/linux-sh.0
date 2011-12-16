From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Dec 2011 01:55:04 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd
Message-Id: <87hb11e0wa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
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
 arch/arm/mach-shmobile/board-mackerel.c |   55 +++++--------------------------
 1 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9c5e598..07f8886 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -676,51 +676,16 @@ static struct platform_device usbhs0_device = {
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
@@ -776,7 +741,7 @@ static void usbhs1_hardware_exit(struct platform_device *pdev)
 
 static int usbhs1_get_id(struct platform_device *pdev)
 {
-	return USBHS_GADGET;
+	return USBHS_HOST;
 }
 
 static u32 usbhs1_pipe_cfg[] = {
@@ -807,7 +772,6 @@ static struct usbhs_private usbhs1_private = {
 			.hardware_exit	= usbhs1_hardware_exit,
 			.get_id		= usbhs1_get_id,
 			.phy_reset	= usbhs_phy_reset,
-			.get_vbus	= usbhs_get_vbus,
 		},
 		.driver_param = {
 			.buswait_bwait	= 4,
@@ -1299,7 +1263,6 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
-	&usb1_host_device,
 	&usbhs1_device,
 	&usbhs0_device,
 	&leds_device,
-- 
1.7.5.4


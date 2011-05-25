From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 May 2011 02:49:25 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: mackerel: add renesas_usbhs support
Message-Id: <w3p8vtvv6iy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CN31 USB1 can be Host/Function, and it can use IRQ8 as USB-phy.
This mean we can power off it if...
 - while USB1 is disconnected.
 - USB-Function is selected.
 - driver is supporting it.

OTOH, CN22 USB0 which is only USB Function
can not use USB-phy interrupt (IRQ7) on mackerel board.
Because IRQ7 is already used by Touchscreen,
and it is impossible to use cascaded IRQ7.

renesas_usbhs driver which is supporting USB-Function
is supporting USB power off when disconnect.
mackerel board will use renesas_usbhs driver as
USB-Function on CN31 if it have CONFIG_USB_RENESAS_USBHS.
And r8a66597_hcd will be used as USB Host if it have CONFIG_USB_R8A66597_HCD.

But you can not select both CONFIG_USB_R8A66597_HCD and
CONFIG_USB_RENESAS_USBHS in same time for now.
Because IRQ8 will be requested in different driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |  175 ++++++++++++++++++++++++++++++-
 1 files changed, 174 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index efceb1d..512dc4c 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -43,6 +43,7 @@
 #include <linux/sh_intc.h>
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/r8a66597.h>
+#include <linux/usb/renesas_usbhs.h>
 
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
@@ -143,7 +144,9 @@
  * open      | external VBUS | Function
  *
  * *1
- * CN31 is used as Host in Linux.
+ * CN31 is used as
+ * CONFIG_USB_R8A66597_HCD	Host
+ * CONFIG_USB_RENESAS_USBHS	Function
  */
 
 /*
@@ -185,6 +188,7 @@
  * FIXME !!
  *
  * gpio_no_direction
+ * gpio_pull_down
  * are quick_hack.
  *
  * current gpio frame work doesn't have
@@ -196,6 +200,16 @@ static void __init gpio_no_direction(u32 addr)
 	__raw_writeb(0x00, addr);
 }
 
+static void __init gpio_pull_down(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xA0;
+
+	__raw_writeb(data, addr);
+}
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -509,6 +523,162 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+#if defined(CONFIG_USB_RENESAS_USBHS) && defined(CONFIG_USB_R8A66597_HCD)
+/* same IRQ8 will be requested in different driver */
+#error	dont't select R8A66597_HCD and RENESAS_USBHS in same time
+#endif
+
+/* USB1 (Function) */
+#define USB_PHY_MODE		(1 << 4)
+#define USB_PHY_INT_EN		((1 << 3) | (1 << 2))
+#define USB_PHY_ON		(1 << 1)
+#define USB_PHY_OFF		(1 << 0)
+#define USB_PHY_INT_CLR		(USB_PHY_ON | USB_PHY_OFF)
+
+struct usbhs_private {
+	unsigned int irq;
+	unsigned int usbphyaddr;
+	unsigned int usbcrcaddr;
+	struct renesas_usbhs_platform_info info;
+};
+
+#define usbhs_get_priv(pdev)				\
+	container_of(renesas_usbhs_get_info(pdev),	\
+		     struct usbhs_private, info)
+
+#define usbhs_is_connected(priv)			\
+	(!((1 << 7) & __raw_readw(priv->usbcrcaddr)))
+
+static int usbhs1_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static int usbhs1_get_vbus(struct platform_device *pdev)
+{
+	return usbhs_is_connected(usbhs_get_priv(pdev));
+}
+
+static irqreturn_t usbhs1_interrupt(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	renesas_usbhs_call_notify_hotplug(pdev);
+
+	/* clear status */
+	__raw_writew(__raw_readw(priv->usbphyaddr) | USB_PHY_INT_CLR,
+		     priv->usbphyaddr);
+
+	return IRQ_HANDLED;
+}
+
+static int usbhs1_hardware_init(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+	int ret;
+
+	irq_set_irq_type(priv->irq, IRQ_TYPE_LEVEL_HIGH);
+
+	/* clear interrupt status */
+	__raw_writew(USB_PHY_MODE | USB_PHY_INT_CLR, priv->usbphyaddr);
+
+	ret = request_irq(priv->irq, usbhs1_interrupt, 0,
+			  dev_name(&pdev->dev), pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq err\n");
+		return ret;
+	}
+
+	/* enable USB phy interrupt */
+	__raw_writew(USB_PHY_MODE | USB_PHY_INT_EN, priv->usbphyaddr);
+
+	return 0;
+}
+
+static void usbhs1_hardware_exit(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	/* clear interrupt status */
+	__raw_writew(USB_PHY_MODE | USB_PHY_INT_CLR, priv->usbphyaddr);
+
+	free_irq(priv->irq, pdev);
+}
+
+static void usbhs1_phy_reset(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	/* init phy */
+	__raw_writew(0x8a0a, priv->usbcrcaddr);
+}
+
+static u32 usbhs1_pipe_cfg[] = {
+	USB_ENDPOINT_XFER_CONTROL,
+	USB_ENDPOINT_XFER_ISOC,
+	USB_ENDPOINT_XFER_ISOC,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_INT,
+	USB_ENDPOINT_XFER_INT,
+	USB_ENDPOINT_XFER_INT,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+	USB_ENDPOINT_XFER_BULK,
+};
+
+static struct usbhs_private usbhs1_private = {
+	.irq		= evt2irq(0x0300),	/* IRQ8 */
+	.usbphyaddr	= 0xE60581E2,		/* USBPHY1INTAP */
+	.usbcrcaddr	= 0xE6058130,		/* USBCR4 */
+	.info = {
+		.platform_callback = {
+			.hardware_init	= usbhs1_hardware_init,
+			.hardware_exit	= usbhs1_hardware_exit,
+			.phy_reset	= usbhs1_phy_reset,
+			.get_id		= usbhs1_get_id,
+			.get_vbus	= usbhs1_get_vbus,
+		},
+		.driver_param = {
+			.buswait_bwait	= 4,
+			.pipe_type	= usbhs1_pipe_cfg,
+			.pipe_size	= ARRAY_SIZE(usbhs1_pipe_cfg),
+		},
+	},
+};
+
+static struct resource usbhs1_resources[] = {
+	[0] = {
+		.name	= "USBHS",
+		.start	= 0xE68B0000,
+		.end	= 0xE68B00E6 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x1ce0) /* USB1_USB1I0 */,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usbhs1_device = {
+	.name	= "renesas_usbhs",
+	.id	= 1,
+	.dev = {
+		.platform_data		= &usbhs1_private.info,
+	},
+	.num_resources	= ARRAY_SIZE(usbhs1_resources),
+	.resource	= usbhs1_resources,
+};
+
+
 /* LED */
 static struct gpio_led mackerel_leds[] = {
 	{
@@ -949,6 +1119,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&smc911x_device,
 	&lcdc_device,
 	&usb1_host_device,
+	&usbhs1_device,
 	&leds_device,
 	&fsi_device,
 	&fsi_ak4643_device,
@@ -1044,6 +1215,7 @@ static void __init mackerel_map_io(void)
 
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
+#define GPIO_PORT168CR	0xE60520A8
 #define SRCR4		0xe61580bc
 #define USCCR1		0xE6058144
 static void __init mackerel_init(void)
@@ -1102,6 +1274,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_OVCN_1_114, NULL);
 	gpio_request(GPIO_FN_EXTLP_1,    NULL);
 	gpio_request(GPIO_FN_OVCN2_1,    NULL);
+	gpio_pull_down(GPIO_PORT168CR);
 
 	/* setup USB phy */
 	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR4 */
-- 
1.7.1


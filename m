From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Jul 2012 03:55:56 +0000
Subject: [PATCH 5/7] ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
Message-Id: <87ipe4tc1i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We can control renesas_usbhs driver as 2 way which are
autonomy mode and external IRQ trigger mode.

Autonomy mode is very easy settings for platform,
but it required USB power domain always ON,
since its connection/disconnection IRQ come from it.

If platform uses external IRQ trigger mode,
USB power domain can be OFF, since its
connection/disconnection IRQ come from external IRQ.

This patch enable external IRQ mode.
Now it is possible to add USB support on A4SP domain.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   46 +++++++++++++++++++----
 1 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 7c77f07..5002f64 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -133,14 +133,8 @@
  * These are a little bit complex.
  * see
  *	usbhsf_power_ctrl()
- *
- * CAUTION
- *
- * It uses autonomy mode for USB hotplug at this point
- * (= usbhs_private.platform_callback.get_vbus is NULL),
- * since we don't know what's happen on PM control
- * on this workaround.
  */
+#define IRQ7		evt2irq(0x02e0)
 #define USBCR1		0xe605810a
 #define USBH		0xC6700000
 #define USBH_USBCTR	0x10834
@@ -220,6 +214,20 @@ static void usbhsf_power_ctrl(struct platform_device *pdev,
 	}
 }
 
+static int usbhsf_get_vbus(struct platform_device *pdev)
+{
+	return gpio_get_value(GPIO_PORT209);
+}
+
+static irqreturn_t usbhsf_interrupt(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+
+	renesas_usbhs_call_notify_hotplug(pdev);
+
+	return IRQ_HANDLED;
+}
+
 static void usbhsf_hardware_exit(struct platform_device *pdev)
 {
 	struct usbhsf_private *priv = usbhsf_get_priv(pdev);
@@ -243,11 +251,14 @@ static void usbhsf_hardware_exit(struct platform_device *pdev)
 	priv->host	= NULL;
 	priv->func	= NULL;
 	priv->usbh_base	= NULL;
+
+	free_irq(IRQ7, pdev);
 }
 
 static int usbhsf_hardware_init(struct platform_device *pdev)
 {
 	struct usbhsf_private *priv = usbhsf_get_priv(pdev);
+	int ret;
 
 	priv->phy	= clk_get(&pdev->dev, "phy");
 	priv->usb24	= clk_get(&pdev->dev, "usb24");
@@ -267,6 +278,14 @@ static int usbhsf_hardware_init(struct platform_device *pdev)
 		return -EIO;
 	}
 
+	ret = request_irq(IRQ7, usbhsf_interrupt, IRQF_TRIGGER_NONE,
+			  dev_name(&pdev->dev), pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq err\n");
+		return ret;
+	}
+	irq_set_irq_type(IRQ7, IRQ_TYPE_EDGE_BOTH);
+
 	/* usb24 use 1/1 of parent clock (= usb24s = 24MHz) */
 	clk_set_rate(priv->usb24,
 		     clk_get_rate(clk_get_parent(priv->usb24)));
@@ -278,6 +297,7 @@ static struct usbhsf_private usbhsf_private = {
 	.info = {
 		.platform_callback = {
 			.get_id		= usbhsf_get_id,
+			.get_vbus	= usbhsf_get_vbus,
 			.hardware_init	= usbhsf_hardware_init,
 			.hardware_exit	= usbhsf_hardware_exit,
 			.power_ctrl	= usbhsf_power_ctrl,
@@ -1018,7 +1038,17 @@ static void __init eva_init(void)
 		/* USB Host */
 	} else {
 		/* USB Func */
-		gpio_request(GPIO_FN_VBUS, NULL);
+		/*
+		 * A1 chip has 2 IRQ7 pin and it was controled by MSEL register.
+		 * OTOH, usbhs interrupt needs its value (HI/LOW) to decide
+		 * USB connection/disconnection (usbhsf_get_vbus()).
+		 * This means we needs to select GPIO_FN_IRQ7_PORT209 first,
+		 * and select GPIO_PORT209 here
+		 */
+		gpio_request(GPIO_FN_IRQ7_PORT209, NULL);
+		gpio_request(GPIO_PORT209, NULL);
+		gpio_direction_input(GPIO_PORT209);
+
 		platform_device_register(&usbhsf_device);
 	}
 
-- 
1.7.5.4


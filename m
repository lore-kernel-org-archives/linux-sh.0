From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2012 04:57:14 +0000
Subject: [PATCH 3/3 v2] ARM: mach-shmobile: armadillo800eva: add USB function support
Message-Id: <87vcl05l5l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - add workaround explain

 arch/arm/mach-shmobile/board-armadillo800eva.c |  217 ++++++++++++++++++++++++
 1 files changed, 217 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 9cd9a69..6a7d2b9 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -20,14 +20,17 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/input.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/sh_eth.h>
 #include <linux/videodev2.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <asm/page.h>
@@ -90,6 +93,9 @@
  *      0    | SDHI1         | COM8 disable, COM14 enable
  *      1    | SDHI1         | COM8 enable,  COM14 disable
  * -12345678-+---------------+----------------------------
+ *       0   | USB0          | COM20 enable,  COM24 disable
+ *       1   | USB0          | COM20 disable, COM24 enable
+ * -12345678-+---------------+----------------------------
  *        00 | JTAG          | SH-X2
  *        10 | JTAG          | ARM
  *        01 | JTAG          | -
@@ -97,6 +103,205 @@
  *-----------+---------------+----------------------------
  */
 
+/*
+ * USB function
+ *
+ * When you use USB Function,
+ * set SW1.6 ON, and connect cable to CN24.
+ *
+ * USBF needs workaround on R8A7740 chip.
+ * These are a little bit complex.
+ * see
+ *	usbhsf_power_ctrl()
+ *
+ * CAUTION
+ *
+ * It uses autonomy mode for USB hotplug at this point
+ * (= usbhs_private.platform_callback.get_vbus is NULL),
+ * since we don't know what's happen on PM control
+ * on this workaround.
+ */
+#define USBCR1		0xe605810a
+#define USBH		0xC6700000
+#define USBH_USBCTR	0x10834
+
+struct usbhsf_private {
+	struct clk *phy;
+	struct clk *usb24;
+	struct clk *pci;
+	struct clk *func;
+	struct clk *host;
+	struct clk *sys;
+	void __iomem *usbh_base;
+	struct renesas_usbhs_platform_info info;
+};
+
+#define usbhsf_get_priv(pdev)				\
+	container_of(renesas_usbhs_get_info(pdev),	\
+		     struct usbhsf_private, info)
+
+static int usbhsf_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static void usbhsf_power_ctrl(struct platform_device *pdev,
+			      void __iomem *base, int enable)
+{
+	struct usbhsf_private *priv = usbhsf_get_priv(pdev);
+
+	/*
+	 * Work around for USB Function.
+	 * It needs USB host clock, and settings
+	 */
+	if (enable) {
+		/*
+		 * enable all the related usb clocks
+		 * for usb workaround
+		 */
+		clk_enable(priv->usb24);
+		clk_enable(priv->pci);
+		clk_enable(priv->host);
+		clk_enable(priv->func);
+		clk_enable(priv->phy);
+
+		/*
+		 * set USBCR1
+		 *
+		 * Port1 is driven by USB function,
+		 * Port2 is driven by USB HOST
+		 * One HOST (Port1 or Port2 is HOST)
+		 * USB PLL input clock = 24MHz
+		 */
+		__raw_writew(0xd750, USBCR1);
+		mdelay(1);
+
+		/*
+		 * start USB Host
+		 */
+		__raw_writel(0x0000000c, priv->usbh_base + USBH_USBCTR);
+		__raw_writel(0x00000008, priv->usbh_base + USBH_USBCTR);
+		mdelay(10);
+
+		/*
+		 * USB PHY Power ON
+		 */
+		__raw_writew(0xd770, USBCR1);
+		__raw_writew(0x4000, base + 0x102); /* USBF :: SUSPMODE */
+
+	} else {
+		__raw_writel(0x0000010f, priv->usbh_base + USBH_USBCTR);
+		__raw_writew(0xd7c0, USBCR1); /* GPIO */
+
+		clk_disable(priv->phy);
+		clk_disable(priv->func);	/* usb work around */
+		clk_disable(priv->host);	/* usb work around */
+		clk_disable(priv->pci);		/* usb work around */
+		clk_disable(priv->usb24);	/* usb work around */
+	}
+}
+
+static void usbhsf_hardware_exit(struct platform_device *pdev)
+{
+	struct usbhsf_private *priv = usbhsf_get_priv(pdev);
+
+	if (!IS_ERR(priv->phy))
+		clk_put(priv->phy);
+	if (!IS_ERR(priv->usb24))
+		clk_put(priv->usb24);
+	if (!IS_ERR(priv->pci))
+		clk_put(priv->pci);
+	if (!IS_ERR(priv->host))
+		clk_put(priv->host);
+	if (!IS_ERR(priv->func))
+		clk_put(priv->func);
+	if (!IS_ERR(priv->sys))
+		clk_put(priv->sys);
+	if (priv->usbh_base)
+		iounmap(priv->usbh_base);
+
+	priv->phy	= NULL;
+	priv->usb24	= NULL;
+	priv->pci	= NULL;
+	priv->host	= NULL;
+	priv->func	= NULL;
+	priv->sys	= NULL;
+	priv->usbh_base	= NULL;
+}
+
+static int usbhsf_hardware_init(struct platform_device *pdev)
+{
+	struct usbhsf_private *priv = usbhsf_get_priv(pdev);
+	int ret;
+
+	priv->phy	= clk_get(&pdev->dev, "phy");
+	priv->usb24	= clk_get(&pdev->dev, "usb24");
+	priv->pci	= clk_get(&pdev->dev, "pci");
+	priv->func	= clk_get(&pdev->dev, "func");
+	priv->host	= clk_get(&pdev->dev, "host");
+	priv->sys	= clk_get(NULL, "system_clk");
+	priv->usbh_base	= ioremap_nocache(USBH, 0x20000);
+
+	if (IS_ERR(priv->phy)		||
+	    IS_ERR(priv->usb24)		||
+	    IS_ERR(priv->pci)		||
+	    IS_ERR(priv->host)		||
+	    IS_ERR(priv->func)		||
+	    IS_ERR(priv->sys)		||
+	    !priv->usbh_base)
+		goto usbhsf_hardware_init_exit;
+
+	ret = clk_set_parent(priv->usb24, priv->sys);
+	if (ret < 0)
+		goto usbhsf_hardware_init_exit;
+
+	return 0;
+
+usbhsf_hardware_init_exit:
+	dev_err(&pdev->dev, "USB clock setting failed\n");
+	usbhsf_hardware_exit(pdev);
+
+	return -EIO;
+}
+
+static struct usbhsf_private usbhsf_private = {
+	.info = {
+		.platform_callback = {
+			.get_id		= usbhsf_get_id,
+			.hardware_init	= usbhsf_hardware_init,
+			.hardware_exit	= usbhsf_hardware_exit,
+			.power_ctrl	= usbhsf_power_ctrl,
+		},
+		.driver_param = {
+			.buswait_bwait		= 5,
+			.detection_delay	= 5,
+		},
+	}
+};
+
+static struct resource usbhsf_resources[] = {
+	{
+		.name	= "USBHS",
+		.start	= 0xe6890000,
+		.end	= 0xe6890104 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= evt2irq(0x0A20),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usbhsf_device = {
+	.name	= "renesas_usbhs",
+	.dev = {
+		.platform_data = &usbhsf_private.info,
+	},
+	.id = -1,
+	.num_resources	= ARRAY_SIZE(usbhsf_resources),
+	.resource	= usbhsf_resources,
+};
+
 /* Ether */
 static struct sh_eth_plat_data sh_eth_platdata = {
 	.phy			= 0x00, /* LAN8710A */
@@ -302,6 +507,18 @@ static void __init eva_init(void)
 	gpio_request(GPIO_PORT166,	NULL); /* TP_RST_B */
 	gpio_direction_output(GPIO_PORT166, 1);
 
+	/* USB */
+	gpio_request(GPIO_PORT159, NULL); /* USB_DEVICE_MODE */
+	gpio_direction_input(GPIO_PORT159);
+
+	if (gpio_get_value(GPIO_PORT159)) {
+		/* USB Host */
+	} else {
+		/* USB Func */
+		gpio_request(GPIO_FN_VBUS, NULL);
+		platform_device_register(&usbhsf_device);
+	}
+
 	/*
 	 * CAUTION
 	 *
-- 
1.7.5.4


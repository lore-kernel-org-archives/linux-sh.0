From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Apr 2014 06:34:00 +0000
Subject: [PATCH 02/05] ARM: shmobile: Lager DT reference USB platform devices
Message-Id: <20140407063400.26152.37084.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Hook up three USB ports on Lager via the DT reference code
using platform devices. This adds support for USB function
on USB0 and USB Host for USB1 and USB2. Not for upstream merge.

Based on the Lager legacy code by Valentine Bershak.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |  211 ++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-04-07 14:08:31.000000000 +0900
@@ -19,9 +19,14 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
+#include <linux/platform_data/usb-rcar-gen2-phy.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -106,6 +111,7 @@ static const struct clk_name clk_names[]
 	{ "du2", "du.2", "rcar-du-r8a7790" },
 	{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
 	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
+	{ "hsusb", NULL, "usb_phy_rcar_gen2" },
 };
 
 /*
@@ -119,8 +125,205 @@ static const struct clk_name clk_enables
 	{ "sdhi0", NULL, "ee100000.sd" },
 	{ "sdhi2", NULL, "ee140000.sd" },
 	{ "thermal", NULL, "e61f0000.thermal" },
+	{ "hsusb", NULL, "renesas_usbhs" },
+	{ "ehci", NULL, "pci-rcar-gen2.1" },
+	{ "ehci", NULL, "pci-rcar-gen2.2" },
 };
 
+/* USBHS */
+static const struct resource usbhs_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6590000, 0x100),
+	DEFINE_RES_IRQ(gic_spi(107)),
+};
+
+struct usbhs_private {
+	struct renesas_usbhs_platform_info info;
+	struct usb_phy *phy;
+	int pwen_gpio;
+};
+
+#define usbhs_get_priv(pdev) \
+	container_of(renesas_usbhs_get_info(pdev), struct usbhs_private, info)
+
+static int usbhs_power_ctrl(struct platform_device *pdev,
+				void __iomem *base, int enable)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	if (!priv->phy)
+		return -ENODEV;
+
+	if (enable) {
+		int retval = usb_phy_init(priv->phy);
+
+		if (!retval)
+			retval = usb_phy_set_suspend(priv->phy, 0);
+		return retval;
+	}
+
+	usb_phy_set_suspend(priv->phy, 1);
+	usb_phy_shutdown(priv->phy);
+	return 0;
+}
+
+static int usbhs_hardware_init(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+	struct usb_phy *phy;
+	int ret;
+	struct device_node *np;
+
+	np = of_find_node_by_path("/gpio@e6055000");
+	if (np) {
+		priv->pwen_gpio = of_get_gpio(np, 18);
+		of_node_put(np);
+	} else {
+		pr_warn("Error: Unable to get PWEN GPIO line\n");
+		ret = -ENOTSUPP;
+		goto error2;
+	}
+
+	/* USB0 Function - use PWEN as GPIO input to detect DIP Switch SW5
+	 * setting to avoid VBUS short circuit due to wrong cable.
+	 * PWEN should be pulled up high if USB Function is selected by SW5
+	 */
+	gpio_request_one(priv->pwen_gpio, GPIOF_IN, NULL); /* USB0_PWEN */
+	if (!gpio_get_value(priv->pwen_gpio)) {
+		pr_warn("Error: USB Function not selected - check SW5 + SW6\n");
+		ret = -ENOTSUPP;
+		goto error;
+	}
+
+	phy = usb_get_phy_dev(&pdev->dev, 0);
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		goto error;
+	}
+
+	priv->phy = phy;
+	return 0;
+ error:
+	gpio_free(priv->pwen_gpio);
+ error2:
+	return ret;
+}
+
+static int usbhs_hardware_exit(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	if (!priv->phy)
+		return 0;
+
+	usb_put_phy(priv->phy);
+	priv->phy = NULL;
+	gpio_free(priv->pwen_gpio);
+	return 0;
+}
+
+static int usbhs_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static u32 lager_usbhs_pipe_type[] = {
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
+static struct usbhs_private usbhs_priv __initdata = {
+	.info = {
+		.platform_callback = {
+			.power_ctrl	= usbhs_power_ctrl,
+			.hardware_init	= usbhs_hardware_init,
+			.hardware_exit	= usbhs_hardware_exit,
+			.get_id		= usbhs_get_id,
+		},
+		.driver_param = {
+			.buswait_bwait	= 4,
+			.pipe_type = lager_usbhs_pipe_type,
+			.pipe_size = ARRAY_SIZE(lager_usbhs_pipe_type),
+		},
+	}
+};
+
+static void __init lager_register_usbhs(void)
+{
+	usb_bind_phy("renesas_usbhs", 0, "usb_phy_rcar_gen2");
+	platform_device_register_resndata(&platform_bus,
+					  "renesas_usbhs", -1,
+					  usbhs_resources,
+					  ARRAY_SIZE(usbhs_resources),
+					  &usbhs_priv.info,
+					  sizeof(usbhs_priv.info));
+}
+
+/* USBHS PHY */
+static const struct rcar_gen2_phy_platform_data usbhs_phy_pdata __initconst = {
+	.chan0_pci = 0,	/* Channel 0 is USBHS */
+	.chan2_pci = 1,	/* Channel 2 is PCI USB */
+};
+
+static const struct resource usbhs_phy_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6590100, 0x100),
+};
+
+/* Internal PCI1 */
+static const struct resource pci1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0b0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0a0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(112)),
+};
+
+static const struct platform_device_info pci1_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "pci-rcar-gen2",
+	.id		= 1,
+	.res		= pci1_resources,
+	.num_res	= ARRAY_SIZE(pci1_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
+static void __init lager_add_usb1_device(void)
+{
+	platform_device_register_full(&pci1_info);
+}
+
+/* Internal PCI2 */
+static const struct resource pci2_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0d0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0c0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
+static const struct platform_device_info pci2_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "pci-rcar-gen2",
+	.id		= 2,
+	.res		= pci2_resources,
+	.num_res	= ARRAY_SIZE(pci2_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
+static void __init lager_add_usb2_device(void)
+{
+	platform_device_register_full(&pci2_info);
+}
+
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
@@ -129,6 +332,14 @@ static void __init lager_add_standard_de
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
+	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+					  -1, usbhs_phy_resources,
+					  ARRAY_SIZE(usbhs_phy_resources),
+					  &usbhs_phy_pdata,
+					  sizeof(usbhs_phy_pdata));
+	lager_register_usbhs();
+	lager_add_usb1_device();
+	lager_add_usb2_device();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {

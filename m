From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Apr 2014 06:34:17 +0000
Subject: [PATCH 04/05] ARM: shmobile: Koelsch DT reference USB platform devices
Message-Id: <20140407063417.26152.68305.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Hook up two USB ports on Koelsch via the DT reference code
using platform devices. This adds support for USB function
on USB0 and USB Host on USB1. Not for upstream merge.

Based on the following patch by Vladimir Barinov:
"[PATCH V5 3/4] ARM: shmobile: koelsch: Add USBHS and internal PCI USB support"

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch-reference.c |  184 ++++++++++++++++++++++
 1 file changed, 184 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-04-07 14:31:37.000000000 +0900
@@ -20,9 +20,14 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/gpio.h>
 #include <linux/kernel.h>
+#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
+#include <linux/platform_data/usb-rcar-gen2-phy.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -105,6 +110,7 @@ static const struct clk_name clk_names[]
 	{ "du0", "du.0", "rcar-du-r8a7791" },
 	{ "du1", "du.1", "rcar-du-r8a7791" },
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
+	{ "hsusb", NULL, "usb_phy_rcar_gen2" },
 };
 
 /*
@@ -119,8 +125,185 @@ static const struct clk_name clk_enables
 	{ "sdhi1", NULL, "ee140000.sd" },
 	{ "sdhi2", NULL, "ee160000.sd" },
 	{ "thermal", NULL, "e61f0000.thermal" },
+	{ "hsusb", NULL, "renesas_usbhs" },
+	{ "ehci", NULL, "pci-rcar-gen2.1" },
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
+	int id_gpio;
+};
+
+#define usbhs_get_priv(pdev) \
+	container_of(renesas_usbhs_get_info(pdev), struct usbhs_private, info)
+
+static int usbhs_power_ctrl(struct platform_device *pdev,
+                               void __iomem *base, int enable)
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
+		priv->id_gpio = of_get_gpio(np, 31);
+		of_node_put(np);
+	} else {
+		pr_warn("Error: Unable to get MAX3355 ID input\n");
+		ret = -ENOTSUPP;
+		goto error2;
+	}
+
+	/* Check MAX3355E ID pin */
+	gpio_request_one(priv->id_gpio, GPIOF_IN, NULL);
+	if (!gpio_get_value(priv->id_gpio)) {
+		pr_warn("Error: USB0 cable selects host mode\n");
+		ret = -ENOTSUPP;
+		goto error;
+	}
+
+	phy = usb_get_phy_dev(&pdev->dev, 0);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	priv->phy = phy;
+	return 0;
+
+error:
+	gpio_free(priv->id_gpio);
+error2:
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
+
+	gpio_free(priv->id_gpio);
+	return 0;
+}
+
+static int usbhs_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static u32 koelsch_usbhs_pipe_type[] = {
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
+			.pipe_type	= koelsch_usbhs_pipe_type,
+			.pipe_size	= ARRAY_SIZE(koelsch_usbhs_pipe_type),
+		},
+	}
+};
+
+static void __init koelsch_add_usb0_gadget(void)
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
+/* Internal PCI1 */
+static const struct resource pci1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0d0000, 0x10000),    /* CFG */
+	DEFINE_RES_MEM(0xee0c0000, 0x10000),    /* MEM */
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
+static void __init koelsch_add_usb1_host(void)
+{
+	platform_device_register_simple("pci-rcar-gen2",
+					1, pci1_resources,
+					ARRAY_SIZE(pci1_resources));
+}
+
+/* USBHS PHY */
+static const struct rcar_gen2_phy_platform_data usbhs_phy_pdata __initconst = {
+	.chan0_pci = 0, /* Channel 0 is USBHS */
+	.chan2_pci = 1, /* Channel 2 is PCI USB host */
+};
+
+static const struct resource usbhs_phy_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6590100, 0x100),
+};
+
+/* Add all available USB devices */
+static void __init koelsch_add_usb_devices(void)
+{
+	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+					  -1, usbhs_phy_resources,
+					  ARRAY_SIZE(usbhs_phy_resources),
+					  &usbhs_phy_pdata,
+					  sizeof(usbhs_phy_pdata));
+	koelsch_add_usb0_gadget();
+	koelsch_add_usb1_host();
+}
+
 static void __init koelsch_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
@@ -129,6 +312,7 @@ static void __init koelsch_add_standard_
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	koelsch_add_du_device();
+	koelsch_add_usb_devices();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {

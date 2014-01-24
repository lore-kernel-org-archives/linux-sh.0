From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:29:04 +0000
Subject: [PATCH V3 2/4] ARM: shmobile: koelsch: Add USBHS support
Message-Id: <1390602546-11911-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds USBHS PHY and registers USBHS device if the driver is enabled.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-koelsch.c | 138 +++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

Changes in V3:
* none.

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag;
* added pipe_type array to the usbhs platform info since it differs from the default.

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 2ab5c75..9ec1564 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -29,8 +29,11 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
+#include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
@@ -163,6 +166,131 @@ static const struct platform_device_info sata0_info __initconst = {
 	.dma_mask	= DMA_BIT_MASK(32),
 };
 
+/* USBHS */
+#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
+static const struct resource usbhs_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6590000, 0x100),
+	DEFINE_RES_IRQ(gic_spi(107)),
+};
+
+struct usbhs_private {
+	struct renesas_usbhs_platform_info info;
+	struct usb_phy *phy;
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
+
+	phy = usb_get_phy_dev(&pdev->dev, 0);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	priv->phy = phy;
+	return 0;
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
+			.pipe_type = koelsch_usbhs_pipe_type,
+			.pipe_size = ARRAY_SIZE(koelsch_usbhs_pipe_type),
+		},
+	}
+};
+
+static void __init koelsch_register_usbhs(void)
+{
+	usb_bind_phy("renesas_usbhs", 0, "usb_phy_rcar_gen2");
+	platform_device_register_resndata(&platform_bus,
+					  "renesas_usbhs", -1,
+					  usbhs_resources,
+					  ARRAY_SIZE(usbhs_resources),
+					  &usbhs_priv.info,
+					  sizeof(usbhs_priv.info));
+}
+#else	/* CONFIG_USB_RENESAS_USBHS_UDC */
+static inline void koelsch_register_usbhs(void) { }
+#endif	/* CONFIG_USB_RENESAS_USBHS_UDC */
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
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -186,6 +314,9 @@ static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7791",
 				  "scif1_data_d", "scif1"),
+	/* USB0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7791",
+				  "usb0", "usb0"),
 };
 
 static void __init koelsch_add_standard_devices(void)
@@ -209,6 +340,13 @@ static void __init koelsch_add_standard_devices(void)
 	koelsch_add_du_device();
 
 	platform_device_register_full(&sata0_info);
+
+	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+					  -1, usbhs_phy_resources,
+					  ARRAY_SIZE(usbhs_phy_resources),
+					  &usbhs_phy_pdata,
+					  sizeof(usbhs_phy_pdata));
+	koelsch_register_usbhs();
 }
 
 /*
-- 
1.8.3.1


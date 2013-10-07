From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Mon, 07 Oct 2013 23:27:03 +0000
Subject: [PATCH 3/3] arm: shmobile: lager: Add USBHS support
Message-Id: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds USBHS PHY and registers USBHS device if the driver is enabled.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-lager.c | 106 +++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index a8d3ce6..15a98ac 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -29,11 +30,14 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
+#include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7790.h>
@@ -165,6 +169,98 @@ static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_spi(162)),
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
+	return usb_phy_set_suspend(priv->phy, !enable);
+}
+
+static int usbhs_hardware_init(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+	struct usb_phy *phy;
+
+	phy = usb_get_phy(USB_PHY_TYPE_USB2);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	priv->phy = phy;
+	return usb_phy_init(priv->phy);
+}
+
+static int usbhs_hardware_exit(struct platform_device *pdev)
+{
+	struct usbhs_private *priv = usbhs_get_priv(pdev);
+
+	if (!priv->phy)
+		return 0;
+
+	usb_phy_shutdown(priv->phy);
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
+		},
+	}
+};
+
+#define lager_register_usbhs()						\
+	platform_device_register_resndata(&platform_bus,		\
+					  "renesas_usbhs", -1,		\
+					  usbhs_resources,		\
+					  ARRAY_SIZE(usbhs_resources),	\
+					  &usbhs_priv.info,		\
+					  sizeof(usbhs_priv.info))
+#else	/* CONFIG_USB_RENESAS_USBHS_UDC */
+#define lager_register_usbhs()
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
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -193,6 +289,9 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "eth_rmii", "eth"),
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
 				  "intc_irq0", "intc"),
+	/* USB0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
+				  "usb0", "usb0"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -221,6 +320,13 @@ static void __init lager_add_standard_devices(void)
 					  ARRAY_SIZE(ether_resources),
 					  &ether_pdata, sizeof(ether_pdata));
 
+	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+					  -1, usbhs_phy_resources,
+					  ARRAY_SIZE(usbhs_phy_resources),
+					  &usbhs_phy_pdata,
+					  sizeof(usbhs_phy_pdata));
+	lager_register_usbhs();
+
 	lager_add_du_device();
 }
 
-- 
1.8.3.1


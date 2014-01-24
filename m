From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:28:49 +0000
Subject: [PATCH V3 3/3] ARM: shmobile: lager: Add internal PCI support
Message-Id: <1390602529-11867-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds internal PCI USB host devices to R-Car H2 Lager board.
If USBHS device is disabled, channel 0 is configured as PCI USB host.
Otherwise, it is configured as USBHS. The USB phy is bound to either
USB host or USBHS device respectively. We don't bind USB phy to
the PCI host at channel 2 since it's configured as PCI host by
default and is not currently used by anything else.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-lager.c | 90 +++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 11 deletions(-)

Changes in V3:
* fixed a typo in the log message.
* fixed USB1 and USB2 device names in the pinmux table

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag.

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 4a95a45..972633e 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -468,7 +468,11 @@ static struct usbhs_private usbhs_priv __initdata = {
 	}
 };
 
-static void __init lager_register_usbhs(void)
+/* Channel 0 is USBHS */
+#define LAGER_USB0_PCI	0
+#define LAGER_USB0_NAME	"renesas_usbhs"
+
+static void __init lager_add_usb0_device(void)
 {
 	usb_bind_phy("renesas_usbhs", 0, "usb_phy_rcar_gen2");
 	platform_device_register_resndata(&platform_bus,
@@ -479,19 +483,82 @@ static void __init lager_register_usbhs(void)
 					  sizeof(usbhs_priv.info));
 }
 #else	/* CONFIG_USB_RENESAS_USBHS_UDC */
-static inline void lager_register_usbhs(void) { }
+
+/* Channel 0 is PCI USB host */
+#define LAGER_USB0_PCI	1
+#define LAGER_USB0_NAME	"pci-rcar-gen2.0"
+
+/* Internal PCI0 */
+static const struct resource pci0_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee090000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee080000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(108)),
+};
+
+static void __init lager_add_usb0_device(void)
+{
+	usb_bind_phy("0000:00:01.0", 0, "usb_phy_rcar_gen2");
+	usb_bind_phy("0000:00:02.0", 0, "usb_phy_rcar_gen2");
+	platform_device_register_simple("pci-rcar-gen2",
+					0, pci0_resources,
+					ARRAY_SIZE(pci0_resources));
+}
 #endif	/* CONFIG_USB_RENESAS_USBHS_UDC */
 
+/* Internal PCI1 */
+static const struct resource pci1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0b0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0a0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(112)),
+};
+
+static void __init lager_add_usb1_device(void)
+{
+	platform_device_register_simple("pci-rcar-gen2",
+					1, pci1_resources,
+					ARRAY_SIZE(pci1_resources));
+}
+
+/* Channel 2 is PCI USB host */
+#define LAGER_USB2_PCI	1
+
+/* Internal PCI2 */
+static const struct resource pci2_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0d0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0c0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
+static void __init lager_add_usb2_device(void)
+{
+	platform_device_register_simple("pci-rcar-gen2",
+					2, pci2_resources,
+					ARRAY_SIZE(pci2_resources));
+}
+
 /* USBHS PHY */
 static const struct rcar_gen2_phy_platform_data usbhs_phy_pdata __initconst = {
-	.chan0_pci = 0,	/* Channel 0 is USBHS */
-	.chan2_pci = 1,	/* Channel 2 is PCI USB */
+	.chan0_pci = LAGER_USB0_PCI,
+	.chan2_pci = LAGER_USB2_PCI,
 };
 
 static const struct resource usbhs_phy_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6590100, 0x100),
 };
 
+/* Add all available USB devices */
+static void __init lager_add_usb_devices(void)
+{
+	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+					  -1, usbhs_phy_resources,
+					  ARRAY_SIZE(usbhs_phy_resources),
+					  &usbhs_phy_pdata,
+					  sizeof(usbhs_phy_pdata));
+	lager_add_usb0_device();
+	lager_add_usb1_device();
+	lager_add_usb2_device();
+}
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -537,8 +604,14 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.1", "pfc-r8a7790",
 				  "vin1_clk", "vin1"),
 	/* USB0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
+	PIN_MAP_MUX_GROUP_DEFAULT(LAGER_USB0_NAME, "pfc-r8a7790",
 				  "usb0", "usb0"),
+	/* USB1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("pci-rcar-gen2.1", "pfc-r8a7790",
+				  "usb1", "usb1"),
+	/* USB2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("pci-rcar-gen2.2", "pfc-r8a7790",
+				  "usb2", "usb2"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -593,12 +666,7 @@ static void __init lager_add_standard_devices(void)
 
 	platform_device_register_full(&sata1_info);
 
-	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
-					  -1, usbhs_phy_resources,
-					  ARRAY_SIZE(usbhs_phy_resources),
-					  &usbhs_phy_pdata,
-					  sizeof(usbhs_phy_pdata));
-	lager_register_usbhs();
+	lager_add_usb_devices();
 }
 
 /*
-- 
1.8.3.1


From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 17 Jan 2014 18:21:35 +0000
Subject: [PATCH V2 4/4] ARM: shmobile: koelsch: Add internal PCI support
Message-Id: <1389982895-20726-5-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds internal PCI USB host devices to R-Car M2 Koelsch board.
If USBHS device is disabled, channel 0 is configured as PCI USB host.
Otherwise, it is configured as USBHS. The USB phy is bound bound to
either USB host or USBHS device respectively.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-koelsch.c | 67 +++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 10 deletions(-)

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag.

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 9ec1564..cd69ff0 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -267,7 +267,11 @@ static struct usbhs_private usbhs_priv __initdata = {
 	}
 };
 
-static void __init koelsch_register_usbhs(void)
+/* Channel 0 is USBHS */
+#define KOELSCH_USB0_PCI	0
+#define KOELSCH_USB0_NAME	"renesas_usbhs"
+
+static void __init koelsch_add_usb0_device(void)
 {
 	usb_bind_phy("renesas_usbhs", 0, "usb_phy_rcar_gen2");
 	platform_device_register_resndata(&platform_bus,
@@ -278,12 +282,45 @@ static void __init koelsch_register_usbhs(void)
 					  sizeof(usbhs_priv.info));
 }
 #else	/* CONFIG_USB_RENESAS_USBHS_UDC */
-static inline void koelsch_register_usbhs(void) { }
+
+/* Channel 0 is PCI USB host */
+#define KOELSCH_USB0_PCI	1
+#define KOELSCH_USB0_NAME	"pci-rcar-gen2.0"
+
+/* Internal PCI0 */
+static const struct resource pci0_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee090000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee080000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(108)),
+};
+
+static void __init koelsch_add_usb0_device(void)
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
+	DEFINE_RES_MEM(0xee0d0000, 0x10000),	/* CFG */
+	DEFINE_RES_MEM(0xee0c0000, 0x10000),	/* MEM */
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
+static void __init koelsch_add_usb1_device(void)
+{
+	platform_device_register_simple("pci-rcar-gen2",
+					1, pci1_resources,
+					ARRAY_SIZE(pci1_resources));
+}
+
 /* USBHS PHY */
 static const struct rcar_gen2_phy_platform_data usbhs_phy_pdata __initconst = {
-	.chan0_pci = 0,	/* Channel 0 is USBHS */
+	.chan0_pci = KOELSCH_USB0_PCI,
 	.chan2_pci = 1,	/* Channel 2 is PCI USB */
 };
 
@@ -291,6 +328,18 @@ static const struct resource usbhs_phy_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6590100, 0x100),
 };
 
+/* Add all available USB devices */
+static void __init koelsch_add_usb_devices(void)
+{
+	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
+					  -1, usbhs_phy_resources,
+					  ARRAY_SIZE(usbhs_phy_resources),
+					  &usbhs_phy_pdata,
+					  sizeof(usbhs_phy_pdata));
+	koelsch_add_usb0_device();
+	koelsch_add_usb1_device();
+}
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -315,8 +364,11 @@ static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7791",
 				  "scif1_data_d", "scif1"),
 	/* USB0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7791",
+	PIN_MAP_MUX_GROUP_DEFAULT(KOELSCH_USB0_NAME, "pfc-r8a7791",
 				  "usb0", "usb0"),
+	/* USB1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7791",
+				  "usb1", "usb1"),
 };
 
 static void __init koelsch_add_standard_devices(void)
@@ -341,12 +393,7 @@ static void __init koelsch_add_standard_devices(void)
 
 	platform_device_register_full(&sata0_info);
 
-	platform_device_register_resndata(&platform_bus, "usb_phy_rcar_gen2",
-					  -1, usbhs_phy_resources,
-					  ARRAY_SIZE(usbhs_phy_resources),
-					  &usbhs_phy_pdata,
-					  sizeof(usbhs_phy_pdata));
-	koelsch_register_usbhs();
+	koelsch_add_usb_devices();
 }
 
 /*
-- 
1.8.3.1


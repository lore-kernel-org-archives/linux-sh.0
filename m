From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 01 Oct 2013 18:30:50 +0000
Subject: [PATCH 5/6] arm: shmobile: lager: Add internal PCI support
Message-Id: <1380652251-8143-6-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds internal PCI/USB host support to Lager board.
There are 3 internal PCI bus controllers with only a EHCI/OHCI
device present on each one. This gives us 3 USB host channels.
Channel 0 is shared with the USBHS function module.
Channel 2 is shared with the USBSS (XHCI) device.

Currently no channel configuration is supported,
and the default settings are assumed:
Channel 0 - USBHS
Channel 1 - PCI/USB host
Channel 2 - PCI/USB host

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-lager.c | 41 +++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index e408fc7..08236fb 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -303,6 +303,38 @@ static struct usbhs_private usbhs_priv __initdata = {
 #define lager_register_usbhs()
 #endif	/* CONFIG_USB_RENESAS_USBHS_UDC */
 
+/*
+ * Internal PCI
+ * There are 3 internal PCI bus controllers with only a EHCI/OHCI
+ * device present on each one. This gives us 3 USB host channels.
+ * Channel 0 is shared with the USBHS function module.
+ * Channel 2 is shared with the USBSS (XHCI) device.
+ */
+#if IS_ENABLED(CONFIG_PCI)
+static const struct resource pci_resources[] __initconst = {
+	/* Internal PCI0 */
+	DEFINE_RES_MEM_NAMED(0xee080000, 0x10000, "PCI0 MEM"),
+	DEFINE_RES_MEM_NAMED(0xee090000, 0x10000, "PCI0 CFG"),
+	DEFINE_RES_IRQ(gic_spi(108)),
+	/* Internal PCI1 */
+	DEFINE_RES_MEM_NAMED(0xee0a0000, 0x10000, "PCI1 MEM"),
+	DEFINE_RES_MEM_NAMED(0xee0b0000, 0x10000, "PCI1 CFG"),
+	DEFINE_RES_IRQ(gic_spi(112)),
+	/* Internal PCI2 */
+	DEFINE_RES_MEM_NAMED(0xee0c0000, 0x10000, "PCI2 MEM"),
+	DEFINE_RES_MEM_NAMED(0xee0d0000, 0x10000, "PCI2 CFG"),
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
+#define lager_register_pci()						\
+	platform_device_register_simple("pci-rcar-gen2",		\
+					-1, pci_resources,		\
+					ARRAY_SIZE(pci_resources))
+}
+#else	/* CONFIG_PCI */
+#define lager_register_pci()
+#endif	/* CONFIG_PCI */
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -332,8 +364,14 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7790",
 				  "intc_irq0", "intc"),
 	/* USB0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
+	PIN_MAP_MUX_GROUP_DEFAULT(LAGER_USB0_DEVNAME, "pfc-r8a7790",
 				  "usb0", "usb0"),
+	/* USB1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("pci-rcar-gen2", "pfc-r8a7790",
+				  "usb1", "usb1"),
+	/* USB2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("pci-rcar-gen2", "pfc-r8a7790",
+				  "usb2", "usb2"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -364,6 +402,7 @@ static void __init lager_add_standard_devices(void)
 
 	lager_add_du_device();
 	lager_register_usbhs();
+	lager_register_pci();
 }
 
 /*
-- 
1.8.3.1


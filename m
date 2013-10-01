From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 01 Oct 2013 18:30:51 +0000
Subject: [PATCH 6/6] arm: shmobile: lager: Disable unused PCI/USB channels
Message-Id: <1380652251-8143-7-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This allows to configure USB channels in the USBHS UGCTRL2 register,
based on the flags value, passed to the lager_add_usb_devices() function.
A USB channel is configured as PCI USB host if the corresponding bit in
"flags" is set. Otherwise, the channel is either configured as USBHS/USBSS
(channel 0/1) or disabled (channel 1).

If USBHS gadget driver is enabled, channel 0 is configured as USBHS on
Lager. Otherwise it is set as PCI USB host.

In addition, the following switches have to be set correctly
for the USB channel 0 configuration:
SW5: pin1; SW6: pin1    -> PCI USB Host
SW5: neutral; SW6: pin2 -> USB Function (VBUS always connected)
SW5: pin3: SW6: pin2    -> USB Function (VBUS is connected only
if GP5_18 pin is high)

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-lager.c | 114 ++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 08236fb..6926b85 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -168,7 +168,6 @@ static const struct resource ether_resources[] __initconst = {
 };
 
 /* USBHS */
-#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
 static const struct resource usbhs_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6590000, 0x200),
 	DEFINE_RES_IRQ(gic_spi(107)),
@@ -191,6 +190,7 @@ static const struct resource usbhs_resources[] __initconst = {
 #define USBHS_UGSTS_REG			0x190
 #define USBHS_UGSTS_LOCK		(3 << 0)
 
+#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
 struct usbhs_private {
 	struct renesas_usbhs_platform_info info;
 	struct platform_device *pdev;
@@ -309,9 +309,17 @@ static struct usbhs_private usbhs_priv __initdata = {
  * device present on each one. This gives us 3 USB host channels.
  * Channel 0 is shared with the USBHS function module.
  * Channel 2 is shared with the USBSS (XHCI) device.
+ * USB channels configuration is set in the USBHS_UGCTRL2_REG
+ * register of the USBHS function block.
+ * In addition, the following switches have to be set correctly
+ * for the USB channel 0 configuration:
+ * SW5: pin1; SW6: pin1    -> PCI USB Host
+ * SW5: neutral; SW6: pin2 -> USB Function (VBUS always connected)
+ * SW5: pin3: SW6: pin2    -> USB Function (VBUS is connected only
+ * if GP5_18 pin is high)
  */
 #if IS_ENABLED(CONFIG_PCI)
-static const struct resource pci_resources[] __initconst = {
+static struct resource pci_resources[] __initdata = {
 	/* Internal PCI0 */
 	DEFINE_RES_MEM_NAMED(0xee080000, 0x10000, "PCI0 MEM"),
 	DEFINE_RES_MEM_NAMED(0xee090000, 0x10000, "PCI0 CFG"),
@@ -326,15 +334,104 @@ static const struct resource pci_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_spi(113)),
 };
 
-#define lager_register_pci()						\
-	platform_device_register_simple("pci-rcar-gen2",		\
-					-1, pci_resources,		\
-					ARRAY_SIZE(pci_resources))
+/*
+ * Disable PCI controller if the corresponding bit in "flags"
+ * is not set and register PCI controllers
+ */
+static void __init lager_register_pci(u32 flags)
+{
+	int i;
+
+	/* Disable unused PCI controllers */
+	for (i = 0; i < ARRAY_SIZE(pci_resources); i += 3) {
+		if (!(flags & 0x1))
+			pci_resources[i].flags |= IORESOURCE_DISABLED;
+		flags >>= 1;
+	}
+
+	platform_device_register_simple("pci-rcar-gen2",
+					-1, pci_resources,
+					ARRAY_SIZE(pci_resources));
 }
 #else	/* CONFIG_PCI */
-#define lager_register_pci()
+#define lager_register_pci(flags)
 #endif	/* CONFIG_PCI */
 
+#define LAGER_USB_PCI_ON(ch)	(1 << (ch))
+#define LAGER_USB_PCI_OFF(ch)	(0 << (ch))
+
+#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC) || IS_ENABLED(CONFIG_PCI)
+/*
+ * Fix-up and add USB devices. The USB channel is configured
+ * as PCI USB Host if the corresponding bit in flags is high.
+ * Otherwise, the channel is either configured as USBHS/USBSS
+ * (channel 0/2), or disabled (channel 1).
+ */
+static void __init lager_add_usb_devices(u32 flags)
+{
+	struct clk *clk;
+	void __iomem *hsusb_base;
+	u32 val;
+
+	clk = clk_get(NULL, "hsusb");
+	if (IS_ERR(clk)) {
+		/* Assume default settings */
+		flags &= ~LAGER_USB_PCI_ON(0);
+		goto usb_init;
+	}
+
+	hsusb_base = ioremap_nocache(usbhs_resources[0].start,
+				     resource_size(usbhs_resources));
+	if (!hsusb_base) {
+		/* Assume default settings */
+		flags &= ~LAGER_USB_PCI_ON(0);
+		clk_put(clk);
+		goto usb_init;
+	}
+
+	/* Enable USBHS clocks */
+	clk_enable(clk);
+
+	/* Set USB channels in USBHS UGCTRL2 register */
+	val = ioread32(hsusb_base + USBHS_UGCTRL2_REG) &
+		       ~(USBHS_UGCTRL2_USB0_HS | USBHS_UGCTRL2_USB2_SS);
+
+	val |= (flags & LAGER_USB_PCI_ON(0)) ?
+		USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
+	val |= (flags & LAGER_USB_PCI_ON(2)) ?
+		USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
+	iowrite32(val, hsusb_base + USBHS_UGCTRL2_REG);
+	iounmap(hsusb_base);
+
+usb_init:
+	if (!(flags & LAGER_USB_PCI_ON(0)))
+		lager_register_usbhs();
+
+	lager_register_pci(flags);
+}
+#else	/* CONFIG_USB_RENESAS_USBHS_UDC || CONFIG_PCI */
+#define lager_add_usb_devices(flags)
+#endif	/* CONFIG_USB_RENESAS_USBHS_UDC || CONFIG_PCI */
+
+#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
+/* USB channel 0 is USBHS function */
+#define LAGER_USB0_FLAG		LAGER_USB_PCI_OFF(0)
+#define LAGER_USB0_DEVNAME	"renesas_usbhs"
+#else
+/* USB channel 0 is PCI USB Host */
+#define LAGER_USB0_FLAG		LAGER_USB_PCI_ON(0)
+#define LAGER_USB0_DEVNAME	"pci-rcar-gen2"
+#endif
+
+/* USB channel 1 is PCI USB Host */
+#define LAGER_USB1_FLAG		LAGER_USB_PCI_ON(1)
+/* USB channel 2 is PCI USB Host */
+#define LAGER_USB2_FLAG		LAGER_USB_PCI_ON(2)
+
+#define LAGER_USB_FLAGS		(LAGER_USB0_FLAG |	\
+				LAGER_USB1_FLAG |	\
+				LAGER_USB2_FLAG)
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -401,8 +498,7 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 
 	lager_add_du_device();
-	lager_register_usbhs();
-	lager_register_pci();
+	lager_add_usb_devices(LAGER_USB_FLAGS);
 }
 
 /*
-- 
1.8.3.1


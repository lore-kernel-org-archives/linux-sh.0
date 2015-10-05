From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 05 Oct 2015 12:06:30 +0000
Subject: [PATCH 4/4] usb: host: xhci-plat: add support for the R-Car H3 xHCI controllers
Message-Id: <1444046790-5804-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The R-Car H3 has two xHCI controllers. This SoC is compatible with
R-Car Gen2 SoCs, however this SoC doesn't need some specific registers
setting, and need a new firmware.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  4 ++--
 drivers/usb/host/xhci-plat.c                       |  1 +
 drivers/usb/host/xhci-rcar.c                       | 23 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 106299a..0825732 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -3,8 +3,8 @@ USB xHCI controllers
 Required properties:
   - compatible: should be one of "generic-xhci",
     "marvell,armada-375-xhci", "marvell,armada-380-xhci",
-    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793"
-    (deprecated: "xhci-platform").
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793",
+    "renesas,xhci-r8a7795" (deprecated: "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
   - interrupts: one XHCI interrupt should be described here.
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 401110f..358febb 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -253,6 +253,7 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	{ .compatible = "renesas,xhci-r8a7790"},
 	{ .compatible = "renesas,xhci-r8a7791"},
 	{ .compatible = "renesas,xhci-r8a7793"},
+	{ .compatible = "renesas,xhci-r8a7795"},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index acfa03a..eb1aed0 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -17,8 +17,16 @@
 #include "xhci.h"
 #include "xhci-rcar.h"
 
+/*
+ * - The V2 firmware is possible to use on R-Car Gen2. However, the V2 causes
+ *   performance degradation. So, this driver continues to use the V1 if R-Car
+ *   Gen2.
+ * - The V1 firmware is impossible to use on R-Car Gen3.
+ */
 #define FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
+#define FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
 MODULE_FIRMWARE(FIRMWARE_NAME_V1);
+MODULE_FIRMWARE(FIRMWARE_NAME_V2);
 
 /*** Register Offset ***/
 #define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
@@ -69,9 +77,20 @@ static bool xhci_rcar_is_compatible_with_gen2(struct usb_hcd *hcd)
 	return false;
 }
 
+static bool xhci_rcar_is_compatible_with_gen3(struct usb_hcd *hcd)
+{
+	struct device_node *of_node = hcd->self.controller->of_node;
+
+	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7795"))
+		return true;
+
+	return false;
+}
+
 bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
 {
-	if (xhci_rcar_is_compatible_with_gen2(hcd))
+	if (xhci_rcar_is_compatible_with_gen2(hcd) ||
+	    xhci_rcar_is_compatible_with_gen3(hcd))
 		return true;
 
 	return false;
@@ -176,6 +195,8 @@ int xhci_rcar_init_quirk(struct usb_hcd *hcd)
 
 	if (xhci_rcar_is_compatible_with_gen2(hcd))
 		firmware_name = FIRMWARE_NAME_V1;
+	if (xhci_rcar_is_compatible_with_gen3(hcd))
+		firmware_name = FIRMWARE_NAME_V2;
 
 	return xhci_rcar_download_firmware(hcd->self.controller, hcd->regs,
 					   firmware_name);
-- 
1.9.1


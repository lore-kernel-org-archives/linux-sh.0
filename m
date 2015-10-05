From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 05 Oct 2015 12:06:27 +0000
Subject: [PATCH 1/4] usb: host: xhci-rcar: add xhci_rcar_is_compatible() function
Message-Id: <1444046790-5804-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To add support for other SoCs in the future, this patch adds
xhci_rcar_is_compatible() to check the compatible string.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-plat.c |  9 ++-------
 drivers/usb/host/xhci-rcar.c | 12 ++++++++++++
 drivers/usb/host/xhci-rcar.h |  6 ++++++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 890ad9d..26acece 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -48,11 +48,9 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
-	struct device_node *of_node = hcd->self.controller->of_node;
 	int ret;
 
-	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791")) {
+	if (xhci_rcar_is_compatible(hcd)) {
 		ret = xhci_rcar_init_quirk(hcd);
 		if (ret)
 			return ret;
@@ -63,10 +61,7 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 
 static int xhci_plat_start(struct usb_hcd *hcd)
 {
-	struct device_node *of_node = hcd->self.controller->of_node;
-
-	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
+	if (xhci_rcar_is_compatible(hcd))
 		xhci_rcar_start(hcd);
 
 	return xhci_run(hcd);
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index ff0d1b4..642fe55 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -10,6 +10,7 @@
 
 #include <linux/firmware.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/usb/phy.h>
 
@@ -56,6 +57,17 @@ MODULE_FIRMWARE(FIRMWARE_NAME);
 #define RCAR_USB3_RX_POL_VAL	BIT(21)
 #define RCAR_USB3_TX_POL_VAL	BIT(4)
 
+bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
+{
+	struct device_node *of_node = hcd->self.controller->of_node;
+
+	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
+		return true;
+
+	return false;
+}
+
 void xhci_rcar_start(struct usb_hcd *hcd)
 {
 	u32 temp;
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
index 5850125..0eb67fa 100644
--- a/drivers/usb/host/xhci-rcar.h
+++ b/drivers/usb/host/xhci-rcar.h
@@ -12,9 +12,15 @@
 #define _XHCI_RCAR_H
 
 #if IS_ENABLED(CONFIG_USB_XHCI_RCAR)
+bool xhci_rcar_is_compatible(struct usb_hcd *);
 void xhci_rcar_start(struct usb_hcd *hcd);
 int xhci_rcar_init_quirk(struct usb_hcd *hcd);
 #else
+static inline bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
+{
+	return false;
+}
+
 static inline void xhci_rcar_start(struct usb_hcd *hcd)
 {
 }
-- 
1.9.1


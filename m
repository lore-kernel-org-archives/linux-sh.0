From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 09 Apr 2014 14:00:02 +0000
Subject: [PATCH 2/2] usb: hcd: add generic PHY support
Message-Id: <201404091800.03215.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the generic PHY support, analogous to the USB PHY support. Intended it to be
used with the PCI EHCI/OHCI drivers and the xHCI platform driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.

 drivers/usb/core/hcd.c  |   42 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/usb/hcd.h |    1 +
 2 files changed, 41 insertions(+), 2 deletions(-)

Index: usb/drivers/usb/core/hcd.c
=================================--- usb.orig/drivers/usb/core/hcd.c
+++ usb/drivers/usb/core/hcd.c
@@ -42,6 +42,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
 
+#include <linux/phy/phy.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/phy.h>
@@ -2623,6 +2624,29 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_GENERIC_PHY)) {
+		struct phy *phy = phy_get(hcd->self.controller, "usb");
+
+		if (IS_ERR(phy)) {
+			retval = PTR_ERR(phy);
+			if (retval = -EPROBE_DEFER)
+				goto err_phy;
+		} else {
+			retval = phy_init(phy);
+			if (retval) {
+				phy_put(phy);
+				goto err_phy;
+			}
+			retval = phy_power_on(phy);
+			if (retval) {
+				phy_exit(phy);
+				phy_put(phy);
+				goto err_phy;
+			}
+			hcd->phy = phy;
+		}
+	}
+
 	dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
 
 	/* Keep old behaviour if authorized_default is not in [0, 1]. */
@@ -2638,7 +2662,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	 */
 	if ((retval = hcd_buffer_create(hcd)) != 0) {
 		dev_dbg(hcd->self.controller, "pool alloc failed\n");
-		goto err_remove_phy;
+		goto err_create_buf;
 	}
 
 	if ((retval = usb_register_bus(&hcd->self)) < 0)
@@ -2763,7 +2787,14 @@ err_allocate_root_hub:
 	usb_deregister_bus(&hcd->self);
 err_register_bus:
 	hcd_buffer_destroy(hcd);
-err_remove_phy:
+err_create_buf:
+	if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->phy) {
+		phy_power_off(hcd->phy);
+		phy_exit(hcd->phy);
+		phy_put(hcd->phy);
+		hcd->phy = NULL;
+	}
+err_phy:
 	if (hcd->remove_phy && hcd->transceiver) {
 		usb_phy_shutdown(hcd->transceiver);
 		usb_put_phy(hcd->transceiver);
@@ -2841,6 +2872,13 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	usb_put_dev(hcd->self.root_hub);
 	usb_deregister_bus(&hcd->self);
 	hcd_buffer_destroy(hcd);
+
+	if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->phy) {
+		phy_power_off(hcd->phy);
+		phy_exit(hcd->phy);
+		phy_put(hcd->phy);
+		hcd->phy = NULL;
+	}
 	if (hcd->remove_phy && hcd->transceiver) {
 		usb_phy_shutdown(hcd->transceiver);
 		usb_put_phy(hcd->transceiver);
Index: usb/include/linux/usb/hcd.h
=================================--- usb.orig/include/linux/usb/hcd.h
+++ usb/include/linux/usb/hcd.h
@@ -107,6 +107,7 @@ struct usb_hcd {
 	 * other external PHYs should be software-transparent
 	 */
 	struct usb_phy		*transceiver;
+	struct phy		*phy;
 
 	/* Flags that need to be manipulated atomically because they can
 	 * change while the host controller is running.  Always use

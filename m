From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 22 Jul 2014 22:17:55 +0000
Subject: [PATCH v4] usb: hcd: add generic PHY support
Message-Id: <201407230217.56283.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the generic PHY support, analogous to the USB PHY support. Intended it to be
used with the PCI EHCI/OHCI drivers and the xHCI platform driver.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

---
This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.

The USB PHY driver patch with which this patch is intended to be used, has been
just posted, along with the platform PHY device tree patches; the patches that
link the PCI EHCI/OHCI  devices to the PHY device will follow shortly.

Changes in version 4:
- refreshed the patch.

Changes in version 3:
- refreshed the patch.

Changes in version 2:
- renamed the new 'phy' field of 'struct usb_phy' to 'gen_phy';
- resolved rejects due to removal of the first patch in the series.

 drivers/usb/core/hcd.c  |   42 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/usb/hcd.h |    3 ++-
 2 files changed, 42 insertions(+), 3 deletions(-)

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
@@ -2645,6 +2646,29 @@ int usb_add_hcd(struct usb_hcd *hcd,
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
+			hcd->gen_phy = phy;
+		}
+	}
+
 	dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
 
 	/* Keep old behaviour if authorized_default is not in [0, 1]. */
@@ -2660,7 +2684,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	 */
 	if ((retval = hcd_buffer_create(hcd)) != 0) {
 		dev_dbg(hcd->self.controller, "pool alloc failed\n");
-		goto err_remove_phy;
+		goto err_create_buf;
 	}
 
 	if ((retval = usb_register_bus(&hcd->self)) < 0)
@@ -2787,7 +2811,14 @@ err_allocate_root_hub:
 	usb_deregister_bus(&hcd->self);
 err_register_bus:
 	hcd_buffer_destroy(hcd);
-err_remove_phy:
+err_create_buf:
+	if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->gen_phy) {
+		phy_power_off(hcd->gen_phy);
+		phy_exit(hcd->gen_phy);
+		phy_put(hcd->gen_phy);
+		hcd->gen_phy = NULL;
+	}
+err_phy:
 	if (hcd->remove_phy && hcd->phy) {
 		usb_phy_shutdown(hcd->phy);
 		usb_put_phy(hcd->phy);
@@ -2864,6 +2895,13 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 
 	usb_deregister_bus(&hcd->self);
 	hcd_buffer_destroy(hcd);
+
+	if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->gen_phy) {
+		phy_power_off(hcd->gen_phy);
+		phy_exit(hcd->gen_phy);
+		phy_put(hcd->gen_phy);
+		hcd->gen_phy = NULL;
+	}
 	if (hcd->remove_phy && hcd->phy) {
 		usb_phy_shutdown(hcd->phy);
 		usb_put_phy(hcd->phy);
Index: usb/include/linux/usb/hcd.h
=================================--- usb.orig/include/linux/usb/hcd.h
+++ usb/include/linux/usb/hcd.h
@@ -106,7 +106,8 @@ struct usb_hcd {
 	 * OTG and some Host controllers need software interaction with phys;
 	 * other external phys should be software-transparent
 	 */
-	struct usb_phy	*phy;
+	struct usb_phy		*phy;
+	struct phy		*gen_phy;
 
 	/* Flags that need to be manipulated atomically because they can
 	 * change while the host controller is running.  Always use

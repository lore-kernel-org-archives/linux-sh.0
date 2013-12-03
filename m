From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 03 Dec 2013 21:42:21 +0000
Subject: [PATCH 1/2] usb: hcd: Remove USB phy if needed
Message-Id: <1386106942-13730-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds remove_phy flag to the HCD structure. If the flag is
set and if hcd->phy is valid, the phy is shutdown and released
whenever usb_add_hcd fails or usb_hcd_remove is called.
This can be used by the HCD drivers to auto-remove
the external USB phy when it is no longer needed.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/core/hcd.c  | 14 +++++++++++++-
 include/linux/usb/hcd.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 6bffb8c..7527c8e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -44,6 +44,7 @@
 
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/phy.h>
 
 #include "usb.h"
 
@@ -2603,7 +2604,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	 */
 	if ((retval = hcd_buffer_create(hcd)) != 0) {
 		dev_dbg(hcd->self.controller, "pool alloc failed\n");
-		return retval;
+		goto err_remove_phy;
 	}
 
 	if ((retval = usb_register_bus(&hcd->self)) < 0)
@@ -2734,6 +2735,12 @@ err_allocate_root_hub:
 	usb_deregister_bus(&hcd->self);
 err_register_bus:
 	hcd_buffer_destroy(hcd);
+err_remove_phy:
+	if (hcd->remove_phy && hcd->phy) {
+		usb_phy_shutdown(hcd->phy);
+		usb_put_phy(hcd->phy);
+		hcd->phy = NULL;
+	}
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_add_hcd);
@@ -2806,6 +2813,11 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	usb_put_dev(hcd->self.root_hub);
 	usb_deregister_bus(&hcd->self);
 	hcd_buffer_destroy(hcd);
+	if (hcd->remove_phy && hcd->phy) {
+		usb_phy_shutdown(hcd->phy);
+		usb_put_phy(hcd->phy);
+		hcd->phy = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(usb_remove_hcd);
 
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index b8aba19..758ce80 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -134,6 +134,7 @@ struct usb_hcd {
 	unsigned		rh_registered:1;/* is root hub registered? */
 	unsigned		rh_pollable:1;	/* may we poll the root hub? */
 	unsigned		msix_enabled:1;	/* driver has MSI-X enabled? */
+	unsigned		remove_phy:1;	/* auto-remove USB phy */
 
 	/* The next flag is a stopgap, to be removed when all the HCDs
 	 * support the new root-hub polling mechanism. */
-- 
1.8.3.1


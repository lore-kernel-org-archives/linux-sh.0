From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 20 Nov 2013 17:38:00 +0000
Subject: [PATCH 3/9] usb: hcd: Initialize USB phy if needed
Message-Id: <1384969086-8920-4-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds external USB phy support to USB HCD driver that
allows to find and initialize external USB phy, bound to
the HCD, when the HCD is added.
The usb_add_hcd function returns -EPROBE_DEFER if the USB
phy, bound to the HCD, is not ready.
If no USB phy is bound, the HCD is initialized as usual.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/core/hcd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index d939521..fd09ec6 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2597,6 +2597,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	int retval;
 	struct usb_device *rhdev;
 
+#ifdef CONFIG_USB_PHY
+	if (!hcd->phy) {
+		struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
+
+		if (IS_ERR(phy)) {
+			retval = PTR_ERR(phy);
+			if (retval = -EPROBE_DEFER)
+				return retval;
+		} else {
+			retval = usb_phy_init(phy);
+			if (retval) {
+				usb_put_phy(phy);
+				return retval;
+			}
+			hcd->phy = phy;
+			hcd->remove_phy = 1;
+		}
+	}
+#endif
+
 	dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
 
 	/* Keep old behaviour if authorized_default is not in [0, 1]. */
-- 
1.8.4


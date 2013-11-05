From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 05 Nov 2013 20:33:27 +0000
Subject: [RFC PATCH 2/2] usb: hcd: Introduce CONFIG_USB_HCD_EXTERNAL_PHY option
Message-Id: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds external USB phy support to USB HCD driver that
allows to find and initialize external USB phy, bound to
the HCD when the HCD is added.
The usb_add_hcd function returns -EPROBE_DEFER if the USB
phy, bound to the HCD, is not ready.
If no USB phy is bound, the HCD is initialized as usual.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/usb/core/hcd.c   | 20 ++++++++++++++++++++
 drivers/usb/host/Kconfig | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index d939521..da9c4ba 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2597,6 +2597,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	int retval;
 	struct usb_device *rhdev;
 
+#ifdef CONFIG_USB_HCD_EXTERNAL_PHY
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
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index b3f20d7..2e1f2b0 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -706,3 +706,14 @@ config USB_HCD_TEST_MODE
 	  This option is of interest only to developers who need to validate
 	  their USB hardware designs.  It is not needed for normal use.  If
 	  unsure, say N.
+
+config USB_HCD_EXTERNAL_PHY
+	bool "Set up external USB phy bound to the USB HCD"
+	select USB_PHY
+	---help---
+	  Some USB host controllers require an external USB phy.
+	  This adds generic USB phy support to the USB HCD driver.
+	  When the HCD is being initialized, the HC driver searches
+	  for a USB phy, bound to the HCD. If no USB phy is bound
+	  to the HCD, the HCD is initialized as usual.
+	  If unsure, say N.
-- 
1.8.3.1


From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 15 Dec 2014 22:42:13 +0000
Subject: [PATCH] renesas_usbhs: add OTG ID signal sensing
Message-Id: <7850767.LfC2Jrg0a5@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On the Renesas R8A7791 SoC based boards there's MAX3355 USB OTG chip and mini-AB
USB connector corresponding to USB port 0 driven either by EHCI/OHCI or  Renesas
USBHS gadget controller. And we'd like the host/gadget  drivers to work based on
the cable type connected. An 'extcon' driver for MAX3355 has been written, so we
only need to bind  to it via device tree which I'm doing in this patch.

(Perhaps, it would also make sense to use OTG HNP when the USBHS host mode is
active and a B-cable is connected but I don't have access to host-capable USBHS,
so  wouldn't be able to test it.)

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'next'  branch of Felipe Balbi's 'usb.git' repo.
It needs the recent 'extcon' core in  order to properly handle probe deferral.  

 drivers/usb/renesas_usbhs/common.c |   17 +++++++++++++++++
 drivers/usb/renesas_usbhs/common.h |    3 +++
 2 files changed, 20 insertions(+)

Index: usb/drivers/usb/renesas_usbhs/common.c
=================================--- usb.orig/drivers/usb/renesas_usbhs/common.c
+++ usb/drivers/usb/renesas_usbhs/common.c
@@ -363,6 +363,7 @@ static void usbhsc_hotplug(struct usbhs_
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
 	int id;
 	int enable;
+	int cable;
 	int ret;
 
 	/*
@@ -376,6 +377,16 @@ static void usbhsc_hotplug(struct usbhs_
 	id = usbhs_platform_call(priv, get_id, pdev);
 
 	if (enable && !mod) {
+		if (priv->edev) {
+			cable = extcon_get_cable_state(priv->edev, "USB-HOST");
+			if ((cable > 0 && id != USBHS_HOST) ||
+			    (!cable && id != USBHS_GADGET)) {
+				dev_info(&pdev->dev,
+					 "USB cable plugged in doesn't match the selected role!\n");
+				return;
+			}
+		}
+
 		ret = usbhs_mod_change(priv, id);
 		if (ret < 0)
 			return;
@@ -514,6 +525,12 @@ static int usbhs_probe(struct platform_d
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	if (of_property_read_bool(pdev->dev.of_node, "extcon")) {
+		priv->edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
+		if (IS_ERR(priv->edev))
+			return PTR_ERR(priv->edev);
+	}
+
 	/*
 	 * care platform info
 	 */
Index: usb/drivers/usb/renesas_usbhs/common.h
=================================--- usb.orig/drivers/usb/renesas_usbhs/common.h
+++ usb/drivers/usb/renesas_usbhs/common.h
@@ -17,6 +17,7 @@
 #ifndef RENESAS_USB_DRIVER_H
 #define RENESAS_USB_DRIVER_H
 
+#include <linux/extcon.h>
 #include <linux/platform_device.h>
 #include <linux/usb/renesas_usbhs.h>
 
@@ -254,6 +255,8 @@ struct usbhs_priv {
 	struct delayed_work notify_hotplug_work;
 	struct platform_device *pdev;
 
+	struct extcon_dev *edev;
+
 	spinlock_t		lock;
 
 	u32 flags;


From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 02 Jul 2015 07:36:42 +0000
Subject: [PATCH v2] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <1435822602-22685-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

These changes allow a PHY driver to trigger a VBUS interrupt and
to provide the value of VBUS.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

---
v2:
  - vbus variables changed from int to bool.
  - dev_info() changed to dev_err()
---
 drivers/usb/renesas_usbhs/common.h     |  2 ++
 drivers/usb/renesas_usbhs/mod.c        |  3 +++
 drivers/usb/renesas_usbhs/mod_gadget.c | 38 ++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index 8c5fc12..478700c 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -255,6 +255,8 @@ struct usbhs_priv {
 	struct renesas_usbhs_driver_param	dparam;
 
 	struct delayed_work notify_hotplug_work;
+	bool vbus_is_indirect;
+	bool vbus_indirect_value;
 	struct platform_device *pdev;
 
 	struct extcon_dev *edev;
diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index 9a705b1..8a2d3dd 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -42,6 +42,9 @@ static int usbhsm_autonomy_get_vbus(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
+	if (priv->vbus_is_indirect)
+		return priv->vbus_indirect_value;
+
 	return  VBSTS & usbhs_read(priv, INTSTS0);
 }
 
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dc2aa32..51b63f9 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include "common.h"
 
 /*
@@ -50,6 +51,7 @@ struct usbhsg_gpriv {
 	int			 uep_size;
 
 	struct usb_gadget_driver	*driver;
+	struct usb_phy		*transceiver;
 
 	u32	status;
 #define USBHSG_STATUS_STARTED		(1 << 0)
@@ -882,6 +884,8 @@ static int usbhsg_gadget_start(struct usb_gadget *gadget,
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	struct device *dev = usbhs_priv_to_dev(priv);
+	int ret;
 
 	if (!driver		||
 	    !driver->setup	||
@@ -891,6 +895,17 @@ static int usbhsg_gadget_start(struct usb_gadget *gadget,
 	/* first hook up the driver ... */
 	gpriv->driver = driver;
 
+	/* connect to bus through transceiver */
+	if (!IS_ERR_OR_NULL(gpriv->transceiver)) {
+		ret = otg_set_peripheral(gpriv->transceiver->otg,
+					&gpriv->gadget);
+		if (ret) {
+			dev_err(dev, "%s: can't bind to transceiver\n",
+				gpriv->gadget.name);
+			return ret;
+		}
+	}
+
 	return usbhsg_try_start(priv, USBHSG_STATUS_REGISTERD);
 }
 
@@ -900,6 +915,10 @@ static int usbhsg_gadget_stop(struct usb_gadget *gadget)
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
 
 	usbhsg_try_stop(priv, USBHSG_STATUS_REGISTERD);
+
+	if (!IS_ERR_OR_NULL(gpriv->transceiver))
+		(void) otg_set_peripheral(gpriv->transceiver->otg, NULL);
+
 	gpriv->driver = NULL;
 
 	return 0;
@@ -947,12 +966,27 @@ static int usbhsg_set_selfpowered(struct usb_gadget *gadget, int is_self)
 	return 0;
 }
 
+static int usbhsg_vbus_session(struct usb_gadget *gadget, int is_active)
+{
+	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
+	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	struct platform_device *pdev = usbhs_priv_to_pdev(priv);
+
+	priv->vbus_is_indirect = 1;
+	priv->vbus_indirect_value = !!is_active;
+
+	renesas_usbhs_call_notify_hotplug(pdev);
+
+	return 0;
+}
+
 static const struct usb_gadget_ops usbhsg_gadget_ops = {
 	.get_frame		= usbhsg_get_frame,
 	.set_selfpowered	= usbhsg_set_selfpowered,
 	.udc_start		= usbhsg_gadget_start,
 	.udc_stop		= usbhsg_gadget_stop,
 	.pullup			= usbhsg_pullup,
+	.vbus_session		= usbhsg_vbus_session,
 };
 
 static int usbhsg_start(struct usbhs_priv *priv)
@@ -994,6 +1028,10 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
+	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	dev_info(dev, "%s transceiver found\n",
+		 gpriv->transceiver ? "" : "No");
+
 	/*
 	 * CAUTION
 	 *
-- 
1.9.1


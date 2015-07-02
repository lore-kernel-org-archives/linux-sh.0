From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 02 Jul 2015 10:26:33 +0000
Subject: [PATCH v3] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <1435832793-9999-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2896957.Pcl0CbmdvL@avalon>
In-Reply-To: <2896957.Pcl0CbmdvL@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

These changes allow a PHY driver to trigger a VBUS interrupt and
to provide the value of VBUS.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

---
v3:
  - Changed how indirect vbus is plumbed in.
  - Removed unnecessary (void) on call to otg_set_peripheral.
  - Moved code that connects to bus through transceiver so it
    is before setting gpriv->driver.

v2:
  - vbus variables changed from int to bool.
  - dev_info() changed to dev_err()
---
 drivers/usb/renesas_usbhs/common.c     |  8 +++++--
 drivers/usb/renesas_usbhs/common.h     |  2 ++
 drivers/usb/renesas_usbhs/mod_gadget.c | 38 ++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 0f7e850..15e67d8 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -379,7 +379,10 @@ static void usbhsc_hotplug(struct usbhs_priv *priv)
 	/*
 	 * get vbus status from platform
 	 */
-	enable = usbhs_platform_call(priv, get_vbus, pdev);
+	if (priv->vbus_is_indirect)
+		enable = priv->vbus_indirect_value;
+	else
+		enable = usbhs_platform_call(priv, get_vbus, pdev);
 
 	/*
 	 * get id from platform
@@ -662,7 +665,8 @@ static int usbhs_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	if (!usbhsc_flags_has(priv, USBHSF_RUNTIME_PWCTRL)) {
 		usbhsc_power_ctrl(priv, 1);
-		usbhs_mod_autonomy_mode(priv);
+		if (!priv->vbus_is_indirect)
+			usbhs_mod_autonomy_mode(priv);
 	}
 
 	/*
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
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dc2aa32..93ad4ea 100644
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
@@ -882,12 +884,25 @@ static int usbhsg_gadget_start(struct usb_gadget *gadget,
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	struct device *dev = usbhs_priv_to_dev(priv);
+	int ret;
 
 	if (!driver		||
 	    !driver->setup	||
 	    driver->max_speed < USB_SPEED_FULL)
 		return -EINVAL;
 
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
 	/* first hook up the driver ... */
 	gpriv->driver = driver;
 
@@ -900,6 +915,10 @@ static int usbhsg_gadget_stop(struct usb_gadget *gadget)
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
 
 	usbhsg_try_stop(priv, USBHSG_STATUS_REGISTERD);
+
+	if (!IS_ERR_OR_NULL(gpriv->transceiver))
+		otg_set_peripheral(gpriv->transceiver->otg, NULL);
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


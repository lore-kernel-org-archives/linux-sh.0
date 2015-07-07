From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 07 Jul 2015 11:52:43 +0000
Subject: [PATCH v5] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <1436269963-25885-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3446210.Evs1k3c1oP@avalon>
In-Reply-To: <3446210.Evs1k3c1oP@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

These changes allow a PHY driver to trigger a VBUS interrupt and
to provide the value of VBUS.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

---
v5:
  - Avoid race when vbus_is_indirect may or may not be read
    before the phy has called vbus_session. In doing so, the
    changes have also been isolated to mod_gadget.c

v4:
  - Use true/false with bool vars.
  - Clean up "transceiver found" message.

v3:
  - Changed how indirect vbus is plumbed in.
  - Removed unnecessary (void) on call to otg_set_peripheral.
  - Moved code that connects to bus through transceiver so it
    is before setting gpriv->driver.

v2:
  - vbus variables changed from int to bool.
  - dev_info() changed to dev_err()
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index dc2aa32..19a22a3 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include "common.h"
 
 /*
@@ -50,6 +51,8 @@ struct usbhsg_gpriv {
 	int			 uep_size;
 
 	struct usb_gadget_driver	*driver;
+	struct usb_phy		*transceiver;
+	bool 			 vbus_indirect_value;
 
 	u32	status;
 #define USBHSG_STATUS_STARTED		(1 << 0)
@@ -873,6 +876,27 @@ static int usbhsg_try_stop(struct usbhs_priv *priv, u32 status)
 }
 
 /*
+ * VBUS provided by the PHY
+ */
+static int usbhsm_phy_get_vbus(struct platform_device *pdev)
+{
+	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
+	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
+
+	return  gpriv->vbus_indirect_value;
+}
+
+static void usbhs_mod_phy_mode(struct usbhs_priv *priv)
+{
+	struct usbhs_mod_info *info = &priv->mod_info;
+
+	info->irq_vbus		= NULL;
+	priv->pfunc.get_vbus	= usbhsm_phy_get_vbus;
+
+	usbhs_irq_callback_update(priv, NULL);
+}
+
+/*
  *
  *		linux usb function
  *
@@ -882,12 +906,28 @@ static int usbhsg_gadget_start(struct usb_gadget *gadget,
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
+
+		/* get vbus using phy versions */
+		usbhs_mod_phy_mode(priv);
+	}
+
 	/* first hook up the driver ... */
 	gpriv->driver = driver;
 
@@ -900,6 +940,10 @@ static int usbhsg_gadget_stop(struct usb_gadget *gadget)
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
 
 	usbhsg_try_stop(priv, USBHSG_STATUS_REGISTERD);
+
+	if (!IS_ERR_OR_NULL(gpriv->transceiver))
+		otg_set_peripheral(gpriv->transceiver->otg, NULL);
+
 	gpriv->driver = NULL;
 
 	return 0;
@@ -947,12 +991,26 @@ static int usbhsg_set_selfpowered(struct usb_gadget *gadget, int is_self)
 	return 0;
 }
 
+static int usbhsg_vbus_session(struct usb_gadget *gadget, int is_active)
+{
+	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
+	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	struct platform_device *pdev = usbhs_priv_to_pdev(priv);
+
+	gpriv->vbus_indirect_value = !!is_active;
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
@@ -994,6 +1052,10 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
+	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	dev_info(dev, "%stransceiver found\n",
+		 gpriv->transceiver ? "" : "no ");
+
 	/*
 	 * CAUTION
 	 *
-- 
1.9.1


From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 16 Mar 2012 04:10:15 +0000
Subject: [PATCH] usb: renesas_usbhs: gadget: add support for set_selfpowered
Message-Id: <4F62BD27.9020406@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The previous code always set to USB_DEVICE_SELF_POWERED in GET_STATUS.
So, this patch adds set_selfpowered().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 00bd2a5..28478ce 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -55,6 +55,7 @@ struct usbhsg_gpriv {
 #define USBHSG_STATUS_STARTED		(1 << 0)
 #define USBHSG_STATUS_REGISTERD		(1 << 1)
 #define USBHSG_STATUS_WEDGE		(1 << 2)
+#define USBHSG_STATUS_SELF_POWERED	(1 << 3)
 };

 struct usbhsg_recip_handle {
@@ -333,7 +334,10 @@ static int usbhsg_recip_handler_std_get_device(struct usbhs_priv *priv,
 					       struct usb_ctrlrequest *ctrl)
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
-	unsigned short status = 1 << USB_DEVICE_SELF_POWERED;
+	unsigned short status = 0;
+
+	if (usbhsg_status_has(gpriv, USBHSG_STATUS_SELF_POWERED))
+		status = 1 << USB_DEVICE_SELF_POWERED;

 	__usbhsg_recip_send_status(gpriv, status);

@@ -879,8 +883,21 @@ static int usbhsg_get_frame(struct usb_gadget *gadget)
 	return usbhs_frame_get_num(priv);
 }

+static int usbhsg_set_selfpowered(struct usb_gadget *gadget, int is_self)
+{
+	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
+
+	if (is_self)
+		usbhsg_status_set(gpriv, USBHSG_STATUS_SELF_POWERED);
+	else
+		usbhsg_status_clr(gpriv, USBHSG_STATUS_SELF_POWERED);
+
+	return 0;
+}
+
 static struct usb_gadget_ops usbhsg_gadget_ops = {
 	.get_frame		= usbhsg_get_frame,
+	.set_selfpowered	= usbhsg_set_selfpowered,
 	.udc_start		= usbhsg_gadget_start,
 	.udc_stop		= usbhsg_gadget_stop,
 };
-- 
1.7.1

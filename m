From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Apr 2012 09:51:28 +0000
Subject: [PATCH v2] usb: r8a66597-udc: add support for set_selfpowered
Message-Id: <4F855420.5010705@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The previous code always set to USB_DEVICE_SELF_POWERED in GET_STATUS.
So, this patch adds set_selfpowered().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - fix compile warning

 drivers/usb/gadget/r8a66597-udc.c |   15 ++++++++++++++-
 drivers/usb/gadget/r8a66597-udc.h |    1 +
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index c4401e7..873e69f 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1170,7 +1170,7 @@ __acquires(r8a66597->lock)

 	switch (ctrl->bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
-		status = 1 << USB_DEVICE_SELF_POWERED;
+		status = r8a66597->device_status;
 		break;
 	case USB_RECIP_INTERFACE:
 		status = 0;
@@ -1800,11 +1800,24 @@ static int r8a66597_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }

+static int r8a66597_set_selfpowered(struct usb_gadget *gadget, int is_self)
+{
+	struct r8a66597 *r8a66597 = gadget_to_r8a66597(gadget);
+
+	if (is_self)
+		r8a66597->device_status |= 1 << USB_DEVICE_SELF_POWERED;
+	else
+		r8a66597->device_status &= ~(1 << USB_DEVICE_SELF_POWERED);
+
+	return 0;
+}
+
 static struct usb_gadget_ops r8a66597_gadget_ops = {
 	.get_frame		= r8a66597_get_frame,
 	.udc_start		= r8a66597_start,
 	.udc_stop		= r8a66597_stop,
 	.pullup			= r8a66597_pullup,
+	.set_selfpowered	= r8a66597_set_selfpowered,
 };

 static int __exit r8a66597_remove(struct platform_device *pdev)
diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index 8e3de61..8b855a8 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -111,6 +111,7 @@ struct r8a66597 {
 	u16			old_vbus;
 	u16			scount;
 	u16			old_dvsq;
+	u16			device_status;	/* for GET_STATUS */

 	/* pipe config */
 	unsigned char bulk;
-- 
1.7.1

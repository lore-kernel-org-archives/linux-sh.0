From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 18 Nov 2015 05:34:10 +0000
Subject: [PATCH v2 2/2] usb: renesas_usbhs: Modify ep.caps.type_xxx and usb_ep_maxpacket_limit()
Message-Id: <1447824850-6296-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch modifies the ep.caps.type_{iso,bulk,int} setting and
the second argument of usb_ep_maxpacket_limit() using
the dparam.pipe_configs.

In the previous code, all the type_{iso,bulk,int} were set to true.
However, to avoid waste time for finding suitable pipe in usb_ep_enable(),
this driver should set correct type.
Also the second argument of usb_ep_maxpacket_limit() was set to 512
even if the pipe is isochronous or interrupt. So, this driver could
not bind a gadget driver like the g_audio driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index de4f97d..d45a2c7 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1035,6 +1035,8 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 	struct usbhsg_gpriv *gpriv;
 	struct usbhsg_uep *uep;
 	struct device *dev = usbhs_priv_to_dev(priv);
+	struct renesas_usbhs_driver_pipe_config *pipe_configs +					usbhs_get_dparam(priv, pipe_configs);
 	int pipe_size = usbhs_get_dparam(priv, pipe_size);
 	int i;
 	int ret;
@@ -1104,13 +1106,16 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 			gpriv->gadget.ep0 = &uep->ep;
 			usb_ep_set_maxpacket_limit(&uep->ep, 64);
 			uep->ep.caps.type_control = true;
-		}
-		/* init normal pipe */
-		else {
-			usb_ep_set_maxpacket_limit(&uep->ep, 512);
-			uep->ep.caps.type_iso = true;
-			uep->ep.caps.type_bulk = true;
-			uep->ep.caps.type_int = true;
+		} else {
+			/* init normal pipe */
+			if (pipe_configs[i].type = USB_ENDPOINT_XFER_ISOC)
+				uep->ep.caps.type_iso = true;
+			if (pipe_configs[i].type = USB_ENDPOINT_XFER_BULK)
+				uep->ep.caps.type_bulk = true;
+			if (pipe_configs[i].type = USB_ENDPOINT_XFER_INT)
+				uep->ep.caps.type_int = true;
+			usb_ep_set_maxpacket_limit(&uep->ep,
+						   pipe_configs[i].bufsize);
 			list_add_tail(&uep->ep.ep_list, &gpriv->gadget.ep_list);
 		}
 		uep->ep.caps.dir_in = true;
-- 
1.9.1


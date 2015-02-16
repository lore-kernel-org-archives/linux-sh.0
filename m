From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Feb 2015 01:52:56 +0000
Subject: [PATCH v2 1/4] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <1424051579-5060-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

According to the gadget.h, a "complete" function will always be called
with interrupts disabled. However, sometimes usbhsg_queue_pop() function
is called with interrupts enabled. So, this function should calls
local_irq_save() before this calls the usb_gadget_giveback_request().
Otherwise, there is possible to cause a spinlock suspected in a gadget
complete function.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index e0384af..104bddf 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -126,11 +126,22 @@ static void usbhsg_queue_pop(struct usbhsg_uep *uep,
 	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
 	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
 	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
+	unsigned long flags;
 
 	dev_dbg(dev, "pipe %d : queue pop\n", usbhs_pipe_number(pipe));
 
 	ureq->req.status = status;
+	/*
+	 * According to the gadget.h, a "complete" function will always be
+	 * called with interrupts disabled. However, sometimes this function
+	 * is called with interrupts enabled. (e.g. complete a DMAC transfer or
+	 * write data and done is set immediately when PIO.) So, this function
+	 * should calls local_irq_save() before this calls the
+	 * usb_gadget_giveback_request().
+	 */
+	local_irq_save(flags);
 	usb_gadget_giveback_request(&uep->ep, &ureq->req);
+	local_irq_restore(flags);
 }
 
 static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *pkt)
-- 
1.7.9.5


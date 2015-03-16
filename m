From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Mar 2015 07:36:48 +0000
Subject: [PATCH v3] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <1426491408-504-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to the gadget.h, a "complete" function will always be called
with interrupts disabled. However, sometimes usbhsg_queue_pop() function
is called with interrupts enabled. So, this function should be held by
usbhs_lock() to disable interruption. Also, this driver has to call
spin_unlock() to avoid spinlock recursion by this driver before calling
usb_gadget_giveback_request().
Otherwise, there is possible to cause a spinlock suspected in a gadget
complete function.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
Changes from v2:
 - This patch is based on Felipe's usb.git / testing/next branch.
   (commit id = 46f5cace1cd0559c335dfd4a5b8f57456d1bd6a1)
 - Use usbhs_lock() to disable interruption instead of local_irq_save().
 - Modify the commit log.

Changes from v1:
 - Change local_irq_save/restore() area.
 - Modify the commit log.

 drivers/usb/renesas_usbhs/mod_gadget.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index e0384af..dc2aa32 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -119,18 +119,34 @@ struct usbhsg_recip_handle {
 /*
  *		queue push/pop
  */
-static void usbhsg_queue_pop(struct usbhsg_uep *uep,
-			     struct usbhsg_request *ureq,
-			     int status)
+static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
+			       struct usbhsg_request *ureq,
+			       int status)
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
 	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
 	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
+	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
 
 	dev_dbg(dev, "pipe %d : queue pop\n", usbhs_pipe_number(pipe));
 
 	ureq->req.status = status;
+	spin_unlock(usbhs_priv_to_lock(priv));
 	usb_gadget_giveback_request(&uep->ep, &ureq->req);
+	spin_lock(usbhs_priv_to_lock(priv));
+}
+
+static void usbhsg_queue_pop(struct usbhsg_uep *uep,
+			     struct usbhsg_request *ureq,
+			     int status)
+{
+	struct usbhsg_gpriv *gpriv = usbhsg_uep_to_gpriv(uep);
+	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	unsigned long flags;
+
+	usbhs_lock(priv, flags);
+	__usbhsg_queue_pop(uep, ureq, status);
+	usbhs_unlock(priv, flags);
 }
 
 static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *pkt)
-- 
1.9.1


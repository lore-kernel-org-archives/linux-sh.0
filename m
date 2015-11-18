From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 18 Nov 2015 05:33:35 +0000
Subject: [PATCH v2] usb: renesas_usbhs: gadget: Fix NULL pointer dereference in usbhsg_ep_dequeue()
Message-Id: <1447824815-4080-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that NULL pointer dereference happens when
a gadget driver calls usb_ep_dequeue() for ep0 after disconnected
a usb cable. This is because that usbhsg_try_stop() will call
usbhsg_ep_disable(&dcp->ep) when a usb cable is disconnected and
the pipe of dcp (ep0) is set to NULL.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the latest Felipe's usb.git / testing/fixes branch.
 (commit id = 455bfac5ad0a6394835ab10fad68f5ce3053160b)

 Perhaps this issue has existed from the first gadget support in this driver...

 Changes from v1:
  - Rebase the latest testing/fixes branch.
  - Revise the commit log.
  - Separate other two patches.
    (In other words, this is not related to isochronous support)

 drivers/usb/renesas_usbhs/mod_gadget.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index de4f97d..8f7a78e 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -131,7 +131,8 @@ static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
 	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
 
-	dev_dbg(dev, "pipe %d : queue pop\n", usbhs_pipe_number(pipe));
+	if (pipe)
+		dev_dbg(dev, "pipe %d : queue pop\n", usbhs_pipe_number(pipe));
 
 	ureq->req.status = status;
 	spin_unlock(usbhs_priv_to_lock(priv));
@@ -685,7 +686,13 @@ static int usbhsg_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 	struct usbhsg_request *ureq = usbhsg_req_to_ureq(req);
 	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
 
-	usbhs_pkt_pop(pipe, usbhsg_ureq_to_pkt(ureq));
+	if (pipe)
+		usbhs_pkt_pop(pipe, usbhsg_ureq_to_pkt(ureq));
+
+	/*
+	 * To dequeue a request, this driver should call the usbhsg_queue_pop()
+	 * even if the pipe is NULL.
+	 */
 	usbhsg_queue_pop(uep, ureq, -ECONNRESET);
 
 	return 0;
-- 
1.9.1


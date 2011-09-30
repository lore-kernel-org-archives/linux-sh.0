From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Sep 2011 11:07:08 +0000
Subject: [PATCH v2 1/4] usb: r8a66597-udc: change prototype of
Message-Id: <4E85A2DC.9030209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - divide a patch for changing prototype only

 drivers/usb/gadget/r8a66597-udc.c |    4 ++--
 drivers/usb/gadget/r8a66597-udc.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 50991e5..cd2cd16 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -733,7 +733,7 @@ static void irq_ep0_write(struct r8a66597_ep *ep, struct r8a66597_request *req)
 	/* write fifo */
 	if (req->req.buf) {
 		if (size > 0)
-			r8a66597_write_fifo(r8a66597, ep->fifoaddr, buf, size);
+			r8a66597_write_fifo(r8a66597, ep, buf, size);
 		if ((size = 0) || ((size % ep->ep.maxpacket) != 0))
 			r8a66597_bset(r8a66597, BVAL, ep->fifoctr);
 	}
@@ -780,7 +780,7 @@ static void irq_packet_write(struct r8a66597_ep *ep,

 	/* write fifo */
 	if (req->req.buf) {
-		r8a66597_write_fifo(r8a66597, ep->fifoaddr, buf, size);
+		r8a66597_write_fifo(r8a66597, ep, buf, size);
 		if ((size = 0)
 				|| ((size % ep->ep.maxpacket) != 0)
 				|| ((bufsize != ep->ep.maxpacket)
diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index 503f766..c6193fb 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -183,11 +183,11 @@ static inline void r8a66597_write(struct r8a66597 *r8a66597, u16 val,
 }

 static inline void r8a66597_write_fifo(struct r8a66597 *r8a66597,
-				       unsigned long offset,
+				       struct r8a66597_ep *ep,
 				       unsigned char *buf,
 				       int len)
 {
-	void __iomem *fifoaddr = r8a66597->reg + offset;
+	void __iomem *fifoaddr = r8a66597->reg + ep->fifoaddr;
 	int adj = 0;
 	int i;

-- 
1.7.1

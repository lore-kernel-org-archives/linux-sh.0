From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 22 Aug 2014 11:14:28 +0000
Subject: [PATCH 4/4] usb: renesas_usbhs: fix the usb_pkt_pop()
Message-Id: <53F72614.4030807@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the usb_pkt_pop(). If a gadget driver calls
usb_ep_dequeue(), this driver will call the usb_pkt_pop().
So, the usb_pkt_pop() should cancel the transaction.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 1564829..b0c97a3 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -108,19 +108,45 @@ static struct usbhs_pkt *__usbhsf_pkt_get(struct usbhs_pipe *pipe)
 	return list_first_entry(&pipe->list, struct usbhs_pkt, node);
 }

+static void usbhsf_fifo_clear(struct usbhs_pipe *pipe,
+			      struct usbhs_fifo *fifo);
+static void usbhsf_fifo_unselect(struct usbhs_pipe *pipe,
+				 struct usbhs_fifo *fifo);
+static struct dma_chan *usbhsf_dma_chan_get(struct usbhs_fifo *fifo,
+					    struct usbhs_pkt *pkt);
+#define usbhsf_dma_map(p)	__usbhsf_dma_map_ctrl(p, 1)
+#define usbhsf_dma_unmap(p)	__usbhsf_dma_map_ctrl(p, 0)
+static int __usbhsf_dma_map_ctrl(struct usbhs_pkt *pkt, int map);
 struct usbhs_pkt *usbhs_pkt_pop(struct usbhs_pipe *pipe, struct usbhs_pkt *pkt)
 {
 	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
+	struct usbhs_fifo *fifo = usbhs_pipe_to_fifo(pipe);
 	unsigned long flags;

 	/********************  spin lock ********************/
 	usbhs_lock(priv, flags);

+	usbhs_pipe_disable(pipe);
+
 	if (!pkt)
 		pkt = __usbhsf_pkt_get(pipe);

-	if (pkt)
+	if (pkt) {
+		struct dma_chan *chan = NULL;
+
+		if (fifo)
+			chan = usbhsf_dma_chan_get(fifo, pkt);
+		if (chan) {
+			dmaengine_terminate_all(chan);
+			usbhsf_fifo_clear(pipe, fifo);
+			usbhsf_dma_unmap(pkt);
+		}
+
 		__usbhsf_pkt_del(pkt);
+	}
+
+	if (fifo)
+		usbhsf_fifo_unselect(pipe, fifo);

 	usbhs_unlock(priv, flags);
 	/********************  spin unlock ******************/
@@ -778,8 +804,6 @@ static void __usbhsf_dma_ctrl(struct usbhs_pipe *pipe,
 	usbhs_bset(priv, fifo->sel, DREQE, dreqe);
 }

-#define usbhsf_dma_map(p)	__usbhsf_dma_map_ctrl(p, 1)
-#define usbhsf_dma_unmap(p)	__usbhsf_dma_map_ctrl(p, 0)
 static int __usbhsf_dma_map_ctrl(struct usbhs_pkt *pkt, int map)
 {
 	struct usbhs_pipe *pipe = pkt->pipe;
-- 
1.7.9.5


From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:54 +0000
Subject: [PATCH/RFC v2 23/29] serial: sh-sci: Fix race condition between RX work_struct and cleanup
Message-Id: <1437070920-28069-24-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

During serial port shutdown, the DMA receive worker function may still
be called after the receive DMA cleanup function has been called.
Fix this race condition between work_fn_rx() and sci_rx_dma_release() by
acquiring the port's spinlock in sci_rx_dma_release().
This requires releasing the spinlock in work_fn_rx() before calling (any
function that may call) sci_rx_dma_release().

Terminate all active receive DMA descriptors to release them, and to
make sure no more completions come in.

Do the same in sci_tx_dma_release() for symmetry, although the serial
upper layer will no longer submit more data at this point of time.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5707cd0c8e432be4..9714fc1b72b3cf8c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1362,8 +1362,12 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	s->chan_rx = NULL;
+	spin_unlock_irqrestore(&port->lock, flags);
+	dmaengine_terminate_all(chan);
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
 	if (sg_dma_address(&s->sg_rx[0])) {
 		dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
@@ -1380,8 +1384,12 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 {
 	struct dma_chan *chan = s->chan_tx;
 	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	spin_lock_irqsave(&port->lock, flags);
 	s->chan_tx = NULL;
+	spin_unlock_irqrestore(&port->lock, flags);
+	dmaengine_terminate_all(chan);
 	s->cookie_tx = -EINVAL;
 	if (s->sg_len_tx) {
 		/* Restore sg_dma_len() and sg_dma_address() */
@@ -1456,7 +1464,8 @@ static void work_fn_rx(struct work_struct *work)
 	} else {
 		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
 			s->active_rx);
-		goto out;
+		spin_unlock_irqrestore(&port->lock, flags);
+		return;
 	}
 	desc = s->desc_rx[new];
 
@@ -1477,23 +1486,23 @@ static void work_fn_rx(struct work_struct *work)
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
 
+		spin_unlock_irqrestore(&port->lock, flags);
 		sci_submit_rx(s);
-
-		goto out;
+		return;
 	}
 
 	s->cookie_rx[new] = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_rx[new])) {
 		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
+		spin_unlock_irqrestore(&port->lock, flags);
 		sci_rx_dma_release(s, true);
-		goto out;
+		return;
 	}
 
 	s->active_rx = s->cookie_rx[!new];
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
-out:
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-- 
1.9.1


From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:53 +0000
Subject: [PATCH/RFC v2 22/29] serial: sh-sci: Stop acknowledging DMA transmit completions
Message-Id: <1437070920-28069-23-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As dmaengine_prep_slave_sg() is called with the DMA_CTRL_ACK flag set
for DMA transmit requests, there's no need to explicitly acknowledge DMA
transmit requests in the DMA transmit completion callback.

Hence remove the call to async_tx_ack(), and remove the now unused
dma_async_tx_descriptor pointer in the sci_port structure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 13600e552947fb69..5707cd0c8e432be4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -104,7 +104,6 @@ struct sci_port {
 	struct dma_chan			*chan_rx;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	struct dma_async_tx_descriptor	*desc_tx;
 	struct dma_async_tx_descriptor	*desc_rx[2];
 	dma_cookie_t			cookie_tx;
 	dma_cookie_t			cookie_rx[2];
@@ -1284,9 +1283,6 @@ static void sci_dma_tx_complete(void *arg)
 
 	port->icount.tx += sg_dma_len(&s->sg_tx);
 
-	async_tx_ack(s->desc_tx);
-	s->desc_tx = NULL;
-
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
@@ -1541,7 +1537,6 @@ static void work_fn_tx(struct work_struct *work)
 	dma_sync_sg_for_device(port->dev, sg, 1, DMA_TO_DEVICE);
 
 	spin_lock_irq(&port->lock);
-	s->desc_tx = desc;
 	desc->callback = sci_dma_tx_complete;
 	desc->callback_param = s;
 	spin_unlock_irq(&port->lock);
-- 
1.9.1


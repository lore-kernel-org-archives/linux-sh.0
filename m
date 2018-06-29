From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Jun 2018 14:25:07 +0000
Subject: [PATCH 1/3] serial: sh-sci: Postpone DMA release when falling back to PIO
Message-Id: <20180629142513.20743-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-1-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When the sh-sci driver detects an issue with DMA during operation, it
falls backs to PIO, and releases all DMA resources.

As releasing DMA resources immediately has no advantages, but
complicates the code, and is susceptible to races, it is better to
postpone this to port shutdown.

This allows to remove the locking from sci_rx_dma_release() and
sci_tx_dma_release(), but requires keeping a copy of the DMA channel
pointers for release during port shutdown.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 81 +++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c181eb37f98509e6..0ed91692f53ad859 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -135,6 +135,8 @@ struct sci_port {
 	struct dma_chan			*chan_rx;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
+	struct dma_chan			*chan_tx_saved;
+	struct dma_chan			*chan_rx_saved;
 	dma_cookie_t			cookie_tx;
 	dma_cookie_t			cookie_rx[2];
 	dma_cookie_t			active_rx;
@@ -1212,25 +1214,17 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 	return -1;
 }
 
-static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
+static void sci_rx_dma_release(struct sci_port *s)
 {
-	struct dma_chan *chan = s->chan_rx;
+	struct dma_chan *chan = s->chan_rx_saved;
 	struct uart_port *port = &s->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
-	s->chan_rx = NULL;
+	s->chan_rx_saved = s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
-	spin_unlock_irqrestore(&port->lock, flags);
 	dmaengine_terminate_all(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
-	if (enable_pio) {
-		spin_lock_irqsave(&port->lock, flags);
-		sci_start_rx(port);
-		spin_unlock_irqrestore(&port->lock, flags);
-	}
 }
 
 static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
@@ -1289,33 +1283,31 @@ static void sci_dma_rx_complete(void *arg)
 fail:
 	spin_unlock_irqrestore(&port->lock, flags);
 	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
-	sci_rx_dma_release(s, true);
+	/* Switch to PIO */
+	spin_lock_irqsave(&port->lock, flags);
+	s->chan_rx = NULL;
+	sci_start_rx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
+static void sci_tx_dma_release(struct sci_port *s)
 {
-	struct dma_chan *chan = s->chan_tx;
+	struct dma_chan *chan = s->chan_tx_saved;
 	struct uart_port *port = &s->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
-	s->chan_tx = NULL;
+	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
-	spin_unlock_irqrestore(&port->lock, flags);
 	dmaengine_terminate_all(chan);
 	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
-	if (enable_pio) {
-		spin_lock_irqsave(&port->lock, flags);
-		sci_start_tx(port);
-		spin_unlock_irqrestore(&port->lock, flags);
-	}
 }
 
 static void sci_submit_rx(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx;
+	struct uart_port *port = &s->port;
+	unsigned long flags;
 	int i;
 
 	for (i = 0; i < 2; i++) {
@@ -1347,7 +1339,11 @@ static void sci_submit_rx(struct sci_port *s)
 	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
 	s->active_rx = -EINVAL;
-	sci_rx_dma_release(s, true);
+	/* Switch to PIO */
+	spin_lock_irqsave(&port->lock, flags);
+	s->chan_rx = NULL;
+	sci_start_rx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void work_fn_tx(struct work_struct *work)
@@ -1357,6 +1353,7 @@ static void work_fn_tx(struct work_struct *work)
 	struct dma_chan *chan = s->chan_tx;
 	struct uart_port *port = &s->port;
 	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long flags;
 	dma_addr_t buf;
 
 	/*
@@ -1378,9 +1375,7 @@ static void work_fn_tx(struct work_struct *work)
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		dev_warn(port->dev, "Failed preparing Tx DMA descriptor\n");
-		/* switch to PIO */
-		sci_tx_dma_release(s, true);
-		return;
+		goto switch_to_pio;
 	}
 
 	dma_sync_single_for_device(chan->device->dev, buf, s->tx_dma_len,
@@ -1393,15 +1388,21 @@ static void work_fn_tx(struct work_struct *work)
 	s->cookie_tx = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_tx)) {
 		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
-		/* switch to PIO */
-		sci_tx_dma_release(s, true);
-		return;
+		goto switch_to_pio;
 	}
 
 	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
 		__func__, xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
 
 	dma_async_issue_pending(chan);
+	return;
+
+switch_to_pio:
+	spin_lock_irqsave(&port->lock, flags);
+	s->chan_tx = NULL;
+	sci_start_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+	return;
 }
 
 static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
@@ -1535,7 +1536,6 @@ static void sci_request_dma(struct uart_port *port)
 	chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
 	dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
 	if (chan) {
-		s->chan_tx = chan;
 		/* UART circular tx buffer is an aligned page. */
 		s->tx_dma_addr = dma_map_single(chan->device->dev,
 						port->state->xmit.buf,
@@ -1544,11 +1544,13 @@ static void sci_request_dma(struct uart_port *port)
 		if (dma_mapping_error(chan->device->dev, s->tx_dma_addr)) {
 			dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
 			dma_release_channel(chan);
-			s->chan_tx = NULL;
+			chan = NULL;
 		} else {
 			dev_dbg(port->dev, "%s: mapped %lu@%p to %pad\n",
 				__func__, UART_XMIT_SIZE,
 				port->state->xmit.buf, &s->tx_dma_addr);
+
+			s->chan_tx_saved = s->chan_tx = chan;
 		}
 
 		INIT_WORK(&s->work_tx, work_fn_tx);
@@ -1561,8 +1563,6 @@ static void sci_request_dma(struct uart_port *port)
 		dma_addr_t dma;
 		void *buf;
 
-		s->chan_rx = chan;
-
 		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
 		buf = dma_alloc_coherent(chan->device->dev, s->buf_len_rx * 2,
 					 &dma, GFP_KERNEL);
@@ -1570,7 +1570,6 @@ static void sci_request_dma(struct uart_port *port)
 			dev_warn(port->dev,
 				 "Failed to allocate Rx dma buffer, using PIO\n");
 			dma_release_channel(chan);
-			s->chan_rx = NULL;
 			return;
 		}
 
@@ -1591,6 +1590,8 @@ static void sci_request_dma(struct uart_port *port)
 
 		if (port->type = PORT_SCIFA || port->type = PORT_SCIFB)
 			sci_submit_rx(s);
+
+		s->chan_rx_saved = s->chan_rx = chan;
 	}
 }
 
@@ -1598,10 +1599,10 @@ static void sci_free_dma(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 
-	if (s->chan_tx)
-		sci_tx_dma_release(s, false);
-	if (s->chan_rx)
-		sci_rx_dma_release(s, false);
+	if (s->chan_tx_saved)
+		sci_tx_dma_release(s);
+	if (s->chan_rx_saved)
+		sci_rx_dma_release(s);
 }
 
 static void sci_flush_buffer(struct uart_port *port)
@@ -2092,7 +2093,7 @@ static void sci_shutdown(struct uart_port *port)
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	if (s->chan_rx) {
+	if (s->chan_rx_saved) {
 		dev_dbg(port->dev, "%s(%d) deleting rx_timer\n", __func__,
 			port->line);
 		hrtimer_cancel(&s->rx_timer);
-- 
2.17.1


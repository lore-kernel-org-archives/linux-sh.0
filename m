From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:59 +0000
Subject: [PATCH/RFC v2 28/29] serial: sh-sci: Add (H)SCIF DMA support
Message-Id: <1437070920-28069-29-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When using receive DMA on SCIF and HSCIF, an interrupt is triggered only
after the whole DMA request has been transferred. If less data is
received, it will stay stuck until more data arrives.

To make sure we are notified as soon as any data has arrived, an
additional one-byte DMA buffer is used. Once the first byte of data is
received, the traditional larger DMA buffers are used, and the receive
DMA timeout system will take care of receiving partial data.

This was inspired by a patch in the BSP by Koji Matsuoka
<koji.matsuoka.xm@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 91 +++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 64589a04f1d36c74..27c811351e1bff45 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -104,14 +104,17 @@ struct sci_port {
 	struct dma_chan			*chan_rx;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	struct dma_async_tx_descriptor	*desc_rx[2];
+#define MAX_BUF_RX			3
+
+	struct dma_async_tx_descriptor	*desc_rx[MAX_BUF_RX];
 	dma_cookie_t			cookie_tx;
-	dma_cookie_t			cookie_rx[2];
+	dma_cookie_t			cookie_rx[MAX_BUF_RX];
 	dma_cookie_t			active_rx;
 	struct scatterlist		sg_tx;
 	unsigned int			sg_len_tx;
-	struct scatterlist		sg_rx[2];
-	size_t				buf_len_rx;
+	struct scatterlist		sg_rx[MAX_BUF_RX];
+	unsigned int			total_buf_len_rx;
+	unsigned int			nr_buf_rx;
 	struct work_struct		work_tx;
 	struct work_struct		work_rx;
 	struct timer_list		rx_timer;
@@ -1302,7 +1305,7 @@ static void sci_dma_tx_complete(void *arg)
 
 /* Locking: called with port lock held */
 static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
-			   size_t count)
+			   unsigned int count)
 {
 	struct uart_port *port = &s->port;
 	struct tty_port *tport = &port->state->port;
@@ -1328,7 +1331,7 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(s->cookie_rx); i++)
+	for (i = 0; i < s->nr_buf_rx; i++)
 		if (s->active_rx = s->cookie_rx[i])
 			return i;
 
@@ -1351,7 +1354,8 @@ static void sci_dma_rx_complete(void *arg)
 
 	active = sci_dma_rx_find_active(s);
 	if (active >= 0)
-		count = sci_dma_rx_push(s, &s->sg_rx[active], s->buf_len_rx);
+		count = sci_dma_rx_push(s, &s->sg_rx[active],
+					sg_dma_len(&s->sg_rx[active]));
 
 	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
@@ -1367,15 +1371,17 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
+	unsigned int i;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
 	s->chan_rx = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
 	dmaengine_terminate_all(chan);
-	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
+	for (i = 0; i < s->nr_buf_rx; i++)
+		s->cookie_rx[i] = -EINVAL;
 	if (sg_dma_address(&s->sg_rx[0])) {
-		dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
+		dma_free_coherent(chan->device->dev, s->total_buf_len_rx,
 				  sg_virt(&s->sg_rx[0]),
 				  sg_dma_address(&s->sg_rx[0]));
 		sg_dma_address(&s->sg_rx[0]) = 0;
@@ -1412,9 +1418,9 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 static void sci_submit_rx(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx;
-	int i;
+	unsigned int i;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < s->nr_buf_rx; i++) {
 		struct scatterlist *sg = &s->sg_rx[i];
 		struct dma_async_tx_descriptor *desc;
 
@@ -1443,7 +1449,7 @@ static void sci_submit_rx(struct sci_port *s)
 fail:
 	if (i)
 		dmaengine_terminate_all(chan);
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < s->nr_buf_rx; i++) {
 		s->desc_rx[i] = NULL;
 		s->cookie_rx[i] = -EINVAL;
 	}
@@ -1460,7 +1466,7 @@ static void work_fn_rx(struct work_struct *work)
 	struct dma_tx_state state;
 	enum dma_status status;
 	unsigned long flags;
-	int new;
+	int new, next;
 
 	spin_lock_irqsave(&port->lock, flags);
 	new = sci_dma_rx_find_active(s);
@@ -1501,11 +1507,18 @@ static void work_fn_rx(struct work_struct *work)
 	s->desc_rx[new] = desc;
 	desc->callback = sci_dma_rx_complete;
 	desc->callback_param = s;
-	s->cookie_rx[new] = dmaengine_submit(desc);
-	if (dma_submit_error(s->cookie_rx[new]))
-		goto fail;
+	/* Skip the one-byte buffer for new DMA requests */
+	if (sg_dma_len(&s->sg_rx[new]) > 1) {
+		s->cookie_rx[new] = dmaengine_submit(desc);
+		if (dma_submit_error(s->cookie_rx[new]))
+			goto fail;
+	}
+	if (s->nr_buf_rx < MAX_BUF_RX)
+		next = !new;
+	else
+		next = new % 2 + 1;
 
-	s->active_rx = s->cookie_rx[!new];
+	s->active_rx = s->cookie_rx[next];
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
@@ -1777,34 +1790,46 @@ static void sci_request_dma(struct uart_port *port)
 	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM, s->cfg->dma_slave_rx);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
 	if (chan) {
-		dma_addr_t dma[2];
-		void *buf[2];
-		int i;
+		unsigned int buflen[MAX_BUF_RX];
+		unsigned int i = 0;
+		dma_addr_t dma;
+		void *buf;
 
 		s->chan_rx = chan;
+		s->nr_buf_rx = MAX_BUF_RX - 1;
+		s->total_buf_len_rx = 0;
+
+		/* (H)SCIF needs an additional one-byte buffer */
+		if (port->type = PORT_SCIF || port->type = PORT_HSCIF) {
+			buflen[i++] = 1;
+			s->total_buf_len_rx += 1;
+			s->nr_buf_rx++;
+		}
 
-		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
-		buf[0] = dma_alloc_coherent(chan->device->dev,
-					    s->buf_len_rx * 2, &dma[0],
-					    GFP_KERNEL);
+		for (; i < s->nr_buf_rx; i++) {
+			buflen[i] = 2 * max(16U, port->fifosize);
+			s->total_buf_len_rx += buflen[i];
+		}
 
-		if (!buf[0]) {
+		buf = dma_alloc_coherent(chan->device->dev, s->total_buf_len_rx,
+					 &dma, GFP_KERNEL);
+		if (!buf) {
 			dev_warn(port->dev,
 				 "Failed to allocate Rx dma buffer, using PIO\n");
 			sci_rx_dma_release(s, true);
 			return;
 		}
 
-		buf[1] = buf[0] + s->buf_len_rx;
-		dma[1] = dma[0] + s->buf_len_rx;
-
-		for (i = 0; i < 2; i++) {
+		for (i = 0; i < s->nr_buf_rx; i++) {
 			struct scatterlist *sg = &s->sg_rx[i];
 
 			sg_init_table(sg, 1);
-			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
-				    offset_in_page(buf[i]));
-			sg_dma_address(sg) = dma[i];
+			sg_set_page(sg, virt_to_page(buf), buflen[i],
+				    offset_in_page(buf));
+			sg_dma_address(sg) = dma;
+
+			buf += buflen[i];
+			dma += buflen[i];
 		}
 
 		INIT_WORK(&s->work_rx, work_fn_rx);
@@ -2098,7 +2123,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			bits++;
 		if (termios->c_cflag & PARENB)
 			bits++;
-		s->rx_timeout = DIV_ROUND_UP((s->buf_len_rx * 2 * bits * HZ) /
+		s->rx_timeout = DIV_ROUND_UP((s->total_buf_len_rx * bits * HZ) /
 					     (baud / 10), 10);
 		dev_dbg(port->dev, "DMA Rx t-out %ums, tty t-out %u jiffies\n",
 			s->rx_timeout * 1000 / HZ, port->timeout);
-- 
1.9.1


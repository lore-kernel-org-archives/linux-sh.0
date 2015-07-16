From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:58 +0000
Subject: [PATCH/RFC v2 27/29] serial: sh-sci: Pass scatterlist to sci_dma_rx_push()
Message-Id: <1437070920-28069-28-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently sci_dma_rx_push() has to find the active scatterlist itself,
but in some cases the caller already knows.

Hence let the caller pass the scatterlist, and introduce a helper to
find the active DMA request while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0e99c570e2da4d64..64589a04f1d36c74 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1301,24 +1301,15 @@ static void sci_dma_tx_complete(void *arg)
 }
 
 /* Locking: called with port lock held */
-static int sci_dma_rx_push(struct sci_port *s, size_t count)
+static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
+			   size_t count)
 {
 	struct uart_port *port = &s->port;
 	struct tty_port *tport = &port->state->port;
-	int i, active, room;
+	int i, room;
 
 	room = tty_buffer_request_room(tport, count);
 
-	if (s->active_rx = s->cookie_rx[0]) {
-		active = 0;
-	} else if (s->active_rx = s->cookie_rx[1]) {
-		active = 1;
-	} else {
-		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
-			s->active_rx);
-		return 0;
-	}
-
 	if (room < count)
 		dev_warn(port->dev, "Rx overrun: dropping %zu bytes\n",
 			 count - room);
@@ -1326,27 +1317,41 @@ static int sci_dma_rx_push(struct sci_port *s, size_t count)
 		return room;
 
 	for (i = 0; i < room; i++)
-		tty_insert_flip_char(tport, ((u8 *)sg_virt(&s->sg_rx[active]))[i],
-				     TTY_NORMAL);
+		tty_insert_flip_char(tport, ((u8 *)sg_virt(sg))[i], TTY_NORMAL);
 
 	port->icount.rx += room;
 
 	return room;
 }
 
+static int sci_dma_rx_find_active(struct sci_port *s)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(s->cookie_rx); i++)
+		if (s->active_rx = s->cookie_rx[i])
+			return i;
+
+	dev_err(s->port.dev, "%s: Rx cookie %u not found!\n", __func__,
+		s->active_rx);
+	return -1;
+}
+
 static void sci_dma_rx_complete(void *arg)
 {
 	struct sci_port *s = arg;
 	struct uart_port *port = &s->port;
 	unsigned long flags;
-	int count;
+	int active, count = 0;
 
 	dev_dbg(port->dev, "%s(%d) active cookie %d\n", __func__, port->line,
 		s->active_rx);
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	count = sci_dma_rx_push(s, s->buf_len_rx);
+	active = sci_dma_rx_find_active(s);
+	if (active >= 0)
+		count = sci_dma_rx_push(s, &s->sg_rx[active], s->buf_len_rx);
 
 	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
@@ -1458,13 +1463,8 @@ static void work_fn_rx(struct work_struct *work)
 	int new;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (s->active_rx = s->cookie_rx[0]) {
-		new = 0;
-	} else if (s->active_rx = s->cookie_rx[1]) {
-		new = 1;
-	} else {
-		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
-			s->active_rx);
+	new = sci_dma_rx_find_active(s);
+	if (new < 0) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
@@ -1482,7 +1482,7 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n", read,
 			s->active_rx);
 
-		count = sci_dma_rx_push(s, read);
+		count = sci_dma_rx_push(s, &s->sg_rx[new], read);
 
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
-- 
1.9.1


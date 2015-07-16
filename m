From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:52 +0000
Subject: [PATCH/RFC v2 21/29] serial: sh-sci: Fix exclusion of work_fn_rx and sci_dma_rx_complete
Message-Id: <1437070920-28069-22-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

There is a problem when the sci_dma_rx_complete() is processed
before cancel process of work_fn_rx() completes by rx_timer_fn().
This patch locks work_fn_rx().

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 204f1f6ad72f6236..13600e552947fb69 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1449,8 +1449,10 @@ static void work_fn_rx(struct work_struct *work)
 	struct dma_async_tx_descriptor *desc;
 	struct dma_tx_state state;
 	enum dma_status status;
+	unsigned long flags;
 	int new;
 
+	spin_lock_irqsave(&port->lock, flags);
 	if (s->active_rx = s->cookie_rx[0]) {
 		new = 0;
 	} else if (s->active_rx = s->cookie_rx[1]) {
@@ -1458,7 +1460,7 @@ static void work_fn_rx(struct work_struct *work)
 	} else {
 		dev_err(port->dev, "%s: Rx cookie %d not found!\n", __func__,
 			s->active_rx);
-		return;
+		goto out;
 	}
 	desc = s->desc_rx[new];
 
@@ -1466,7 +1468,6 @@ static void work_fn_rx(struct work_struct *work)
 	if (status != DMA_COMPLETE) {
 		/* Handle incomplete DMA receive */
 		struct dma_chan *chan = s->chan_rx;
-		unsigned long flags;
 		unsigned int read;
 		int count;
 
@@ -1475,29 +1476,29 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n", read,
 			s->active_rx);
 
-		spin_lock_irqsave(&port->lock, flags);
 		count = sci_dma_rx_push(s, read);
-		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (count)
 			tty_flip_buffer_push(&port->state->port);
 
 		sci_submit_rx(s);
 
-		return;
+		goto out;
 	}
 
 	s->cookie_rx[new] = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_rx[new])) {
 		dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 		sci_rx_dma_release(s, true);
-		return;
+		goto out;
 	}
 
 	s->active_rx = s->cookie_rx[!new];
 
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[new], new, s->active_rx);
+out:
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void work_fn_tx(struct work_struct *work)
-- 
1.9.1


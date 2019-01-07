From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 07 Jan 2019 16:23:20 +0000
Subject: [PATCH v5 4/4] serial: sh-sci: Make RX/TX DMA function names consistent
Message-Id: <20190107162320.15530-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190107162320.15530-1-geert+renesas@glider.be>
In-Reply-To: <20190107162320.15530-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Most RX/TX-specific DMA functions are prefixed with "sci_dma_[rt]x_".
Rename the exceptions to increase consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/tty/serial/sh-sci.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 891833315698b953..cb3d5d37674f56f2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1253,7 +1253,7 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 	s->active_rx = 0;
 }
 
-static void sci_rx_dma_release(struct sci_port *s)
+static void sci_dma_rx_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx_saved;
 
@@ -1343,7 +1343,7 @@ static void sci_dma_rx_complete(void *arg)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static void sci_tx_dma_release(struct sci_port *s)
+static void sci_dma_tx_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_tx_saved;
 
@@ -1356,7 +1356,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 	dma_release_channel(chan);
 }
 
-static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
+static int sci_dma_rx_submit(struct sci_port *s, bool port_lock_held)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
@@ -1399,7 +1399,7 @@ static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
 	return -EAGAIN;
 }
 
-static void work_fn_tx(struct work_struct *work)
+static void sci_dma_tx_work_fn(struct work_struct *work)
 {
 	struct sci_port *s = container_of(work, struct sci_port, work_tx);
 	struct dma_async_tx_descriptor *desc;
@@ -1458,7 +1458,7 @@ static void work_fn_tx(struct work_struct *work)
 	return;
 }
 
-static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
+static enum hrtimer_restart sci_dma_rx_timer_fn(struct hrtimer *t)
 {
 	struct sci_port *s = container_of(t, struct sci_port, rx_timer);
 	struct dma_chan *chan = s->chan_rx;
@@ -1515,7 +1515,7 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	}
 
 	if (port->type = PORT_SCIFA || port->type = PORT_SCIFB)
-		sci_submit_rx(s, true);
+		sci_dma_rx_submit(s, true);
 
 	sci_dma_rx_reenable_irq(s);
 
@@ -1595,7 +1595,7 @@ static void sci_request_dma(struct uart_port *port)
 				__func__, UART_XMIT_SIZE,
 				port->state->xmit.buf, &s->tx_dma_addr);
 
-			INIT_WORK(&s->work_tx, work_fn_tx);
+			INIT_WORK(&s->work_tx, sci_dma_tx_work_fn);
 			s->chan_tx_saved = s->chan_tx = chan;
 		}
 	}
@@ -1630,12 +1630,12 @@ static void sci_request_dma(struct uart_port *port)
 		}
 
 		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		s->rx_timer.function = rx_timer_fn;
+		s->rx_timer.function = sci_dma_rx_timer_fn;
 
 		s->chan_rx_saved = s->chan_rx = chan;
 
 		if (port->type = PORT_SCIFA || port->type = PORT_SCIFB)
-			sci_submit_rx(s, false);
+			sci_dma_rx_submit(s, false);
 	}
 }
 
@@ -1644,9 +1644,9 @@ static void sci_free_dma(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 
 	if (s->chan_tx_saved)
-		sci_tx_dma_release(s);
+		sci_dma_tx_release(s);
 	if (s->chan_rx_saved)
-		sci_rx_dma_release(s);
+		sci_dma_rx_release(s);
 }
 
 static void sci_flush_buffer(struct uart_port *port)
@@ -1684,7 +1684,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 			disable_irq_nosync(irq);
 			scr |= SCSCR_RDRQE;
 		} else {
-			if (sci_submit_rx(s, false) < 0)
+			if (sci_dma_rx_submit(s, false) < 0)
 				goto handle_pio;
 
 			scr &= ~SCSCR_RIE;
-- 
2.17.1

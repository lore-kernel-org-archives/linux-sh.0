From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 13:53:04 +0000
Subject: [PATCH] SH: extend SCI DMA support to work on SCIFA ports
Message-Id: <Pine.LNX.4.64.1003191452370.5412@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIFA ports have additional bits to control DMA requests and they must have
respective interrupt sources enabled, as the datasheet suggests, the only way
to avoid actually taking interrupts in addition to DMA events is by masking the
IRQ on the CPU.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/serial/sh-sci.c |  123 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 90 insertions(+), 33 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 980f394..7d6733f 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -107,6 +107,7 @@ struct sci_port {
 	struct work_struct		work_tx;
 	struct work_struct		work_rx;
 	struct timer_list		rx_timer;
+	unsigned int			rx_timeout;
 #endif
 };
 
@@ -674,22 +675,22 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 	struct sci_port *s = to_sci_port(port);
 
 	if (s->chan_rx) {
-		unsigned long tout;
 		u16 scr = sci_in(port, SCSCR);
 		u16 ssr = sci_in(port, SCxSR);
 
 		/* Disable future Rx interrupts */
-		sci_out(port, SCSCR, scr & ~SCI_CTRL_FLAGS_RIE);
+		if (port->type = PORT_SCIFA) {
+			disable_irq_nosync(irq);
+			scr |= 0x4000;
+		} else {
+			scr &= ~SCI_CTRL_FLAGS_RIE;
+		}
+		sci_out(port, SCSCR, scr);
 		/* Clear current interrupt */
 		sci_out(port, SCxSR, ssr & ~(1 | SCxSR_RDxF(port)));
-		/* Calculate delay for 1.5 DMA buffers */
-		tout = (port->timeout - HZ / 50) * s->buf_len_rx * 3 /
-			port->fifosize / 2;
-		dev_dbg(port->dev, "Rx IRQ: setup timeout in %lu ms\n",
-			tout * 1000 / HZ);
-		if (tout < 2)
-			tout = 2;
-		mod_timer(&s->rx_timer, jiffies + tout);
+		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u jiffies\n",
+			jiffies, s->rx_timeout);
+		mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
 		return IRQ_HANDLED;
 	}
@@ -926,13 +927,17 @@ static void sci_dma_tx_complete(void *arg)
 	s->cookie_tx = -EINVAL;
 	s->desc_tx = NULL;
 
-	spin_unlock_irqrestore(&port->lock, flags);
-
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (uart_circ_chars_pending(xmit))
+	if (!uart_circ_empty(xmit)) {
 		schedule_work(&s->work_tx);
+	} else if (port->type = PORT_SCIFA) {
+		u16 ctrl = sci_in(port, SCSCR);
+		sci_out(port, SCSCR, ctrl & ~SCI_CTRL_FLAGS_TIE);
+	}
+
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 /* Locking: called with port lock held */
@@ -976,13 +981,13 @@ static void sci_dma_rx_complete(void *arg)
 	unsigned long flags;
 	int count;
 
-	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
+	dev_dbg(port->dev, "%s(%d) active #%d\n", __func__, port->line, s->active_rx);
 
 	spin_lock_irqsave(&port->lock, flags);
 
 	count = sci_dma_rx_push(s, tty, s->buf_len_rx);
 
-	mod_timer(&s->rx_timer, jiffies + msecs_to_jiffies(5));
+	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -1054,6 +1059,8 @@ static void sci_submit_rx(struct sci_port *s)
 			sci_rx_dma_release(s, true);
 			return;
 		}
+		dev_dbg(s->port.dev, "%s(): cookie %d to #%d\n", __func__,
+			s->cookie_rx[i], i);
 	}
 
 	s->active_rx = s->cookie_rx[0];
@@ -1111,10 +1118,10 @@ static void work_fn_rx(struct work_struct *work)
 		return;
 	}
 
-	dev_dbg(port->dev, "%s: cookie %d #%d\n", __func__,
-		s->cookie_rx[new], new);
-
 	s->active_rx = s->cookie_rx[!new];
+
+	dev_dbg(port->dev, "%s: cookie %d #%d, new active #%d\n", __func__,
+		s->cookie_rx[new], new, s->active_rx);
 }
 
 static void work_fn_tx(struct work_struct *work)
@@ -1177,23 +1184,28 @@ static void work_fn_tx(struct work_struct *work)
 
 static void sci_start_tx(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
 	unsigned short ctrl;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	struct sci_port *s = to_sci_port(port);
-
-	if (s->chan_tx) {
-		if (!uart_circ_empty(&s->port.state->xmit) && s->cookie_tx < 0)
-			schedule_work(&s->work_tx);
-
-		return;
+	if (port->type = PORT_SCIFA) {
+		u16 new, scr = sci_in(port, SCSCR);
+		if (s->chan_tx)
+			new = scr | 0x8000;
+		else
+			new = scr & ~0x8000;
+		if (new != scr)
+			sci_out(port, SCSCR, new);
 	}
+	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
+	    s->cookie_tx < 0)
+		schedule_work(&s->work_tx);
 #endif
-
-	/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
-	ctrl = sci_in(port, SCSCR);
-	ctrl |= SCI_CTRL_FLAGS_TIE;
-	sci_out(port, SCSCR, ctrl);
+	if (!s->chan_tx || port->type = PORT_SCIFA) {
+		/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
+		ctrl = sci_in(port, SCSCR);
+		sci_out(port, SCSCR, ctrl | SCI_CTRL_FLAGS_TIE);
+	}
 }
 
 static void sci_stop_tx(struct uart_port *port)
@@ -1202,6 +1214,8 @@ static void sci_stop_tx(struct uart_port *port)
 
 	/* Clear TIE (Transmit Interrupt Enable) bit in SCSCR */
 	ctrl = sci_in(port, SCSCR);
+	if (port->type = PORT_SCIFA)
+		ctrl &= ~0x8000;
 	ctrl &= ~SCI_CTRL_FLAGS_TIE;
 	sci_out(port, SCSCR, ctrl);
 }
@@ -1212,6 +1226,8 @@ static void sci_start_rx(struct uart_port *port)
 
 	/* Set RIE (Receive Interrupt Enable) bit in SCSCR */
 	ctrl |= sci_in(port, SCSCR);
+	if (port->type = PORT_SCIFA)
+		ctrl &= ~0x4000;
 	sci_out(port, SCSCR, ctrl);
 }
 
@@ -1221,6 +1237,8 @@ static void sci_stop_rx(struct uart_port *port)
 
 	/* Clear RIE (Receive Interrupt Enable) bit in SCSCR */
 	ctrl = sci_in(port, SCSCR);
+	if (port->type = PORT_SCIFA)
+		ctrl &= ~0x4000;
 	ctrl &= ~(SCI_CTRL_FLAGS_RIE | SCI_CTRL_FLAGS_REIE);
 	sci_out(port, SCSCR, ctrl);
 }
@@ -1255,8 +1273,12 @@ static void rx_timer_fn(unsigned long arg)
 {
 	struct sci_port *s = (struct sci_port *)arg;
 	struct uart_port *port = &s->port;
-
 	u16 scr = sci_in(port, SCSCR);
+
+	if (port->type = PORT_SCIFA) {
+		scr &= ~0x4000;
+		enable_irq(s->irqs[1]);
+	}
 	sci_out(port, SCSCR, scr | SCI_CTRL_FLAGS_RIE);
 	dev_dbg(port->dev, "DMA Rx timed out\n");
 	schedule_work(&s->work_rx);
@@ -1407,8 +1429,21 @@ static void sci_shutdown(struct uart_port *port)
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+	struct sci_port *s = to_sci_port(port);
+#endif
 	unsigned int status, baud, smr_val, max_baud;
 	int t = -1;
+	u16 scfcr = 0;
+
+	/*
+	 * define SH_SCI_LOOPBACK_LINE to the number of the serial interface
+	 * to put it in the loopback mode
+	 */
+#ifdef SH_SCI_LOOPBACK_LINE
+	if (port->line = SH_SCI_LOOPBACK_LINE)
+		scfcr |= 1; /* Loopback - testing mode */
+#endif
 
 	/*
 	 * earlyprintk comes here early on with port->uartclk set to zero.
@@ -1431,7 +1466,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	sci_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */
 
 	if (port->type != PORT_SCI)
-		sci_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
+		sci_out(port, SCFCR, scfcr | SCFCR_RFRST | SCFCR_TFRST);
 
 	smr_val = sci_in(port, SCSMR) & 3;
 	if ((termios->c_cflag & CSIZE) = CS7)
@@ -1462,10 +1497,32 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	sci_init_pins(port, termios->c_cflag);
-	sci_out(port, SCFCR, (termios->c_cflag & CRTSCTS) ? SCFCR_MCE : 0);
+	sci_out(port, SCFCR, scfcr | ((termios->c_cflag & CRTSCTS) ? SCFCR_MCE : 0));
 
 	sci_out(port, SCSCR, SCSCR_INIT(port));
 
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+	/*
+	 * Calculate delay for 1.5 DMA buffers: see
+	 * drivers/serial/serial_core.c::uart_update_timeout(). With 10 bits
+	 * (CS8), 250Hz, 115200 baud and 64 bytes FIFO, the above function
+	 * calculates 1 jiffie for the data plus 5 jiffies for the "slop(e)."
+	 * Then below we calculate 3 jiffies (12ms) for 1.5 DMA buffers (3 FIFO
+	 * sizes), but it has been found out experimentally, that this is not
+	 * enough: the driver too often needlessly runs on a DMA timeout. 20ms
+	 * as a minimum seem to work perfectly.
+	 */
+	if (s->chan_rx) {
+		s->rx_timeout = (port->timeout - HZ / 50) * s->buf_len_rx * 3 /
+			port->fifosize / 2;
+		dev_dbg(port->dev,
+			"DMA Rx t-out %ums, tty t-out %u jiffies\n",
+			s->rx_timeout * 1000 / HZ, port->timeout);
+		if (s->rx_timeout < msecs_to_jiffies(20))
+			s->rx_timeout = msecs_to_jiffies(20);
+	}
+#endif
+
 	if ((termios->c_cflag & CREAD) != 0)
 		sci_start_rx(port);
 }
-- 
1.6.2.4


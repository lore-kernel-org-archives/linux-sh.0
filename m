From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 07 Jan 2019 16:23:18 +0000
Subject: [PATCH v5 2/4] serial: sh-sci: Extract sci_dma_rx_reenable_irq()
Message-Id: <20190107162320.15530-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190107162320.15530-1-geert+renesas@glider.be>
In-Reply-To: <20190107162320.15530-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Extract the functionality to direct new serial port interrupts back to
the CPU into its own helper, to prepare for using it from a second
callsite.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/tty/serial/sh-sci.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4c75468680cb547d..4d814c30c4189b56 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1274,6 +1274,20 @@ static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
 	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
 }
 
+static void sci_dma_rx_reenable_irq(struct sci_port *s)
+{
+	struct uart_port *port = &s->port;
+	u16 scr;
+
+	/* Direct new serial port interrupts back to CPU */
+	scr = serial_port_in(port, SCSCR);
+	if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
+		scr &= ~SCSCR_RDRQE;
+		enable_irq(s->irqs[SCIx_RXI_IRQ]);
+	}
+	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
+}
+
 static void sci_dma_rx_complete(void *arg)
 {
 	struct sci_port *s = arg;
@@ -1453,7 +1467,6 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	unsigned long flags;
 	unsigned int read;
 	int active, count;
-	u16 scr;
 
 	dev_dbg(port->dev, "DMA Rx timed out\n");
 
@@ -1503,13 +1516,7 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	if (port->type = PORT_SCIFA || port->type = PORT_SCIFB)
 		sci_submit_rx(s, true);
 
-	/* Direct new serial port interrupts back to CPU */
-	scr = serial_port_in(port, SCSCR);
-	if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
-		scr &= ~SCSCR_RDRQE;
-		enable_irq(s->irqs[SCIx_RXI_IRQ]);
-	}
-	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
+	sci_dma_rx_reenable_irq(s);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.17.1

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 06 Dec 2013 09:59:19 +0000
Subject: [PATCH 12/47] serial: sh-sci: Compute overrun_bit without using baud rate algo
Message-Id: <1386323994-12850-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

The overrun bit index is a property of the hardware. It's currently
computed based on a different and unrelated hardware property, the baud
rate calculation algorithm. Compute it using hardware identification
information only.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5cb7189..cd508c6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2132,30 +2132,38 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->irqs[i] = p->irqs[i] ? p->irqs[i] : -ENXIO;
 	}
 
+	if (p->regtype = SCIx_PROBE_REGTYPE) {
+		ret = sci_probe_regmap(p);
+		if (unlikely(ret))
+			return ret;
+	}
+
 	switch (p->type) {
 	case PORT_SCIFB:
 		port->fifosize = 256;
+		sci_port->overrun_bit = 9;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
+		sci_port->overrun_bit = 0;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
+		sci_port->overrun_bit = 9;
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
+		if (p->regtype = SCIx_SH7705_SCIF_REGTYPE)
+			sci_port->overrun_bit = 9;
+		else
+			sci_port->overrun_bit = 0;
 		break;
 	default:
 		port->fifosize = 1;
+		sci_port->overrun_bit = 5;
 		break;
 	}
 
-	if (p->regtype = SCIx_PROBE_REGTYPE) {
-		ret = sci_probe_regmap(p);
-		if (unlikely(ret))
-			return ret;
-	}
-
 	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
 		if (IS_ERR(sci_port->iclk)) {
@@ -2193,12 +2201,6 @@ static int sci_init_single(struct platform_device *dev,
 	 * Establish sensible defaults for the overrun detection, unless
 	 * the part has explicitly disabled support for it.
 	 */
-	if (p->type = PORT_SCI)
-		sci_port->overrun_bit = 5;
-	else if (p->scbrr_algo_id = SCBRR_ALGO_4)
-		sci_port->overrun_bit = 9;
-	else
-		sci_port->overrun_bit = 0;
 
 	/*
 	 * Make the error mask inclusive of overrun detection, if
-- 
1.8.3.2


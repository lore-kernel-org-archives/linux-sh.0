From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:38 +0000
Subject: [PATCH/RFC v2 07/29] serial: sh-sci: Use SCIF_DR instead of hardcoded 1
Message-Id: <1437070920-28069-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index afbfcab8f19a6b99..eae2989890337ee8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -960,7 +960,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		}
 		serial_port_out(port, SCSCR, scr);
 		/* Clear current interrupt */
-		serial_port_out(port, SCxSR, ssr & ~(1 | SCxSR_RDxF(port)));
+		serial_port_out(port, SCxSR,
+				ssr & ~(SCIF_DR | SCxSR_RDxF(port)));
 		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u jiffies\n",
 			jiffies, s->rx_timeout);
 		mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
-- 
1.9.1


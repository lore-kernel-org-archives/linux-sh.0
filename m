From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 01 Dec 2009 09:54:46 +0000
Subject: [PATCH] Fix too early disabling of the serial (SCI(F)) ports
Message-Id: <Pine.LNX.4.64.0912011045150.4701@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently serial ports on SH CPUs get disabled too early, because the 
sci_tx_empty() routine claims to not be able to detect whether the 
transmission has been completed and just always returns TIOCSER_TEMT. This 
results in corrupt output of last characters if the port is not open for 
reading at the same time. It is however possible to detect whether 
transmission has been completed. Use the TEND bit of the status register 
for this.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 85119fb..70a52a5 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -833,8 +833,8 @@ static void sci_free_irq(struct sci_port *port)
 
 static unsigned int sci_tx_empty(struct uart_port *port)
 {
-	/* Can't detect */
-	return TIOCSER_TEMT;
+	unsigned short status = sci_in(port, SCxSR);
+	return status & SCxSR_TEND(port) ? TIOCSER_TEMT : 0;
 }
 
 static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)

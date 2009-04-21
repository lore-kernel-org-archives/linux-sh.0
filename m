From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Tue, 21 Apr 2009 12:08:47 +0000
Subject: [RFC patch] sci_tx_empty for scif serial device
Message-Id: <20090421120846.GA26186@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the sci_tx_empty function for scif serial device.

Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
---
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index dbf5357..6cea2c4 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -794,6 +794,20 @@ static void sci_free_irq(struct sci_port *port)
 
 static unsigned int sci_tx_empty(struct uart_port *port)
 {
+	int txroom = SCIF_TXROOM_MAX;
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7763)
+	if (!(port->mapbase = 0xffe00000) &&
+	    !(port->mapbase = 0xffe08000)) {
+		txroom = SCIF2_TXROOM_MAX)
+	}
+#endif
+	if (port->type = PORT_SCIF) {
+		if (scif_txroom(port) = txroom)
+			return TIOCSER_TEMT;
+		return 0;
+	}
+
 	/* Can't detect */
 	return TIOCSER_TEMT;
 }

From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Jun 2011 09:47:01 +0000
Subject: [PATCH 01/03] serial: sh-sci: console Runtime PM prototype
Message-Id: <20110630094701.10442.45978.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Prototype code to add Runtime PM context save/restore for
the SCIF driver. Seems to work well, but needs to be reworked
to fit together with other driver changes.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/tty/serial/sh-sci.c |   70 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

--- 0001/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2011-06-30 16:25:04.000000000 +0900
@@ -103,6 +103,12 @@ struct sci_port {
 #endif
 
 	struct notifier_block		freq_transition;
+
+#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+	unsigned short saved_smr;
+	unsigned short saved_fcr;
+	unsigned char saved_brr;
+#endif
 };
 
 /* Function prototypes */
@@ -1491,11 +1497,25 @@ static unsigned int sci_scbrr_calc(unsig
 	return ((freq + 16 * bps) / (32 * bps) - 1);
 }
 
+static void sci_reset(struct uart_port *port)
+{
+	unsigned int status;
+
+	do {
+		status = sci_in(port, SCxSR);
+	} while (!(status & SCxSR_TEND(port)));
+
+	sci_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */
+
+	if (port->type != PORT_SCI)
+		sci_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
+}
+
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct sci_port *s = to_sci_port(port);
-	unsigned int status, baud, smr_val, max_baud;
+	unsigned int baud, smr_val, max_baud;
 	int t = -1;
 	u16 scfcr = 0;
 
@@ -1516,14 +1536,7 @@ static void sci_set_termios(struct uart_
 	if (s->enable)
 		s->enable(port);
 
-	do {
-		status = sci_in(port, SCxSR);
-	} while (!(status & SCxSR_TEND(port)));
-
-	sci_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */
-
-	if (port->type != PORT_SCI)
-		sci_out(port, SCFCR, scfcr | SCFCR_RFRST | SCFCR_TFRST);
+	sci_reset(port);
 
 	smr_val = sci_in(port, SCSMR) & 3;
 
@@ -1869,7 +1882,10 @@ static int __devinit serial_console_setu
 	if (ret = 0)
 		sci_stop_rx(port);
 #endif
-	/* TODO: disable clock */
+
+	if (sci_port->disable)
+		sci_port->disable(port);
+
 	return ret;
 }
 
@@ -1912,6 +1928,36 @@ static int __devinit sci_probe_earlyprin
 	return 0;
 }
 
+#define uart_console(port)	((port)->cons->index = (port)->line)
+
+static int sci_runtime_suspend(struct device *dev)
+{
+	struct sci_port *sci_port = dev_get_drvdata(dev);
+	struct uart_port *port = &sci_port->port;
+
+	if (uart_console(port)) {
+		sci_port->saved_smr = sci_in(port, SCSMR);
+		sci_port->saved_brr = sci_in(port, SCBRR);
+		sci_port->saved_fcr = sci_in(port, SCFCR);
+	}
+	return 0;
+}
+
+static int sci_runtime_resume(struct device *dev)
+{
+	struct sci_port *sci_port = dev_get_drvdata(dev);
+	struct uart_port *port = &sci_port->port;
+
+	if (uart_console(port)) {
+		sci_reset(port);
+		sci_out(port, SCSMR, sci_port->saved_smr);
+		sci_out(port, SCBRR, sci_port->saved_brr);
+		sci_out(port, SCFCR, sci_port->saved_fcr);
+		sci_out(port, SCSCR, sci_port->cfg->scscr);
+	}
+	return 0;
+}
+
 #define SCI_CONSOLE	(&serial_console)
 
 #else
@@ -1921,6 +1967,8 @@ static inline int __devinit sci_probe_ea
 }
 
 #define SCI_CONSOLE	NULL
+#define sci_runtime_suspend	NULL
+#define sci_runtime_resume	NULL
 
 #endif /* CONFIG_SERIAL_SH_SCI_CONSOLE */
 
@@ -2036,6 +2084,8 @@ static int sci_resume(struct device *dev
 }
 
 static const struct dev_pm_ops sci_dev_pm_ops = {
+	.runtime_suspend = sci_runtime_suspend,
+	.runtime_resume = sci_runtime_resume,
 	.suspend	= sci_suspend,
 	.resume		= sci_resume,
 };

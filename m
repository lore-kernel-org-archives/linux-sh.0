From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Feb 2009 06:57:12 +0000
Subject: [PATCH] sh-sci: console drainage
Message-Id: <20090224065712.31491.72199.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Modify the serial console code to wait for the transmit FIFO,
make sure all bits have been put on the wire before returning.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 This is the first step against clock framework integration,
 after all bits are sent we can disable the data clock.

 Also useful when debugging or shutting down a system.

 Tested with SCIF on sh7785lcr, not sure about SCI and SCIFA.

 drivers/serial/sh-sci.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-02-18 15:59:05.000000000 +0900
@@ -139,7 +139,7 @@ static void sci_poll_put_char(struct uar
 	} while (!(status & SCxSR_TDxE(port)));
 
 	sci_in(port, SCxSR);            /* Dummy read */
-	sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port));
+	sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 	sci_out(port, SCxTDR, c);
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
@@ -1095,6 +1095,7 @@ static void serial_console_write(struct 
 				 unsigned count)
 {
 	struct uart_port *port = &serial_console_port->port;
+	unsigned short bits;
 	int i;
 
 	for (i = 0; i < count; i++) {
@@ -1103,6 +1104,11 @@ static void serial_console_write(struct 
 
 		sci_poll_put_char(port, *s++);
 	}
+
+	/* wait until fifo is empty and last bit has been transmitted */
+	bits = SCxSR_TDxE(port) | SCxSR_TEND(port);
+	while ((sci_in(port, SCxSR) & bits) != bits)
+		cpu_relax();
 }
 
 static int __init serial_console_setup(struct console *co, char *options)

From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 12:05:11 +0000
Subject: [PATCH] sh: drain and wait for early printk
Message-Id: <20080423120511.3925.41405.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Drain by waiting for all characters to be sent, and make sure to
wait a little bit after setting up the baud rate.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/early_printk.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0007/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2008-04-22 18:03:46.000000000 +0900
@@ -143,6 +143,7 @@ static void scif_sercon_init(char *s)
 {
 	struct uart_port *port = &scif_port;
 	unsigned baud = DEFAULT_BAUD;
+	unsigned int status;
 	char *e;
 
 	if (*s = ',')
@@ -161,12 +162,17 @@ static void scif_sercon_init(char *s)
 			baud = DEFAULT_BAUD;
 	}
 
+	do {
+		status = sci_in(port, SCxSR);
+	} while (!(status & SCxSR_TEND(port)));
+
 	sci_out(port, SCSCR, 0);	 /* TE=0, RE=0 */
 	sci_out(port, SCSMR, 0);
 
 	/* Set baud rate */
 	sci_out(port, SCBRR, (CONFIG_SH_PCLK_FREQ + 16 * baud) /
 		(32 * baud) - 1);
+	udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
 
 	sci_out(port, SCFCR, 12);
 	sci_out(port, SCFCR, 8);

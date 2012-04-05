From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Apr 2012 09:34:00 +0000
Subject: [PATCH] serial: sh-sci: modify sci_break_ctl()
Message-Id: <4F7D6708.5060500@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIF modules which have SCSPTR can output the break signal.
This patch supports it.

This patch tested on sh7757lcr.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/tty/serial/sh-sci.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bf461cf..4f46532 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1567,10 +1567,32 @@ static void sci_enable_ms(struct uart_port *port)

 static void sci_break_ctl(struct uart_port *port, int break_state)
 {
-	/*
-	 * Not supported by hardware. Most parts couple break and rx
-	 * interrupts together, with break detection always enabled.
-	 */
+	struct sci_port *s = to_sci_port(port);
+	unsigned short scscr, scsptr;
+
+	switch (s->cfg->regtype) {
+	case SCIx_SH4_SCIF_REGTYPE:
+		scsptr = sci_in(port, SCSPTR);
+		scscr = sci_in(port, SCSCR);
+
+		if (break_state = -1) {
+			scsptr = (scsptr | SCSPTR_SPB2IO) & ~SCSPTR_SPB2DT;
+			scscr &= ~SCSCR_TE;
+		} else {
+			scsptr = (scsptr | SCSPTR_SPB2DT) & ~SCSPTR_SPB2IO;
+			scscr |= SCSCR_TE;
+		}
+
+		sci_out(port, SCSPTR, scsptr);
+		sci_out(port, SCSCR, scscr);
+		break;
+	default:
+		/*
+		 * Not supported by hardware. Most parts couple break and rx
+		 * interrupts together, with break detection always enabled.
+		 */
+		break;
+	}
 }

 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-- 
1.7.1

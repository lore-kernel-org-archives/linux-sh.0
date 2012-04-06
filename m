From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 06 Apr 2012 00:59:14 +0000
Subject: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <4F7E3FE2.4050902@renesas.com>
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
 about v2:
  - add serial_sci.h
  - change sci_in/sci_out to serial_port_in/serial_port_out

 drivers/tty/serial/sh-sci.c |   30 ++++++++++++++++++++++++++----
 include/linux/serial_sci.h  |    2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3158e17..3e471fc 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1564,10 +1564,32 @@ static void sci_enable_ms(struct uart_port *port)

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
+		scsptr = serial_port_in(port, SCSPTR);
+		scscr = serial_port_in(port, SCSCR);
+
+		if (break_state = -1) {
+			scsptr = (scsptr | SCSPTR_SPB2IO) & ~SCSPTR_SPB2DT;
+			scscr &= ~SCSCR_TE;
+		} else {
+			scsptr = (scsptr | SCSPTR_SPB2DT) & ~SCSPTR_SPB2IO;
+			scscr |= SCSCR_TE;
+		}
+
+		serial_port_out(port, SCSPTR, scsptr);
+		serial_port_out(port, SCSCR, scscr);
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
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 7877907..eb763ad 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -52,6 +52,8 @@ enum {
 /* SCSPTR, optional */
 #define SCSPTR_RTSIO	(1 << 7)
 #define SCSPTR_CTSIO	(1 << 5)
+#define SCSPTR_SPB2IO	(1 << 1)
+#define SCSPTR_SPB2DT	(1 << 0)

 /* Offsets into the sci_port->irqs array */
 enum {
-- 
1.7.1

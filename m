From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 11 Nov 2008 03:19:05 +0000
Subject: [PATCH] serial: sh-sci: fix cannot work SH7723 SCIFA
Message-Id: <4918F9A9.9020704@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7723 has SCIFA. This module is similer SCI register map, but it has FIFO.
So this patch adds new type(PORT_SCIFA) and change some type checking.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/serial/sh-sci.c     |   20 +++++++++++---------
 drivers/serial/sh-sci.h     |   16 ++++++++--------
 include/linux/serial_core.h |    3 +++
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 5c0f32c..518c032 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -478,10 +478,10 @@ static void sci_transmit_chars(struct uart_port *port)
 		return;
 	}

-	if (port->type = PORT_SCIF)
-		count = scif_txroom(port);
-	else
+	if (port->type = PORT_SCI)
 		count = sci_txroom(port);
+	else
+		count = scif_txroom(port);

 	do {
 		unsigned char c;
@@ -510,7 +510,7 @@ static void sci_transmit_chars(struct uart_port *port)
 	} else {
 		ctrl = sci_in(port, SCSCR);

-		if (port->type = PORT_SCIF) {
+		if (port->type != PORT_SCI) {
 			sci_in(port, SCxSR); /* Dummy read */
 			sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port));
 		}
@@ -536,10 +536,10 @@ static inline void sci_receive_chars(struct uart_port *port)
 		return;

 	while (1) {
-		if (port->type = PORT_SCIF)
-			count = scif_rxroom(port);
-		else
+		if (port->type = PORT_SCI)
 			count = sci_rxroom(port);
+		else
+			count = scif_rxroom(port);

 		/* Don't copy more bytes than there is room for in the buffer */
 		count = tty_buffer_request_room(tty, count);
@@ -714,7 +714,7 @@ static inline int sci_handle_breaks(struct uart_port *port)

 #if defined(SCIF_ORER)
 	/* XXX: Handle SCIF overrun error */
-	if (port->type = PORT_SCIF && (sci_in(port, SCLSR) & SCIF_ORER) != 0) {
+	if (port->type != PORT_SCI && (sci_in(port, SCLSR) & SCIF_ORER) != 0) {
 		sci_out(port, SCLSR, 0);
 		if (tty_insert_flip_char(tty, 0, TTY_OVERRUN)) {
 			copied++;
@@ -1042,7 +1042,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,

 	sci_out(port, SCSCR, 0x00);	/* TE=0, RE=0, CKE1=0 */

-	if (port->type = PORT_SCIF)
+	if (port->type != PORT_SCI)
 		sci_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);

 	smr_val = sci_in(port, SCSMR) & 3;
@@ -1085,6 +1085,7 @@ static const char *sci_type(struct uart_port *port)
 		case PORT_SCI:	return "sci";
 		case PORT_SCIF:	return "scif";
 		case PORT_IRDA: return "irda";
+		case PORT_SCIFA:	return "scifa";
 	}

 	return NULL;
@@ -1112,6 +1113,7 @@ static void sci_config_port(struct uart_port *port, int flags)
 		s->init_pins = sci_init_pins_sci;
 		break;
 	case PORT_SCIF:
+	case PORT_SCIFA:
 		s->init_pins = sci_init_pins_scif;
 		break;
 	case PORT_IRDA:
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 6163a45..9f33b06 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -289,18 +289,18 @@
 #define CPU_SCIx_FNS(name, sci_offset, sci_size, scif_offset, scif_size)\
   static inline unsigned int sci_##name##_in(struct uart_port *port)	\
   {									\
-    if (port->type = PORT_SCI) {					\
-      SCI_IN(sci_size, sci_offset)					\
-    } else {								\
-      SCI_IN(scif_size, scif_offset);					\
+    if (port->type = PORT_SCIF) {					\
+      SCI_IN(scif_size, scif_offset)					\
+    } else {	/* PORT_SCI or PORT_SCIFA */				\
+      SCI_IN(sci_size, sci_offset);					\
     }									\
   }									\
   static inline void sci_##name##_out(struct uart_port *port, unsigned int value) \
   {									\
-    if (port->type = PORT_SCI) {					\
-      SCI_OUT(sci_size, sci_offset, value)				\
-    } else {								\
-      SCI_OUT(scif_size, scif_offset, value);				\
+    if (port->type = PORT_SCIF) {					\
+      SCI_OUT(scif_size, scif_offset, value)				\
+    } else {	/* PORT_SCI or PORT_SCIFA */				\
+      SCI_OUT(sci_size, sci_offset, value);				\
     }									\
   }

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e27f216..4e4f127 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -155,6 +155,9 @@

 #define PORT_SC26XX	82

+/* SH-SCI */
+#define PORT_SCIFA	83
+
 #ifdef __KERNEL__

 #include <linux/compiler.h>
-- 
1.5.5


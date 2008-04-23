From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 12:25:29 +0000
Subject: [PATCH] sh-sci: improve sh7722 support
Message-Id: <20080423122529.7684.6459.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Improve sh7722 support for SCIF1 and SCIF2 and separate code
from sh7366 implementation.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c |   22 ++++++++++------------
 drivers/serial/sh-sci.h |   21 +++++++++++++++++----
 2 files changed, 27 insertions(+), 16 deletions(-)

--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2008-04-22 18:13:34.000000000 +0900
@@ -365,21 +365,19 @@ static void sci_init_pins_scif(struct ua
 static void sci_init_pins_scif(struct uart_port *port, unsigned int cflag)
 {
 	unsigned int fcr_val = 0;
+	unsigned short data;
 
-	if (cflag & CRTSCTS) {
-		fcr_val |= SCFCR_MCE;
-
-		ctrl_outw(0x0000, PORT_PSCR);
-	} else {
-		unsigned short data;
-
-		data = ctrl_inw(PORT_PSCR);
-		data &= 0x033f;
-		data |= 0x0400;
-		ctrl_outw(data, PORT_PSCR);
+	if (port->mapbase = 0xffe00000) {
+		data = ctrl_inw(PSCR);
+		data &= ~0x03cf;
+		if (cflag & CRTSCTS)
+			fcr_val |= SCFCR_MCE;
+		else
+			data |= 0x0340;
 
-		ctrl_outw(ctrl_inw(SCSPTR0) & 0x17, SCSPTR0);
+		ctrl_outw(data, PSCR);
 	}
+	/* SCIF1 and SCIF2 should be setup by board code */
 
 	sci_out(port, SCFCR, fcr_val);
 }
--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2008-04-22 18:13:34.000000000 +0900
@@ -76,12 +76,13 @@
 # define SCSCR_INIT(port) 0x32	/* TIE=0,RIE=0,TE=1,RE=1,REIE=0,CKE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7722)
-# define SCPDR0			0xA405013E	/* 16 bit SCIF0 PSDR */
-# define SCSPTR0		SCPDR0
+# define PADR			0xA4050120
+# define PSDR			0xA405013e
+# define PWDR			0xA4050166
+# define PSCR			0xA405011E
 # define SCIF_ORER		0x0001	/* overrun error bit */
 # define SCSCR_INIT(port)	0x0038	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 # define SCIF_ONLY
-# define PORT_PSCR		0xA405011E
 #elif defined(CONFIG_CPU_SUBTYPE_SH7366)
 # define SCPDR0			0xA405013E      /* 16 bit SCIF0 PSDR */
 # define SCSPTR0		SCPDR0
@@ -593,13 +594,25 @@ static inline int sci_rxd_in(struct uart
 		return ctrl_inw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
 	return 1;
 }
-#elif defined(CONFIG_CPU_SUBTYPE_SH7722) || defined(CONFIG_CPU_SUBTYPE_SH7366)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7366)
 static inline int sci_rxd_in(struct uart_port *port)
 {
 	if (port->mapbase = 0xffe00000)
 		return ctrl_inb(SCPDR0) & 0x0001 ? 1 : 0; /* SCIF0 */
 	return 1;
 }
+#elif defined(CONFIG_CPU_SUBTYPE_SH7722)
+static inline int sci_rxd_in(struct uart_port *port)
+{
+	if (port->mapbase = 0xffe00000)
+		return ctrl_inb(PSDR) & 0x02 ? 1 : 0; /* SCIF0 */
+	if (port->mapbase = 0xffe10000)
+		return ctrl_inb(PADR) & 0x40 ? 1 : 0; /* SCIF1 */
+	if (port->mapbase = 0xffe20000)
+		return ctrl_inb(PWDR) & 0x04 ? 1 : 0; /* SCIF2 */
+
+	return 1;
+}
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
 static inline int sci_rxd_in(struct uart_port *port)
 {

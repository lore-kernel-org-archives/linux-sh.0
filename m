From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 20 Feb 2009 07:43:49 +0000
Subject: [PATCH 5/6] sh-sci: Add SH7786 support
Message-Id: <ufxi5d2h0.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/serial/sh-sci.c |    4 +++-
 drivers/serial/sh-sci.h |   13 +++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 557b54a..7ec5f99 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -263,6 +263,7 @@ static inline void sci_init_pins(struct uart_port *port, unsigned int cflag)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
       defined(CONFIG_CPU_SUBTYPE_SH7780) || \
       defined(CONFIG_CPU_SUBTYPE_SH7785) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7786) || \
       defined(CONFIG_CPU_SUBTYPE_SHX3)
 static inline void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {
@@ -284,7 +285,8 @@ static inline void sci_init_pins(struct uart_port *port, unsigned int cflag)
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7760) || \
     defined(CONFIG_CPU_SUBTYPE_SH7780) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7785)
+    defined(CONFIG_CPU_SUBTYPE_SH7785) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7786)
 static inline int scif_txroom(struct uart_port *port)
 {
 	return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index bb9fe12..d0aa82d 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -126,7 +126,8 @@
 # define SCSPTR1	0xffe10024	/* 16 bit SCIF */
 # define SCIF_ORER	0x0001		/* Overrun error bit */
 # define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
-#elif defined(CONFIG_CPU_SUBTYPE_SH7785)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7785) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7786)
 # define SCSPTR0	0xffea0024	/* 16 bit SCIF */
 # define SCSPTR1	0xffeb0024	/* 16 bit SCIF */
 # define SCSPTR2	0xffec0024	/* 16 bit SCIF */
@@ -182,6 +183,7 @@
     defined(CONFIG_CPU_SUBTYPE_SH7763)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7780)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7785)  || \
+    defined(CONFIG_CPU_SUBTYPE_SH7786)  || \
     defined(CONFIG_CPU_SUBTYPE_SHX3)
 #define SCI_CTRL_FLAGS_REIE 0x08 /* 7750 SCIF */
 #else
@@ -413,7 +415,8 @@ SCIx_FNS(SCxRDR, 0x0a,  8, 0x14,  8, 0x0A,  8, 0x14,  8, 0x05,  8)
 SCIF_FNS(SCFCR,                      0x0c,  8, 0x18, 16)
 #if defined(CONFIG_CPU_SUBTYPE_SH7760) || \
     defined(CONFIG_CPU_SUBTYPE_SH7780) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7785)
+    defined(CONFIG_CPU_SUBTYPE_SH7785) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7786)
 SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
@@ -644,7 +647,8 @@ static inline int sci_rxd_in(struct uart_port *port)
 		return ctrl_inw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
 	return 1;
 }
-#elif defined(CONFIG_CPU_SUBTYPE_SH7785)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7785) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7786)
 static inline int sci_rxd_in(struct uart_port *port)
 {
 	if (port->mapbase = 0xffea0000)
@@ -746,7 +750,8 @@ static inline int sci_rxd_in(struct uart_port *port)
  */
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7780) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7785)
+    defined(CONFIG_CPU_SUBTYPE_SH7785) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7786)
 #define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-- 
1.5.6.3


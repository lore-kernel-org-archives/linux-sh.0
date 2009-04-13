From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 13 Apr 2009 04:27:19 +0000
Subject: [PATCH 2/6] sh-sci: Add SH7724 support
Message-Id: <u1vrv38wf.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 drivers/serial/sh-sci.h |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 5215b9d..c203d1f 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -91,6 +91,9 @@
 # define SCSPTR5                0xa4050128
 # define SCIF_ORER              0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)       0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
+# define SCIF_ORER              0x0001  /* overrun error bit */
+# define SCSCR_INIT(port)       0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
 # define SCSPTR2 0xffe80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
@@ -361,7 +364,8 @@
                  h8_sci_offset, h8_sci_size) \
   CPU_SCI_FNS(name, h8_sci_offset, h8_sci_size)
 #define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size, sh4_scif_offset, sh4_scif_size)
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
+      defined(CONFIG_CPU_SUBTYPE_SH7724)
         #define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scif_offset, sh4_scif_size) \
                 CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scif_offset, sh4_scif_size)
         #define SCIF_FNS(name, sh4_scif_offset, sh4_scif_size) \
@@ -390,7 +394,8 @@ SCIF_FNS(SCFDR,  0x1c, 16)
 SCIF_FNS(SCxTDR, 0x20,  8)
 SCIF_FNS(SCxRDR, 0x24,  8)
 SCIF_FNS(SCLSR,  0x24, 16)
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
+      defined(CONFIG_CPU_SUBTYPE_SH7724)
 SCIx_FNS(SCSMR,  0x00, 16, 0x00, 16)
 SCIx_FNS(SCBRR,  0x04,  8, 0x04,  8)
 SCIx_FNS(SCSCR,  0x08, 16, 0x08, 16)
@@ -604,6 +609,17 @@ static inline int sci_rxd_in(struct uart_port *port)
                 return ctrl_inb(SCSPTR5) & 0x0008 ? 1 : 0; /* SCIF5 */
         return 1;
 }
+#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
+#  define SCFSR    0x0010
+#  define SCASSR   0x0014
+static inline int sci_rxd_in(struct uart_port *port)
+{
+	if (port->type = PORT_SCIF)
+		return ctrl_inw((port->mapbase + SCFSR))  & SCIF_BRK ? 1 : 0;
+	if (port->type = PORT_SCIFA)
+		return ctrl_inw((port->mapbase + SCASSR)) & SCIF_BRK ? 1 : 0;
+	return 1;
+}
 #elif defined(CONFIG_CPU_SUBTYPE_SH5_101) || defined(CONFIG_CPU_SUBTYPE_SH5_103)
 static inline int sci_rxd_in(struct uart_port *port)
 {
@@ -757,7 +773,8 @@ static inline int sci_rxd_in(struct uart_port *port)
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721)
 #define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
+      defined(CONFIG_CPU_SUBTYPE_SH7724)
 static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 {
 	if (port->type = PORT_SCIF)
-- 
1.5.6.3


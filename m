From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 06 Jun 2008 07:11:59 +0000
Subject: sh: Add supoprt SCIF2 of SH7763
Message-Id: <4848E33F.2070700@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7763 has 3 SCIF device. Current code supports SCIF0 and 1.
SCIF0 and 1 are same register constitution, but only SCIF2 is different.
I added support of SCIF2.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   10 ++++++-
 drivers/serial/sh-sci.c                |   17 +++++++++++++-
 drivers/serial/sh-sci.h                |   38 ++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index f189a55..3b278df 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2007  Yoshihiro Shimoda
+ *  Copyright (C) 2008  Nobuhiro Iwamatsu
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -56,6 +57,11 @@ static struct plat_sci_port sci_platform_data[] = {
 		.type		= PORT_SCIF,
 		.irqs		= { 76, 77, 79, 78 },
 	}, {
+		.mapbase	= 0xffe10000,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.type		= PORT_SCIF,
+		.irqs		= { 104, 105, 107, 106 },
+	}, {
 		.flags = 0,
 	}
 };
@@ -208,8 +214,8 @@ static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(TMU5, 0xe40), INTC_VECT(ADC, 0xe60),
 	INTC_VECT(SSI0, 0xe80), INTC_VECT(SSI1, 0xea0),
 	INTC_VECT(SSI2, 0xec0), INTC_VECT(SSI3, 0xee0),
-	INTC_VECT(SCIF1_ERI, 0xf00), INTC_VECT(SCIF1_RXI, 0xf20),
-	INTC_VECT(SCIF1_BRI, 0xf40), INTC_VECT(SCIF1_TXI, 0xf60),
+	INTC_VECT(SCIF2_ERI, 0xf00), INTC_VECT(SCIF2_RXI, 0xf20),
+	INTC_VECT(SCIF2_BRI, 0xf40), INTC_VECT(SCIF2_TXI, 0xf60),
 	INTC_VECT(GPIO_CH0, 0xf80), INTC_VECT(GPIO_CH1, 0xfa0),
 	INTC_VECT(GPIO_CH2, 0xfc0), INTC_VECT(GPIO_CH3, 0xfe0),
 };
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index ce6ee92..f3c3071 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -410,7 +410,6 @@ static void sci_init_pins_scif(struct uart_port *port, unsigned int cflag)
 #endif

 #if defined(CONFIG_CPU_SUBTYPE_SH7760) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7763) || \
     defined(CONFIG_CPU_SUBTYPE_SH7780) || \
     defined(CONFIG_CPU_SUBTYPE_SH7785)
 static inline int scif_txroom(struct uart_port *port)
@@ -422,6 +421,22 @@ static inline int scif_rxroom(struct uart_port *port)
 {
 	return sci_in(port, SCRFDR) & 0xff;
 }
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
+static inline int scif_txroom(struct uart_port *port)
+{
+	if((port->mapbase = 0xffe00000) || (port->mapbase = 0xffe08000)) /* SCIF0/1*/
+		return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
+	else /* SCIF2 */
+		return SCIF2_TXROOM_MAX - (sci_in(port, SCFDR) >> 8);
+}
+
+static inline int scif_rxroom(struct uart_port *port)
+{
+	if((port->mapbase = 0xffe00000) || (port->mapbase = 0xffe08000)) /* SCIF0/1*/
+		return sci_in(port, SCRFDR) & 0xff;
+	else /* SCIF2 */
+		return sci_in(port, SCFDR) & SCIF2_RFDC_MASK;
+}
 #else
 static inline int scif_txroom(struct uart_port *port)
 {
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index eb84833..cd728df 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -123,8 +123,9 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763)
 # define SCSPTR0 0xffe00024 /* 16 bit SCIF */
 # define SCSPTR1 0xffe08024 /* 16 bit SCIF */
+# define SCSPTR2 0xffe10020 /* 16 bit SCIF/IRDA */
 # define SCIF_ORER 0x0001  /* overrun error bit */
-# define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
+# define SCSCR_INIT(port)	0x38	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 # define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7770)
 # define SCSPTR0 0xff923020 /* 16 bit SCIF */
@@ -188,6 +189,7 @@
     defined(CONFIG_CPU_SUBTYPE_SH7750S) || \
     defined(CONFIG_CPU_SUBTYPE_SH7751)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7751R) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7763)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7780)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7785)  || \
     defined(CONFIG_CPU_SUBTYPE_SHX3)
@@ -225,14 +227,21 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721)
-#define SCIF_ORER    0x0200
-#define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK | SCIF_ORER)
-#define SCIF_RFDC_MASK 0x007f
-#define SCIF_TXROOM_MAX 64
+# define SCIF_ORER    0x0200
+# define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK | SCIF_ORER)
+# define SCIF_RFDC_MASK 0x007f
+# define SCIF_TXROOM_MAX 64
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
+# define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK )
+# define SCIF_RFDC_MASK 0x007f
+# define SCIF_TXROOM_MAX 64
+/* SH7763 SCIF2 support */
+# define SCIF2_RFDC_MASK 0x001f
+# define SCIF2_TXROOM_MAX 16
 #else
-#define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK)
-#define SCIF_RFDC_MASK 0x001f
-#define SCIF_TXROOM_MAX 16
+# define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK)
+# define SCIF_RFDC_MASK 0x001f
+# define SCIF_TXROOM_MAX 16
 #endif

 #if defined(SCI_ONLY)
@@ -445,11 +454,16 @@ SCIF_FNS(SCFCR,                      0x0c,  8, 0x18, 16)
     defined(CONFIG_CPU_SUBTYPE_SH7763) || \
     defined(CONFIG_CPU_SUBTYPE_SH7780) || \
     defined(CONFIG_CPU_SUBTYPE_SH7785)
-SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
 SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
 SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
+#if defined(CONFIG_CPU_SUBTYPE_SH7763)
+/* SH7763 SCIF2 */
+SCIF_FNS(SCFDR,				0,  0, 0x1C, 16)
+SCIF_FNS(SCSPTR2,			0,  0, 0x20, 16)
+SCIF_FNS(SCLSR2, 			0,  0, 0x24, 16)
+#endif /* CONFIG_CPU_SUBTYPE_SH7763 */
 #else
 SCIF_FNS(SCFDR,                      0x0e, 16, 0x1C, 16)
 #if defined(CONFIG_CPU_SUBTYPE_SH7722)
@@ -652,6 +666,9 @@ static inline int sci_rxd_in(struct uart_port *port)
 		return ctrl_inw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
 	if (port->mapbase = 0xffe08000)
 		return ctrl_inw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
+	if (port->mapbase = 0xffe10000)
+		return ctrl_inw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF/IRDA */
+
 	return 1;
 }
 #elif defined(CONFIG_CPU_SUBTYPE_SH7770)
@@ -764,8 +781,7 @@ static inline int sci_rxd_in(struct uart_port *port)
  * -- Mitch Davis - 15 Jul 2000
  */

-#if defined(CONFIG_CPU_SUBTYPE_SH7763) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7780) || \
+#if defined(CONFIG_CPU_SUBTYPE_SH7780) || \
     defined(CONFIG_CPU_SUBTYPE_SH7785)
 #define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
-- 
1.5.5.1


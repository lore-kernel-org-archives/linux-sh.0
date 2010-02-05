From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Feb 2010 10:41:00 +0000
Subject: [PATCH] sh-sci: remove SCIF code in sci_rxd_in()
Message-Id: <20100205104100.16820.16353.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Since sci_rxd_in() is used by SCI only, clean up
the header file by killing off code dealing with
SCIF ports and their register definitions.

Also introduce a default sci_rxd_in() function
which can be shared by all SCIF-only processors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Only tested on Ecovec sh7724.

 drivers/serial/sh-sci.h |  290 -----------------------------------------------
 1 file changed, 5 insertions(+), 285 deletions(-)

--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2010-02-05 16:02:19.000000000 +0900
@@ -32,14 +32,7 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721)
 # define SCSCR_INIT(port)  0x0030 /* TIE=0,RIE=0,TE=1,RE=1 */
-# define PORT_PTCR	   0xA405011EUL
-# define PORT_PVCR	   0xA4050122UL
 # define SCIF_ORER	   0x0200   /* overrun error bit */
-#elif defined(CONFIG_SH_RTS7751R2D)
-# define SCSPTR1 0xFFE0001C /* 8 bit SCIF */
-# define SCSPTR2 0xFFE80020 /* 16 bit SCIF */
-# define SCIF_ORER 0x0001   /* overrun error bit */
-# define SCSCR_INIT(port) 0x3a /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7750)  || \
       defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
       defined(CONFIG_CPU_SUBTYPE_SH7750S) || \
@@ -47,55 +40,35 @@
       defined(CONFIG_CPU_SUBTYPE_SH7751)  || \
       defined(CONFIG_CPU_SUBTYPE_SH7751R)
 # define SCSPTR1 0xffe0001c /* 8  bit SCI */
-# define SCSPTR2 0xFFE80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
+#if defined(CONFIG_SH_RTS7751R2D)
+# define SCSCR_INIT(port) 0x3a /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
+#else
 # define SCSCR_INIT(port) (((port)->type = PORT_SCI) ? \
 	0x30 /* TIE=0,RIE=0,TE=1,RE=1 */ : \
 	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */ )
+#endif
 #elif defined(CONFIG_CPU_SUBTYPE_SH7760)
-# define SCSPTR0 0xfe600024 /* 16 bit SCIF */
-# define SCSPTR1 0xfe610024 /* 16 bit SCIF */
-# define SCSPTR2 0xfe620024 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)          0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7710) || defined(CONFIG_CPU_SUBTYPE_SH7712)
-# define SCSPTR0 0xA4400000	  /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
-# define PACR 0xa4050100
-# define PBCR 0xa4050102
 # define SCSCR_INIT(port)          0x3B
 #elif defined(CONFIG_CPU_SUBTYPE_SH7343)
-# define SCSPTR0 0xffe00010	/* 16 bit SCIF */
-# define SCSPTR1 0xffe10010	/* 16 bit SCIF */
-# define SCSPTR2 0xffe20010	/* 16 bit SCIF */
-# define SCSPTR3 0xffe30010	/* 16 bit SCIF */
 # define SCSCR_INIT(port) 0x32	/* TIE=0,RIE=0,TE=1,RE=1,REIE=0,CKE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7722)
-# define PADR			0xA4050120
-# define PSDR			0xA405013e
-# define PWDR			0xA4050166
-# define PSCR			0xA405011E
 # define SCIF_ORER		0x0001	/* overrun error bit */
 # define SCSCR_INIT(port)	0x0038	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7366)
-# define SCPDR0			0xA405013E      /* 16 bit SCIF0 PSDR */
-# define SCSPTR0		SCPDR0
 # define SCIF_ORER		0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)	0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
-# define SCSPTR0                0xa4050160
-# define SCSPTR1                0xa405013e
-# define SCSPTR2                0xa4050160
-# define SCSPTR3                0xa405013e
-# define SCSPTR4                0xa4050128
-# define SCSPTR5                0xa4050128
 # define SCIF_ORER              0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)       0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7724)
 # define SCIF_ORER              0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)       0x0038  /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
-# define SCSPTR2 0xffe80020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001   /* overrun error bit */
 # define SCSCR_INIT(port) 0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH5_101) || defined(CONFIG_CPU_SUBTYPE_SH5_103)
@@ -113,65 +86,30 @@
 # define SCSCR_INIT(port)          0x30 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define H8300_SCI_DR(ch) *(volatile char *)(P1DR + h8300_sci_pins[ch].port)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7757)
-# define SCSPTR0 0xfe4b0020
-# define SCSPTR1 0xfe4b0020
-# define SCSPTR2 0xfe4b0020
 # define SCIF_ORER 0x0001
 # define SCSCR_INIT(port)	0x38
-# define SCIF_ONLY
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763)
-# define SCSPTR0 0xffe00024 /* 16 bit SCIF */
-# define SCSPTR1 0xffe08024 /* 16 bit SCIF */
-# define SCSPTR2 0xffe10020 /* 16 bit SCIF/IRDA */
 # define SCIF_ORER 0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)	0x38	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7770)
-# define SCSPTR0 0xff923020 /* 16 bit SCIF */
-# define SCSPTR1 0xff924020 /* 16 bit SCIF */
-# define SCSPTR2 0xff925020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)	0x3c /* TIE=0,RIE=0,TE=1,RE=1,REIE=1,cke=2 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7780)
-# define SCSPTR0	0xffe00024	/* 16 bit SCIF */
-# define SCSPTR1	0xffe10024	/* 16 bit SCIF */
 # define SCIF_ORER	0x0001		/* Overrun error bit */
 # define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7785) || \
       defined(CONFIG_CPU_SUBTYPE_SH7786)
-# define SCSPTR0	0xffea0024	/* 16 bit SCIF */
-# define SCSPTR1	0xffeb0024	/* 16 bit SCIF */
-# define SCSPTR2	0xffec0024	/* 16 bit SCIF */
-# define SCSPTR3	0xffed0024	/* 16 bit SCIF */
-# define SCSPTR4	0xffee0024	/* 16 bit SCIF */
-# define SCSPTR5	0xffef0024	/* 16 bit SCIF */
 # define SCIF_ORER	0x0001		/* Overrun error bit */
 # define SCSCR_INIT(port)	0x3a	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7201) || \
       defined(CONFIG_CPU_SUBTYPE_SH7203) || \
       defined(CONFIG_CPU_SUBTYPE_SH7206) || \
       defined(CONFIG_CPU_SUBTYPE_SH7263)
-# define SCSPTR0 0xfffe8020 /* 16 bit SCIF */
-# define SCSPTR1 0xfffe8820 /* 16 bit SCIF */
-# define SCSPTR2 0xfffe9020 /* 16 bit SCIF */
-# define SCSPTR3 0xfffe9820 /* 16 bit SCIF */
-# if defined(CONFIG_CPU_SUBTYPE_SH7201)
-#  define SCSPTR4 0xfffeA020 /* 16 bit SCIF */
-#  define SCSPTR5 0xfffeA820 /* 16 bit SCIF */
-#  define SCSPTR6 0xfffeB020 /* 16 bit SCIF */
-#  define SCSPTR7 0xfffeB820 /* 16 bit SCIF */
-# endif
 # define SCSCR_INIT(port)	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7619)
-# define SCSPTR0 0xf8400020 /* 16 bit SCIF */
-# define SCSPTR1 0xf8410020 /* 16 bit SCIF */
-# define SCSPTR2 0xf8420020 /* 16 bit SCIF */
 # define SCIF_ORER 0x0001  /* overrun error bit */
 # define SCSCR_INIT(port)	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #elif defined(CONFIG_CPU_SUBTYPE_SHX3)
-# define SCSPTR0 0xffc30020		/* 16 bit SCIF */
-# define SCSPTR1 0xffc40020		/* 16 bit SCIF */
-# define SCSPTR2 0xffc50020		/* 16 bit SCIF */
-# define SCSPTR3 0xffc60020		/* 16 bit SCIF */
 # define SCIF_ORER 0x0001		/* Overrun error bit */
 # define SCSCR_INIT(port)	0x38	/* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 #else
@@ -518,34 +456,6 @@ static inline int sci_rxd_in(struct uart
 {
 	if (port->mapbase = 0xfffffe80)
 		return __raw_readb(SCPDR)&0x01 ? 1 : 0; /* SCI */
-	if (port->mapbase = 0xa4000150)
-		return __raw_readb(SCPDR)&0x10 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xa4000140)
-		return __raw_readb(SCPDR)&0x04 ? 1 : 0; /* IRDA */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7705)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = SCIF0)
-		return __raw_readb(SCPDR)&0x04 ? 1 : 0; /* IRDA */
-	if (port->mapbase = SCIF2)
-		return __raw_readb(SCPDR)&0x10 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7710) || defined(CONFIG_CPU_SUBTYPE_SH7712)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	  return sci_in(port,SCxSR)&0x0010 ? 1 : 0;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7721)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xa4430000)
-		return sci_in(port, SCxSR) & 0x0003 ? 1 : 0;
-	else if (port->mapbase = 0xa4438000)
-		return sci_in(port, SCxSR) & 0x0003 ? 1 : 0;
 	return 1;
 }
 #elif defined(CONFIG_CPU_SUBTYPE_SH7750)  || \
@@ -558,207 +468,17 @@ static inline int sci_rxd_in(struct uart
 {
 	if (port->mapbase = 0xffe00000)
 		return __raw_readb(SCSPTR1)&0x01 ? 1 : 0; /* SCI */
-	if (port->mapbase = 0xffe80000)
-		return __raw_readw(SCSPTR2)&0x0001 ? 1 : 0; /* SCIF */
 	return 1;
 }
-#elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffe80000)
-		return __raw_readw(SCSPTR2)&0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7757)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xfe4b0000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0;
-	if (port->mapbase = 0xfe4c0000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0;
-	if (port->mapbase = 0xfe4d0000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7760)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xfe600000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfe610000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfe620000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7343)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffe00000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffe10000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffe20000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffe30000)
-		return __raw_readw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7366)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffe00000)
-		return __raw_readb(SCPDR0) & 0x0001 ? 1 : 0; /* SCIF0 */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7722)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffe00000)
-		return __raw_readb(PSDR) & 0x02 ? 1 : 0; /* SCIF0 */
-	if (port->mapbase = 0xffe10000)
-		return __raw_readb(PADR) & 0x40 ? 1 : 0; /* SCIF1 */
-	if (port->mapbase = 0xffe20000)
-		return __raw_readb(PWDR) & 0x04 ? 1 : 0; /* SCIF2 */
-
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-        if (port->mapbase = 0xffe00000)
-                return __raw_readb(SCSPTR0) & 0x0008 ? 1 : 0; /* SCIF0 */
-        if (port->mapbase = 0xffe10000)
-                return __raw_readb(SCSPTR1) & 0x0020 ? 1 : 0; /* SCIF1 */
-        if (port->mapbase = 0xffe20000)
-                return __raw_readb(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF2 */
-        if (port->mapbase = 0xa4e30000)
-                return __raw_readb(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF3 */
-        if (port->mapbase = 0xa4e40000)
-                return __raw_readb(SCSPTR4) & 0x0001 ? 1 : 0; /* SCIF4 */
-        if (port->mapbase = 0xa4e50000)
-                return __raw_readb(SCSPTR5) & 0x0008 ? 1 : 0; /* SCIF5 */
-        return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
-#  define SCFSR    0x0010
-#  define SCASSR   0x0014
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->type = PORT_SCIF)
-		return __raw_readw((port->mapbase + SCFSR))  & SCIF_BRK ? 1 : 0;
-	if (port->type = PORT_SCIFA)
-		return __raw_readw((port->mapbase + SCASSR)) & SCIF_BRK ? 1 : 0;
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH5_101) || defined(CONFIG_CPU_SUBTYPE_SH5_103)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-         return sci_in(port, SCSPTR)&0x0001 ? 1 : 0; /* SCIF */
-}
 #elif defined(__H8300H__) || defined(__H8300S__)
 static inline int sci_rxd_in(struct uart_port *port)
 {
 	int ch = (port->mapbase - SMR0) >> 3;
 	return (H8300_SCI_DR(ch) & h8300_sci_pins[ch].rx) ? 1 : 0;
 }
-#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffe00000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffe08000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffe10000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF/IRDA */
-
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7770)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xff923000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xff924000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xff925000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffe00000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffe10000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7785) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7786)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xffea0000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffeb0000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffec0000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffed0000)
-		return __raw_readw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffee0000)
-		return __raw_readw(SCSPTR4) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffef0000)
-		return __raw_readw(SCSPTR5) & 0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7201) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7203) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7206) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7263)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xfffe8000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfffe8800)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfffe9000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfffe9800)
-		return __raw_readw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
-#if defined(CONFIG_CPU_SUBTYPE_SH7201)
-	if (port->mapbase = 0xfffeA000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfffeA800)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfffeB000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xfffeB800)
-		return __raw_readw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
-#endif
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SH7619)
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	if (port->mapbase = 0xf8400000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xf8410000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xf8420000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	return 1;
-}
-#elif defined(CONFIG_CPU_SUBTYPE_SHX3)
+#else /* default case for non-SCI processors */
 static inline int sci_rxd_in(struct uart_port *port)
 {
-	if (port->mapbase = 0xffc30000)
-		return __raw_readw(SCSPTR0) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffc40000)
-		return __raw_readw(SCSPTR1) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffc50000)
-		return __raw_readw(SCSPTR2) & 0x0001 ? 1 : 0; /* SCIF */
-	if (port->mapbase = 0xffc60000)
-		return __raw_readw(SCSPTR3) & 0x0001 ? 1 : 0; /* SCIF */
 	return 1;
 }
 #endif

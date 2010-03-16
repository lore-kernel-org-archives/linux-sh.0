From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Mar 2010 11:21:07 +0000
Subject: [PATCH] serial: sh-sci: fix SH-Mobile SH breakage
Message-Id: <20100316112107.25732.49922.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The follwing commit breaks SH-Mobile on non-ARM platforms:
"8a77b8d serial: sh-sci: Support ARM-based SH-Mobile CPUs."

The commit assumed that CONFIG_ARCH_SHMOBILE only was set
on ARM platforms, but it turns out that this kconfig is also
set by all SH-based SoCs. Sh7724 and other older SH-Mobile
SoCs are all broken without this fix.

This patch converts the "defined(CONFIG_ARCH_SHMOBILE)" into
one "defined()" per SoC model - similar to existing SH code.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/serial/sh-sci.h |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

--- 0001/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2010-03-16 20:09:35.000000000 +0900
@@ -31,7 +31,9 @@
 # define SCSCR_INIT(port) (port->mapbase = SCIF2) ? 0xF3 : 0xF0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-      defined(CONFIG_ARCH_SHMOBILE)
+      defined(CONFIG_ARCH_SH7367) || \
+      defined(CONFIG_ARCH_SH7377) || \
+      defined(CONFIG_ARCH_SH7372)
 # define SCSCR_INIT(port)  0x0030 /* TIE=0,RIE=0,TE=1,RE=1 */
 # define PORT_PTCR	   0xA405011EUL
 # define PORT_PVCR	   0xA4050122UL
@@ -230,7 +232,9 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_ARCH_SHMOBILE)
+    defined(CONFIG_ARCH_SH7367) || \
+    defined(CONFIG_ARCH_SH7377) || \
+    defined(CONFIG_ARCH_SH7372)
 # define SCIF_ORER    0x0200
 # define SCIF_ERRORS ( SCIF_PER | SCIF_FER | SCIF_ER | SCIF_BRK | SCIF_ORER)
 # define SCIF_RFDC_MASK 0x007f
@@ -264,7 +268,9 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_ARCH_SHMOBILE)
+    defined(CONFIG_ARCH_SH7367) || \
+    defined(CONFIG_ARCH_SH7377) || \
+    defined(CONFIG_ARCH_SH7372)
 # define SCxSR_RDxF_CLEAR(port)	 (sci_in(port, SCxSR) & 0xfffc)
 # define SCxSR_ERROR_CLEAR(port) (sci_in(port, SCxSR) & 0xfd73)
 # define SCxSR_TDxE_CLEAR(port)	 (sci_in(port, SCxSR) & 0xffdf)
@@ -359,7 +365,10 @@
     SCI_OUT(sci_size, sci_offset, value);				\
   }
 
-#if defined(CONFIG_CPU_SH3) || defined(CONFIG_ARCH_SHMOBILE)
+#if defined(CONFIG_CPU_SH3) || \
+    defined(CONFIG_ARCH_SH7367) || \
+    defined(CONFIG_ARCH_SH7377) || \
+    defined(CONFIG_ARCH_SH7372)
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) || defined(CONFIG_CPU_SUBTYPE_SH7712)
 #define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size, sh4_sci_offset, sh4_sci_size, \
 		                sh3_scif_offset, sh3_scif_size, sh4_scif_offset, sh4_scif_size, \
@@ -370,7 +379,9 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-      defined(CONFIG_ARCH_SHMOBILE)
+      defined(CONFIG_ARCH_SH7367) || \
+      defined(CONFIG_ARCH_SH7377) || \
+      defined(CONFIG_ARCH_SH7372)
 #define SCIF_FNS(name, scif_offset, scif_size) \
   CPU_SCIF_FNS(name, scif_offset, scif_size)
 #else
@@ -406,7 +417,9 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_ARCH_SHMOBILE)
+    defined(CONFIG_ARCH_SH7367) || \
+    defined(CONFIG_ARCH_SH7377) || \
+    defined(CONFIG_ARCH_SH7372)
 
 SCIF_FNS(SCSMR,  0x00, 16)
 SCIF_FNS(SCBRR,  0x04,  8)
@@ -589,7 +602,9 @@ static inline int sci_rxd_in(struct uart
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-      defined(CONFIG_ARCH_SHMOBILE)
+      defined(CONFIG_ARCH_SH7367) || \
+      defined(CONFIG_ARCH_SH7377) || \
+      defined(CONFIG_ARCH_SH7372)
 #define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723) ||\
       defined(CONFIG_CPU_SUBTYPE_SH7724)

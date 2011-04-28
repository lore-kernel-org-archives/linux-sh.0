From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 03:10:35 +0000
Subject: [PATCH] sh: sh-sci: sh7377 and sh73a0 build fixes
Message-Id: <20110428031035.25672.40816.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix sh7377 and sh73a0 build failure:

drivers/tty/serial/sh-sci.c: In function 'scif_txfill':
drivers/tty/serial/sh-sci.c:338: error: implicit declaration of function 'sci_SCTFDR_in'
drivers/tty/serial/sh-sci.c: In function 'scif_rxfill':
drivers/tty/serial/sh-sci.c:351: error: implicit declaration of function 'sci_SCRFDR_in'
make[3]: *** [drivers/tty/serial/sh-sci.o] Error 1
make[2]: *** [drivers/tty/serial] Error 2
make[1]: *** [drivers/tty] Error 2
make: *** [drivers] Error 2

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Observed on linux-next 20110421

 drivers/tty/serial/sh-sci.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 0001/drivers/tty/serial/sh-sci.h
+++ work/drivers/tty/serial/sh-sci.h	2011-04-27 21:53:00.000000000 +0900
@@ -270,12 +270,12 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7705) || \
       defined(CONFIG_CPU_SUBTYPE_SH7720) || \
       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-      defined(CONFIG_ARCH_SH73A0) || \
-      defined(CONFIG_ARCH_SH7367) || \
-      defined(CONFIG_ARCH_SH7377)
+      defined(CONFIG_ARCH_SH7367)
 #define SCIF_FNS(name, scif_offset, scif_size) \
   CPU_SCIF_FNS(name, scif_offset, scif_size)
-#elif defined(CONFIG_ARCH_SH7372)
+#elif defined(CONFIG_ARCH_SH7377) || \
+      defined(CONFIG_ARCH_SH7372) || \
+      defined(CONFIG_ARCH_SH73A0)
 #define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scifb_offset, sh4_scifb_size) \
   CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scifb_offset, sh4_scifb_size)
 #define SCIF_FNS(name, scif_offset, scif_size) \
@@ -313,9 +313,7 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
     defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_ARCH_SH73A0) || \
-    defined(CONFIG_ARCH_SH7367) || \
-    defined(CONFIG_ARCH_SH7377)
+    defined(CONFIG_ARCH_SH7367)
 
 SCIF_FNS(SCSMR,  0x00, 16)
 SCIF_FNS(SCBRR,  0x04,  8)
@@ -326,7 +324,9 @@ SCIF_FNS(SCFDR,  0x1c, 16)
 SCIF_FNS(SCxTDR, 0x20,  8)
 SCIF_FNS(SCxRDR, 0x24,  8)
 SCIF_FNS(SCLSR,  0x00,  0)
-#elif defined(CONFIG_ARCH_SH7372)
+#elif defined(CONFIG_ARCH_SH7377) || \
+      defined(CONFIG_ARCH_SH7372) || \
+      defined(CONFIG_ARCH_SH73A0)
 SCIF_FNS(SCSMR,  0x00, 16)
 SCIF_FNS(SCBRR,  0x04,  8)
 SCIF_FNS(SCSCR,  0x08, 16)

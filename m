From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 28 Apr 2009 04:40:15 +0000
Subject: [PATCH] sh-sci h8300 fix
Message-Id: <87y6tlcrww.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

- Dummy SCIF functions define.
- h8300 specific header include.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index dbf5357..d85b2ae 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -53,6 +53,10 @@
 #include <asm/sh_bios.h>
 #endif
 
+#ifdef CONFIG_H8300
+#include <asm/gpio.h>
+#endif
+
 #include "sh-sci.h"
 
 struct sci_port {
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index d0aa82d..a9c9e56 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -314,6 +314,7 @@
     }									\
   }
 
+#ifndef CONFIG_H8300
 #define CPU_SCIF_FNS(name, scif_offset, scif_size)				\
   static inline unsigned int sci_##name##_in(struct uart_port *port)	\
   {									\
@@ -323,6 +324,17 @@
   {									\
     SCI_OUT(scif_size, scif_offset, value);				\
   }
+#else
+/* h8300 don't have SCIF */
+#define CPU_SCIF_FNS(name)						\
+  static inline unsigned int sci_##name##_in(struct uart_port *port)	\
+  {									\
+    return 0;								\
+  }									\
+  static inline void sci_##name##_out(struct uart_port *port, unsigned int value) \
+  {									\
+  }
+#endif
 
 #define CPU_SCI_FNS(name, sci_offset, sci_size)				\
   static inline unsigned int sci_##name##_in(struct uart_port* port)	\
@@ -360,7 +372,8 @@
 		 sh3_scif_offset, sh3_scif_size, sh4_scif_offset, sh4_scif_size, \
                  h8_sci_offset, h8_sci_size) \
   CPU_SCI_FNS(name, h8_sci_offset, h8_sci_size)
-#define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size, sh4_scif_offset, sh4_scif_size)
+#define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size, sh4_scif_offset, sh4_scif_size) \
+  CPU_SCIF_FNS(name)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
         #define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scif_offset, sh4_scif_size) \
                 CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size, sh4_scif_offset, sh4_scif_size)

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>

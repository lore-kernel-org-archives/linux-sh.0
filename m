From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:43:31 +0000
Subject: [PATCH 02/20] serial: sh-sci: clean up white space
Message-Id: <87y5vn9y5r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/tty/serial/sh-sci.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index e9bed03..ab6be55 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -11,13 +11,13 @@
 
 #define SCxSR_ERRORS(port)	(to_sci_port(port)->cfg->error_mask)
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_ARCH_SH73A0) || \
-    defined(CONFIG_ARCH_SH7367) || \
-    defined(CONFIG_ARCH_SH7377) || \
-    defined(CONFIG_ARCH_SH7372)
+#if	defined(CONFIG_CPU_SUBTYPE_SH7705) ||\
+	defined(CONFIG_CPU_SUBTYPE_SH7720) ||\
+	defined(CONFIG_CPU_SUBTYPE_SH7721) ||\
+	defined(CONFIG_ARCH_SH73A0) ||\
+	defined(CONFIG_ARCH_SH7367) ||\
+	defined(CONFIG_ARCH_SH7377) ||\
+	defined(CONFIG_ARCH_SH7372)
 # define SCxSR_RDxF_CLEAR(port)	 (sci_in(port, SCxSR) & 0xfffc)
 # define SCxSR_ERROR_CLEAR(port) (sci_in(port, SCxSR) & 0xfd73)
 # define SCxSR_TDxE_CLEAR(port)	 (sci_in(port, SCxSR) & 0xffdf)
-- 
1.7.5.4


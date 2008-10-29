From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 29 Oct 2008 04:33:45 +0000
Subject: [PATCH] sh: Add sci_rxd_in of SH4-202
Message-Id: <4907E7A9.6080202@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH4-202 doesn't have SCSXX1. But it is treated so that there is SCSPTR1 in
current code. This patch add sci_rxd_in of SH4-202.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/serial/sh-sci.h |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 257b223..cd4073e 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -526,8 +526,7 @@ static inline int sci_rxd_in(struct uart_port *port)
       defined(CONFIG_CPU_SUBTYPE_SH7751R) || \
       defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
       defined(CONFIG_CPU_SUBTYPE_SH7750S) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7091)  || \
-      defined(CONFIG_CPU_SUBTYPE_SH4_202)
+      defined(CONFIG_CPU_SUBTYPE_SH7091)
 static inline int sci_rxd_in(struct uart_port *port)
 {
 	if (port->mapbase = 0xffe00000)
@@ -536,6 +535,13 @@ static inline int sci_rxd_in(struct uart_port *port)
 		return ctrl_inw(SCSPTR2)&0x0001 ? 1 : 0; /* SCIF */
 	return 1;
 }
+#elif defined(CONFIG_CPU_SUBTYPE_SH4_202)
+static inline int sci_rxd_in(struct uart_port *port)
+{
+	if (port->mapbase = 0xffe80000)
+		return ctrl_inw(SCSPTR2)&0x0001 ? 1 : 0; /* SCIF */
+	return 1;
+}
 #elif defined(CONFIG_CPU_SUBTYPE_SH7760)
 static inline int sci_rxd_in(struct uart_port *port)
 {
-- 
1.5.6.5

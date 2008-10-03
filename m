From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 03 Oct 2008 08:37:31 +0000
Subject: [PATCH] serial: sh-sci: Add support SCIF of SH7723
Message-Id: <48E5D9CB.30408@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7723 has two types of SCIF (SCIF and SCIFA).
The current sh-sci driver supports only SCIFA, and calculation methods of SCBRR
are different.
This patch support this methods.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/serial/sh-sci.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 8a0749e..0dfd966 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -791,7 +791,14 @@ static inline int sci_rxd_in(struct uart_port *port)
       defined(CONFIG_CPU_SUBTYPE_SH7721)
 #define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
-#define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(16*bps)-1)
+static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
+{
+	if (port->type = PORT_SCIF)
+		return (clk+16*bps)/(32*bps)-1;
+	else
+		return ((clk*2)+16*bps)/(16*bps)-1;
+}
+#define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
 #elif defined(__H8300H__) || defined(__H8300S__)
 #define SCBRR_VALUE(bps) (((CONFIG_CPU_CLOCK*1000/32)/bps)-1)
 #elif defined(CONFIG_SUPERH64)
-- 1.5.6.3

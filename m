From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 29 Oct 2008 04:34:50 +0000
Subject: [PATCH] sh: Change register name SCSPTR to SCSPTR2
Message-Id: <4907E7EA.5020108@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This change a name of SCSPTR used in sci_rxd_in of SH5-101.
SCSPTR is not declared and will become the error.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/serial/sh-sci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index cd4073e..f4bd93e 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -605,7 +605,7 @@ static inline int sci_rxd_in(struct uart_port *port)
 #elif defined(CONFIG_CPU_SUBTYPE_SH5_101) || defined(CONFIG_CPU_SUBTYPE_SH5_103)
 static inline int sci_rxd_in(struct uart_port *port)
 {
-         return sci_in(port, SCSPTR)&0x0001 ? 1 : 0; /* SCIF */
+         return sci_in(port, SCSPTR2)&0x0001 ? 1 : 0; /* SCIF */
 }
 #elif defined(__H8300H__) || defined(__H8300S__)
 static inline int sci_rxd_in(struct uart_port *port)
-- 
1.5.6.5

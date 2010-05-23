From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 23 May 2010 16:39:02 +0000
Subject: [PATCH 1/4 v2] serial: add a new port type, found on some sh-mobile
Message-Id: <Pine.LNX.4.64.1005231820190.3571@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Such ports are found, e.g., on SH7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

rebased onto the current (sh-2.6/master) HEAD, where two more new port 
types have been registered.

 include/linux/serial_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f10db6e..5228320 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -186,6 +186,9 @@
 #define PORT_ALTERA_JTAGUART	91
 #define PORT_ALTERA_UART	92
 
+/* SH-SCI */
+#define PORT_SCIFB	93
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
-- 
1.6.2.4


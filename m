From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 May 2010 15:49:06 +0000
Subject: [PATCH 1/4] serial: add a new port type, found on some sh-mobile
Message-Id: <Pine.LNX.4.64.1005211733430.8450@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org

Such ports are found, e.g., on SH7372.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/serial_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 78dd1e7..5b0fbb2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -182,6 +182,9 @@
 /* Aeroflex Gaisler GRLIB APBUART */
 #define PORT_APBUART    90
 
+/* SH-SCI */
+#define PORT_SCIFB	91
+
 #ifdef __KERNEL__
 
 #include <linux/compiler.h>
-- 
1.6.2.4


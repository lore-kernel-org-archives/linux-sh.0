From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:14:37 +0000
Subject: [PATCH 01/14][RFC] arm64: renesas: tidyup MSTP9 reverse definition order
Message-Id: <87pp1qn40o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 include/dt-bindings/clock/r8a7795-clock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index bf7fd98..e28dd97 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -38,14 +38,14 @@
 /* MSTP8 */
 
 /* MSTP9 */
-#define R8A7795_CLK_GPIO0		12
-#define R8A7795_CLK_GPIO1		11
-#define R8A7795_CLK_GPIO2		10
-#define R8A7795_CLK_GPIO3		9
-#define R8A7795_CLK_GPIO4		8
-#define R8A7795_CLK_GPIO5		7
-#define R8A7795_CLK_GPIO6		6
 #define R8A7795_CLK_GPIO7		5
+#define R8A7795_CLK_GPIO6		6
+#define R8A7795_CLK_GPIO5		7
+#define R8A7795_CLK_GPIO4		8
+#define R8A7795_CLK_GPIO3		9
+#define R8A7795_CLK_GPIO2		10
+#define R8A7795_CLK_GPIO1		11
+#define R8A7795_CLK_GPIO0		12
 
 /* MSTP10 */
 
-- 
1.9.1


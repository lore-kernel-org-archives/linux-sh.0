From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:02:24 +0000
Subject: [PATCH 01/18 v3] arm64: renesas: tidyup MSTP9 reverse definition order
Message-Id: <87bnd01ob2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 include/dt-bindings/clock/r8a7795-clock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 7f7bfef..a310dfa 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -57,14 +57,14 @@
 #define R8A7795_CLK_ETHERAVB		12
 
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


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:25:48 +0000
Subject: [PATCH 06/17 v6][RFC] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
Message-Id: <87egiyb9hd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5 -> v6

 - no change

 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 1d70e78e..10e65d8 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -27,6 +27,8 @@ SoCs:
     compatible = "renesas,r8a7793"
   - R-Car E2 (R8A77940)
     compatible = "renesas,r8a7794"
+  - R-Car H3 (R8A77950)
+    compatible = "renesas,r8a7795"
 
 
 Boards:
-- 
1.9.1


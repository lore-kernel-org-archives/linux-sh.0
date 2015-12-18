From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:14 +0000
Subject: [PATCH 06/10] arm64: renesas: salvator-x: Add board part number to DT bindings
Message-Id: <187623569c4ccb26cd20cb68f56bcea2d00ee947.1450401186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 678a8184da24..9cf67e48f222 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -59,7 +59,7 @@ Boards:
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
     compatible = "renesas,porter", "renesas,r8a7791"
-  - Salvator-X
+  - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795";
   - SILK (RTP0RC7794LCB00011S)
     compatible = "renesas,silk", "renesas,r8a7794"
-- 
2.1.4


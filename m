From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Oct 2015 01:57:57 +0000
Subject: [PATCH 20/28] ARM: shmobile: add Porter board DT bindings
Message-Id: <12a75ced8ed7c6fa0ef483a35c15464bb9c9dab2.1444182812.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add Porter device tree bindings documentation, listing it as a supported board.

This allows to use checkpatch to validate DTSes referring to the Porter board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 1d70e78e7c80..a9148b1dcd96 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -55,5 +55,7 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
+  - Porter (M2-LCDP)
+    compatible = "renesas,porter", "renesas,r8a7791"
   - Silk
     compatible = "renesas,silk", "renesas,r8a7794";
-- 
2.1.4


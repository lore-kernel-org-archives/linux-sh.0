From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Oct 2015 01:58:04 +0000
Subject: [PATCH 27/28] ARM: shmobile: fix SILK board name
Message-Id: <7265405f74b33f256073ea233690b6ee866c252c.1444182812.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Unfortunately, the SILK board bindings were not quite correct, as the  board
name should be all caps.  Fix that,  adding the board model #  in parens and
removing stray semicolon.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index a9148b1dcd96..40bb9007cd0d 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,5 +57,5 @@ Boards:
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Porter (M2-LCDP)
     compatible = "renesas,porter", "renesas,r8a7791"
-  - Silk
-    compatible = "renesas,silk", "renesas,r8a7794";
+  - SILK (RTP0RC7794LCB00011S)
+    compatible = "renesas,silk", "renesas,r8a7794"
-- 
2.1.4


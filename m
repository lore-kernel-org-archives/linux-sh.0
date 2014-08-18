From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 18 Aug 2014 15:51:47 +0000
Subject: [PATCH 8/8] ARM: shmobile: r8a7794: document CPG clock support
Message-Id: <1408377107-3822-9-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index 7b41c2f..e6ad35b 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -8,6 +8,7 @@ Required Properties:
   - compatible: Must be one of
     - "renesas,r8a7790-cpg-clocks" for the r8a7790 CPG
     - "renesas,r8a7791-cpg-clocks" for the r8a7791 CPG
+    - "renesas,r8a7794-cpg-clocks" for the r8a7794 CPG
     - "renesas,rcar-gen2-cpg-clocks" for the generic R-Car Gen2 CPG
 
   - reg: Base address and length of the memory resource used by the CPG
-- 
1.8.4.5


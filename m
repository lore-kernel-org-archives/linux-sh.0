From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Aug 2015 21:30:48 +0000
Subject: [PATCH] ARM: shmobile: Add silk device tree bindings documentation
Message-Id: <1438723848-14812-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add Silk Device tree bindings Documentation, listing it as a supported board.

This allows to use checkpatch to validate DTSes referring to the Silk board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index c4f19b2e7dd9..f3f96b5a7418 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,6 +57,8 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
+  - Silk
+    compatible = "renesas,silk", "renesas,r8a7794";
 
 Note: Reference Device Tree Implementations are temporary implementations
       to ease the migration from platform devices to Device Tree, and are
-- 
2.1.4


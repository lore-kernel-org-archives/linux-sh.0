From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 14 Aug 2015 13:54:04 +0000
Subject: [PATCH] ARM: shmobile: remove paragraph on DT reference platforms
Message-Id: <1439560444-5111-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

They have all been eliminated now.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index f8aad0b..1d70e78e 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,7 +57,3 @@ Boards:
     compatible = "renesas,marzen", "renesas,r8a7779"
   - Silk
     compatible = "renesas,silk", "renesas,r8a7794";
-
-Note: Reference Device Tree Implementations are temporary implementations
-      to ease the migration from platform devices to Device Tree, and are
-      intended to be removed in the future.
-- 
2.4.6


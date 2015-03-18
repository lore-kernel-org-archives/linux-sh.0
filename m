From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Mar 2015 18:42:41 +0000
Subject: [PATCH] thermal: rcar: Fix typo in r8a73a4 SoC name
Message-Id: <1426704161-26617-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

r8a73a4 is R-Mobile APE6, not AP6.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 43404b1979332628..332e625f6ed01cb4 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible		: "renesas,thermal-<soctype>", "renesas,rcar-thermal"
 			  as fallback.
 			  Examples with soctypes are:
-			    - "renesas,thermal-r8a73a4" (R-Mobile AP6)
+			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
-- 
1.9.1


From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Jul 2014 12:23:42 +0000
Subject: [PATCH 12/13] [RFC] thermal: rcar: Add binding docs for new R-Car Gen2 SoCs
Message-Id: <1404908623-909-13-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

r8a7791 is now called "R-Car M2-W".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 0ef00be44b01..43404b197933 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -7,7 +7,10 @@ Required properties:
 			    - "renesas,thermal-r8a73a4" (R-Mobile AP6)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
-			    - "renesas,thermal-r8a7791" (R-Car M2)
+			    - "renesas,thermal-r8a7791" (R-Car M2-W)
+			    - "renesas,thermal-r8a7792" (R-Car V2H)
+			    - "renesas,thermal-r8a7793" (R-Car M2-N)
+			    - "renesas,thermal-r8a7794" (R-Car E2)
 - reg			: Address range of the thermal registers.
 			  The 1st reg will be recognized as common register
 			  if it has "interrupts".
-- 
1.9.1


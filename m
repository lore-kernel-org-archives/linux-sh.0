From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Jul 2014 12:23:43 +0000
Subject: [PATCH 13/13] [RFC] irqchip: renesas-irqc: Add binding docs for new R-Car Gen2 SoCs
Message-Id: <1404908623-909-14-git-send-email-geert+renesas@glider.be>
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
 .../devicetree/bindings/interrupt-controller/renesas,irqc.txt        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index f819e2a5907c..cd9d92708c21 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -6,7 +6,10 @@ Required properties:
   Examples with soctypes are:
     - "renesas,irqc-r8a73a4" (R-Mobile AP6)
     - "renesas,irqc-r8a7790" (R-Car H2)
-    - "renesas,irqc-r8a7791" (R-Car M2)
+    - "renesas,irqc-r8a7791" (R-Car M2-W)
+    - "renesas,irqc-r8a7792" (R-Car V2H)
+    - "renesas,irqc-r8a7793" (R-Car M2-N)
+    - "renesas,irqc-r8a7794" (R-Car E2)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
 
-- 
1.9.1


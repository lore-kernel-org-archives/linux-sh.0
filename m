From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 07:59:58 +0000
Subject: [PATCH v2 1/3] irqchip: renesas-intc-irqpin: Document SoC-specific bindings
Message-Id: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The documentation only mentioned the generic fallback compatible property.
Add the missing SoC-specific compatible properties, which are already in
use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Acked-by
---
 .../bindings/interrupt-controller/renesas,intc-irqpin.txt         | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
index 1f8b0c507c26..c73acd060093 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -2,7 +2,13 @@ DT bindings for the R-/SH-Mobile irqpin controller
 
 Required properties:
 
-- compatible: has to be "renesas,intc-irqpin"
+- compatible: has to be "renesas,intc-irqpin-<soctype>", "renesas,intc-irqpin"
+  as fallback.
+  Examples with soctypes are:
+    - "renesas,intc-irqpin-r8a7740" (R-Mobile A1)
+    - "renesas,intc-irqpin-r8a7778" (R-Car M1A)
+    - "renesas,intc-irqpin-r8a7779" (R-Car H1)
+    - "renesas,intc-irqpin-sh73a0" (SH-Mobile AG5)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
 
-- 
1.9.1


From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 14 May 2015 01:06:38 +0000
Subject: [PATCH 09/31] ARM: shmobile: r8a7740 dtsi: Use generic names for device nodes
Message-Id: <32e4094238f10dce95bf9f8eacdf84a880182db5.1431565427.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 413590d6c316..d84714468cce 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -67,7 +67,7 @@
 	};
 
 	/* irqpin0: IRQ0 - IRQ7 */
-	irqpin0: irqpin@e6900000 {
+	irqpin0: interrupt-controller@e6900000 {
 		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -89,7 +89,7 @@
 	};
 
 	/* irqpin1: IRQ8 - IRQ15 */
-	irqpin1: irqpin@e6900004 {
+	irqpin1: interrupt-controller@e6900004 {
 		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -111,7 +111,7 @@
 	};
 
 	/* irqpin2: IRQ16 - IRQ23 */
-	irqpin2: irqpin@e6900008 {
+	irqpin2: interrupt-controller@e6900008 {
 		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -133,7 +133,7 @@
 	};
 
 	/* irqpin3: IRQ24 - IRQ31 */
-	irqpin3: irqpin@e690000c {
+	irqpin3: interrupt-controller@e690000c {
 		compatible = "renesas,intc-irqpin-r8a7740", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-- 
2.1.4


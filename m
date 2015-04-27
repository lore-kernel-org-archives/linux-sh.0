From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:25 +0000
Subject: [PATCH 01/10] ARM: shmobile: r8a7740 dtsi: Use generic names for device nodes
Message-Id: <1430139334-15272-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

irqpin -> interrupt-controller

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 83c1c3ca1b8f1400..f265b6b194e9774d 100644
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
1.9.1


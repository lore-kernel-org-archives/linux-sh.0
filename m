From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 14 May 2015 01:06:43 +0000
Subject: [PATCH 14/31] ARM: shmobile: sh73a0 dtsi: Use generic names for device nodes
Message-Id: <4239baee807bbd93e89eef184b2547f5ae902615.1431565427.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/sh73a0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index cde61b463b6a..11e17c5f26e2 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -90,7 +90,7 @@
 		status = "disabled";
 	};
 
-	irqpin0: irqpin@e6900000 {
+	irqpin0: interrupt-controller@e6900000 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -112,7 +112,7 @@
 		control-parent;
 	};
 
-	irqpin1: irqpin@e6900004 {
+	irqpin1: interrupt-controller@e6900004 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -134,7 +134,7 @@
 		control-parent;
 	};
 
-	irqpin2: irqpin@e6900008 {
+	irqpin2: interrupt-controller@e6900008 {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -156,7 +156,7 @@
 		control-parent;
 	};
 
-	irqpin3: irqpin@e690000c {
+	irqpin3: interrupt-controller@e690000c {
 		compatible = "renesas,intc-irqpin-sh73a0", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
-- 
2.1.4


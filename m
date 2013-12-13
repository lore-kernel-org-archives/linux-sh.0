From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:32 +0000
Subject: [PATCH 58/69] ARM: shmobile: Fix r8a7791 GPIO resources in DTS
Message-Id: <89fbba1210a171f134b72c4d3ccf376265c6ff3f.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7791 GPIO resources are currently incorrect. Fix that
by making them match the English r8a7791 v0.31 data sheet.

Tested with GPIO LED using Koelsch DT reference.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e36b3652..a349aff 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -49,9 +49,9 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	gpio0: gpio@ffc40000 {
+	gpio0: gpio@e6050000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc40000 0 0x50>;
+		reg = <0 0xe6050000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -61,9 +61,9 @@
 		interrupt-controller;
 	};
 
-	gpio1: gpio@ffc41000 {
+	gpio1: gpio@e6051000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc41000 0 0x50>;
+		reg = <0 0xe6051000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -73,9 +73,9 @@
 		interrupt-controller;
 	};
 
-	gpio2: gpio@ffc42000 {
+	gpio2: gpio@e6052000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc42000 0 0x50>;
+		reg = <0 0xe6052000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -85,9 +85,9 @@
 		interrupt-controller;
 	};
 
-	gpio3: gpio@ffc43000 {
+	gpio3: gpio@e6053000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc43000 0 0x50>;
+		reg = <0 0xe6053000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -97,9 +97,9 @@
 		interrupt-controller;
 	};
 
-	gpio4: gpio@ffc44000 {
+	gpio4: gpio@e6054000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc44000 0 0x50>;
+		reg = <0 0xe6054000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -109,9 +109,9 @@
 		interrupt-controller;
 	};
 
-	gpio5: gpio@ffc45000 {
+	gpio5: gpio@e6055000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc45000 0 0x50>;
+		reg = <0 0xe6055000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -121,9 +121,9 @@
 		interrupt-controller;
 	};
 
-	gpio6: gpio@ffc45400 {
+	gpio6: gpio@e6055400 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc45400 0 0x50>;
+		reg = <0 0xe6055400 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -133,9 +133,9 @@
 		interrupt-controller;
 	};
 
-	gpio7: gpio@ffc45800 {
+	gpio7: gpio@e6055800 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
-		reg = <0 0xffc45800 0 0x50>;
+		reg = <0 0xe6055800 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
-- 
1.8.4


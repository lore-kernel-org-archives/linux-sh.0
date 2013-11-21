From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Nov 2013 00:41:55 +0000
Subject: [PATCH] ARM: shmobile: Fix r8a7790 GPIO resources in DTS
Message-Id: <20131121004155.16463.63939.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7790 GPIO resources are currently incorrect. Fix that
by making them match the information in the data sheet.

Tested with GPIO LED using Lager DT reference.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- 0017/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 17:37:37.000000000 +0900
@@ -90,9 +90,9 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	gpio0: gpio@ffc40000 {
+	gpio0: gpio@e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc40000 0 0x2c>;
+		reg = <0 0xe6050000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -102,9 +102,9 @@
 		interrupt-controller;
 	};
 
-	gpio1: gpio@ffc41000 {
+	gpio1: gpio@e6051000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc41000 0 0x2c>;
+		reg = <0 0xe6051000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -114,9 +114,9 @@
 		interrupt-controller;
 	};
 
-	gpio2: gpio@ffc42000 {
+	gpio2: gpio@e6052000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc42000 0 0x2c>;
+		reg = <0 0xe6052000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -126,9 +126,9 @@
 		interrupt-controller;
 	};
 
-	gpio3: gpio@ffc43000 {
+	gpio3: gpio@e6053000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc43000 0 0x2c>;
+		reg = <0 0xe6053000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -138,9 +138,9 @@
 		interrupt-controller;
 	};
 
-	gpio4: gpio@ffc44000 {
+	gpio4: gpio@e6054000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc44000 0 0x2c>;
+		reg = <0 0xe6054000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
@@ -150,9 +150,9 @@
 		interrupt-controller;
 	};
 
-	gpio5: gpio@ffc45000 {
+	gpio5: gpio@e6055000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
-		reg = <0 0xffc45000 0 0x2c>;
+		reg = <0 0xe6055000 0 0x50>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;

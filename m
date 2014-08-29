From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:16:40 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7778 dtsi: sort it
Message-Id: <1409336201-708-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409336201-708-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409336201-708-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: horms@verge.net.au, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

- move #include to the top
- "compatible" goes first
- sort nodes by address

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 315ec62..c152877 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -14,10 +14,10 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/interrupt-controller/irq.h>
 
+/include/ "skeleton.dtsi"
+
 / {
 	compatible = "renesas,r8a7778";
 	interrupt-parent = <&gic>;
@@ -27,8 +27,8 @@
 		#size-cells = <0>;
 
 		cpu@0 {
-			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <800000000>;
 		};
@@ -121,42 +121,37 @@
 		interrupt-controller;
 	};
 
-	pfc: pfc@fffc0000 {
-		compatible = "renesas,pfc-r8a7778";
-		reg = <0xfffc0000 0x118>;
-	};
-
 	i2c0: i2c@ffc70000 {
+		compatible = "renesas,i2c-r8a7778";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
 	i2c1: i2c@ffc71000 {
+		compatible = "renesas,i2c-r8a7778";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
 	i2c2: i2c@ffc72000 {
+		compatible = "renesas,i2c-r8a7778";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
 	i2c3: i2c@ffc73000 {
+		compatible = "renesas,i2c-r8a7778";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -204,13 +199,6 @@
 		status = "disabled";
 	};
 
-	mmcif: mmc@ffe4e000 {
-		compatible = "renesas,sh-mmcif";
-		reg = <0xffe4e000 0x100>;
-		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
-	};
-
 	sdhi0: sd@ffe4c000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4c000 0x100>;
@@ -229,6 +217,13 @@
 		status = "disabled";
 	};
 
+	mmcif: mmc@ffe4e000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xffe4e000 0x100>;
+		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	sdhi2: sd@ffe4f000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4f000 0x100>;
@@ -238,28 +233,33 @@
 		status = "disabled";
 	};
 
-	hspi0: spi@fffc7000 {
+	pfc: pfc@fffc0000 {
+		compatible = "renesas,pfc-r8a7778";
+		reg = <0xfffc0000 0x118>;
+	};
+
+	hspi2: spi@fffc6000 {
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
-		reg = <0xfffc7000 0x18>;
-		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xfffc6000 0x18>;
+		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
 	};
 
-	hspi1: spi@fffc8000 {
+	hspi0: spi@fffc7000 {
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
-		reg = <0xfffc8000 0x18>;
-		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xfffc7000 0x18>;
+		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
 	};
 
-	hspi2: spi@fffc6000 {
+	hspi1: spi@fffc8000 {
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
-		reg = <0xfffc6000 0x18>;
-		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xfffc8000 0x18>;
+		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
1.8.4.5


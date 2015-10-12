From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:13 +0000
Subject: [RFC/RFT 5/6] ARM: dts: add CCI node for r8a7790
Message-Id: <1444671674-19275-6-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

Add device-tree bindings for the ARM CCI-400 on r8a7790. There
are two slave interfaces: one for the A15 cluster and one for the
A7 cluster.

(inspired on exynos5420.dtsi)

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 91b0eb0..e7c3c6a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -52,7 +52,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7790_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
-
+			cci-control-port = <&cci_control1>;
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1400000 1000000>,
 					   <1225000 1000000>,
@@ -67,6 +67,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu2: cpu@2 {
@@ -74,6 +75,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <2>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu3: cpu@3 {
@@ -81,6 +83,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <3>;
 			clock-frequency = <1300000000>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu4: cpu@4 {
@@ -88,6 +91,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu5: cpu@5 {
@@ -95,6 +99,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu6: cpu@6 {
@@ -102,6 +107,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 
 		cpu7: cpu@7 {
@@ -109,6 +115,7 @@
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
 			clock-frequency = <780000000>;
+			cci-control-port = <&cci_control2>;
 		};
 	};
 
@@ -124,6 +131,26 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	cci@f0090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0xf0090000 0 0x1000>;
+		ranges = <0x0 0x0 0xf0090000 0x10000>;
+
+		cci_control1: slave-if@4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control2: slave-if@5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+	};
+
 	gpio0: gpio@e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
-- 
2.4.5


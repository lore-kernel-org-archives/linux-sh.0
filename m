From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 30 Mar 2015 21:58:23 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add EtherAVB clock
Message-Id: <2142150.nOzfK74FZR@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1625400.M0MxPQybIy@wasted.cogentembedded.com>
In-Reply-To: <1625400.M0MxPQybIy@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add the EtherAVB clock to the R8A7790 device tree.

Based on original patch by Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7790.dtsi            |    8 +++++---
 include/dt-bindings/clock/r8a7790-clock.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -1193,16 +1193,18 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
 			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
-			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
+			         <&zg_clk>, <&p_clk>, <&hp_clk>, <&zs_clk>,
+				 <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7790_CLK_MLB R8A7790_CLK_VIN3 R8A7790_CLK_VIN2
-				R8A7790_CLK_VIN1 R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
+				R8A7790_CLK_VIN1 R8A7790_CLK_VIN0
+				R8A7790_CLK_ETHER R8A7790_CLK_ETHERAVB
 				R8A7790_CLK_SATA1 R8A7790_CLK_SATA0
 			>;
 			clock-output-names  				"mlb", "vin3", "vin2", "vin1", "vin0", "ether",
-				"sata1", "sata0";
+				"etheravb", "sata1", "sata0";
 		};
 		mstp9_clks: mstp9_clks@e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
Index: renesas/include/dt-bindings/clock/r8a7790-clock.h
=================================--- renesas.orig/include/dt-bindings/clock/r8a7790-clock.h
+++ renesas/include/dt-bindings/clock/r8a7790-clock.h
@@ -105,6 +105,7 @@
 #define R8A7790_CLK_VIN2		9
 #define R8A7790_CLK_VIN1		10
 #define R8A7790_CLK_VIN0		11
+#define R8A7790_CLK_ETHERAVB		12
 #define R8A7790_CLK_ETHER		13
 #define R8A7790_CLK_SATA1		14
 #define R8A7790_CLK_SATA0		15


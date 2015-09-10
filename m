From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:14:58 +0000
Subject: [PATCH 02/14][RFC] arm64: renesas: r8a7795: add I2C support
Message-Id: <87oahan403.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 89 ++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7795-clock.h |  7 +++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 66c3ad6..969116d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -16,6 +16,16 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -403,13 +413,20 @@
 					reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
 					clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
 						 <&cp_clk>, <&cp_clk>, <&cp_clk>,
-						 <&cp_clk>, <&cp_clk>;
+						 <&cp_clk>, <&cp_clk>,
+						 <&s3d2_clk>, <&s3d2_clk>, <&s3d2_clk>,
+						 <&s3d2_clk>, <&s3d2_clk>, <&s3d2_clk>,
+						 <&s3d2_clk>;
 					#clock-cells = <1>;
 					clock-indices = <
 						R8A7795_CLK_GPIO7 R8A7795_CLK_GPIO6
 						R8A7795_CLK_GPIO5 R8A7795_CLK_GPIO4
 						R8A7795_CLK_GPIO3 R8A7795_CLK_GPIO2
 						R8A7795_CLK_GPIO1 R8A7795_CLK_GPIO0
+						R8A7795_CLK_I2C6  R8A7795_CLK_I2C5
+						R8A7795_CLK_I2C4  R8A7795_CLK_I2C3
+						R8A7795_CLK_I2C2  R8A7795_CLK_I2C1
+						R8A7795_CLK_I2C0
 					>;
 				};
 			};
@@ -506,5 +523,75 @@
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
+
+		i2c0: i2c@e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe6500000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe6510000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@e66d0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe66d0000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C3>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@e66d8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe66d8000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C4>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@e66e0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe66e0000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C5>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@e66e8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795";
+			reg = <0 0xe66e8000 0 0x40>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7795_CLK_I2C6>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index e28dd97..b7c2c95 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -46,6 +46,13 @@
 #define R8A7795_CLK_GPIO2		10
 #define R8A7795_CLK_GPIO1		11
 #define R8A7795_CLK_GPIO0		12
+#define R8A7795_CLK_I2C6		18
+#define R8A7795_CLK_I2C5		19
+#define R8A7795_CLK_I2C4		27
+#define R8A7795_CLK_I2C3		28
+#define R8A7795_CLK_I2C2		29
+#define R8A7795_CLK_I2C1		30
+#define R8A7795_CLK_I2C0		31
 
 /* MSTP10 */
 
-- 
1.9.1


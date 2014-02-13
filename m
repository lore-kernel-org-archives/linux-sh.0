From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Feb 2014 18:02:50 +0000
Subject: [PATCH 2/3] renesas: change to using clock-indices
Message-Id: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

With the addition of clock-indices, we need to change the renesas
clock implementation to use these instead of the local definition.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 .../bindings/clock/renesas,cpg-mstp-clocks.txt         |  2 +-
 arch/arm/boot/dts/r8a7790.dtsi                         | 16 ++++++++--------
 arch/arm/boot/dts/r8a7791.dtsi                         | 18 +++++++++---------
 drivers/clk/shmobile/clk-mstp.c                        |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index a6a352c..f5b4171 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -43,7 +43,7 @@ Example
 		clock-output-names  			"tpu0", "mmcif1", "sdhi3", "sdhi2",
 			 "sdhi1", "sdhi0", "mmcif0";
-		renesas,clock-indices = <
+		clock-indices = <
 			R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
 			R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
 			R8A7790_CLK_MMCIF0
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 54ab318..7959323 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -671,7 +671,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_MSIOF0>;
+			clock-indices = <R8A7790_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks@e6150134 {
@@ -681,7 +681,7 @@
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_TMU1 R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
 				R8A7790_CLK_CMT0 R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1
 				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_RT R8A7790_CLK_VSP1_SY
@@ -696,7 +696,7 @@
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
 				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
 				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
@@ -712,7 +712,7 @@
 				 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>,
 				 <&mmc0_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
 				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
 				R8A7790_CLK_MMCIF0 R8A7790_CLK_CMT1
@@ -726,7 +726,7 @@
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
 			clocks = <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
+			clock-indices = <R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
 			clock-output-names = "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
@@ -736,7 +736,7 @@
 				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
 				 <&zx_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_EHCI R8A7790_CLK_HSUSB R8A7790_CLK_HSCIF1
 				R8A7790_CLK_HSCIF0 R8A7790_CLK_SCIF1 R8A7790_CLK_SCIF0
 				R8A7790_CLK_DU2 R8A7790_CLK_DU1 R8A7790_CLK_DU0
@@ -752,7 +752,7 @@
 			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
 				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
 				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER R8A7790_CLK_SATA1
 				R8A7790_CLK_SATA0
@@ -766,7 +766,7 @@
 			clocks = <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>,
 				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD
 				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2 R8A7790_CLK_I2C1
 				R8A7790_CLK_I2C0
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 240c4ec..166b986 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -598,7 +598,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7791_CLK_MSIOF0>;
+			clock-indices = <R8A7791_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks@e6150134 {
@@ -607,7 +607,7 @@
 			clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_TMU1 R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
 				R8A7791_CLK_CMT0 R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
 				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_SY
@@ -622,7 +622,7 @@
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_SCIFA2 R8A7791_CLK_SCIFA1 R8A7791_CLK_SCIFA0
 				R8A7791_CLK_MSIOF2 R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1
 				R8A7791_CLK_MSIOF1 R8A7791_CLK_SCIFB2
@@ -637,7 +637,7 @@
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>,
 				<&cpg_clocks R8A7791_CLK_SD0>, <&mmc0_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1
 				R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT1
 			>;
@@ -649,7 +649,7 @@
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
 			clocks = <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7791_CLK_THERMAL R8A7791_CLK_PWM>;
+			clock-indices = <R8A7791_CLK_THERMAL R8A7791_CLK_PWM>;
 			clock-output-names = "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
@@ -659,7 +659,7 @@
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
 				 <&zx_clk>, <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_HSUSB R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
 				R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1 R8A7791_CLK_HSCIF0
 				R8A7791_CLK_SCIF3 R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
@@ -676,7 +676,7 @@
 			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_VIN2 R8A7791_CLK_VIN1 R8A7791_CLK_VIN0
 				R8A7791_CLK_ETHER R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
 			>;
@@ -690,7 +690,7 @@
 				 <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
 				 <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
 				R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
 				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
@@ -704,7 +704,7 @@
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_SCIFA3 R8A7791_CLK_SCIFA4 R8A7791_CLK_SCIFA5
 			>;
 			clock-output-names = "scifa3", "scifa4", "scifa5";
diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 42d5912..95a2aa7 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -197,7 +197,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 			continue;
 
 		parent_name = of_clk_get_parent_name(np, i);
-		ret = of_property_read_u32_index(np, "renesas,clock-indices", i,
+		ret = of_property_read_u32_index(np, "clock-indices", i,
 						 &clkidx);
 		if (parent_name = NULL || ret < 0)
 			break;
-- 
1.8.5.3


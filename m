From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 18:49:38 +0000
Subject: [PATCH v2 5/6] ARM: shmobile: r8a7791 dtsi: Change to using clock-indices
Message-Id: <1415645379-3366-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Ben Dooks <ben.dooks@codethink.co.uk>

With the addition of clock-indices in commit 8e33f91a0b84ae19 ("clk:
shmobile: clk-mstp: change to using clock-indices"), we can change the
DTSes to use the generic property instead of the deprecated
vendor-specific property.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[geert: Extracted r8a7791-specific part, rebased, reworded]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by
---
 arch/arm/boot/dts/r8a7791.dtsi | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 142c3ed5fb7a4d68..feb6b9a26e1ce73f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1056,7 +1056,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7791_CLK_MSIOF0>;
+			clock-indices = <R8A7791_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks@e6150134 {
@@ -1067,7 +1067,7 @@
 				 <&p_clk>, <&rclk_clk>, <&cp_clk>, <&zs_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_VCP0 R8A7791_CLK_VPC0 R8A7791_CLK_JPU
 				R8A7791_CLK_SSP1 R8A7791_CLK_TMU1 R8A7791_CLK_3DG
 				R8A7791_CLK_2DDMAC R8A7791_CLK_FDP1_1 R8A7791_CLK_FDP1_0
@@ -1087,7 +1087,7 @@
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>,
 				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_SCIFA2 R8A7791_CLK_SCIFA1 R8A7791_CLK_SCIFA0
 				R8A7791_CLK_MSIOF2 R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1
 				R8A7791_CLK_MSIOF1 R8A7791_CLK_SCIFB2
@@ -1104,7 +1104,7 @@
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
 				 <&mmc0_clk>, <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
 				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_PCIEC R8A7791_CLK_IIC1
 				R8A7791_CLK_SSUSB R8A7791_CLK_CMT1
@@ -1118,8 +1118,10 @@
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
 			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
-						 R8A7791_CLK_THERMAL R8A7791_CLK_PWM>;
+			clock-indices = <
+				R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
+				R8A7791_CLK_THERMAL R8A7791_CLK_PWM
+			>;
 			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
@@ -1129,7 +1131,7 @@
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
 				 <&zx_clk>, <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_EHCI R8A7791_CLK_HSUSB R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
 				R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1 R8A7791_CLK_HSCIF0
 				R8A7791_CLK_SCIF3 R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
@@ -1146,7 +1148,7 @@
 			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_VIN2 R8A7791_CLK_VIN1 R8A7791_CLK_VIN0
 				R8A7791_CLK_ETHER R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
 			>;
@@ -1162,7 +1164,7 @@
 				 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
 				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_GPIO7 R8A7791_CLK_GPIO6 R8A7791_CLK_GPIO5 R8A7791_CLK_GPIO4
 				R8A7791_CLK_GPIO3 R8A7791_CLK_GPIO2 R8A7791_CLK_GPIO1 R8A7791_CLK_GPIO0
 				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD R8A7791_CLK_I2C5
@@ -1212,7 +1214,7 @@
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7791_CLK_SCIFA3 R8A7791_CLK_SCIFA4 R8A7791_CLK_SCIFA5
 			>;
 			clock-output-names = "scifa3", "scifa4", "scifa5";
-- 
1.9.1


From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 18:49:37 +0000
Subject: [PATCH v2 4/6] ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
Message-Id: <1415645379-3366-5-git-send-email-geert+renesas@glider.be>
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
[geert: Extracted r8a7790-specific part, rebased, reworded]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by
---
 arch/arm/boot/dts/r8a7790.dtsi | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a17f5630bcc22bec..46d6898de290d2d0 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1046,7 +1046,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_MSIOF0>;
+			clock-indices = <R8A7790_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks@e6150134 {
@@ -1057,7 +1057,7 @@
 				 <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_VCP1 R8A7790_CLK_VCP0 R8A7790_CLK_VPC1
 				R8A7790_CLK_VPC0 R8A7790_CLK_JPU R8A7790_CLK_SSP1
 				R8A7790_CLK_TMU1 R8A7790_CLK_3DG R8A7790_CLK_2DDMAC
@@ -1079,7 +1079,7 @@
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
 				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
 				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
@@ -1097,7 +1097,7 @@
 				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>, <&mmc0_clk>,
 				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
 				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
 				R8A7790_CLK_IIC0 R8A7790_CLK_PCIEC R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB R8A7790_CLK_CMT1
@@ -1112,8 +1112,10 @@
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
 			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
-						 R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
+			clock-indices = <
+				R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
+				R8A7790_CLK_THERMAL R8A7790_CLK_PWM
+			>;
 			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
@@ -1123,7 +1125,7 @@
 				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
 				 <&zx_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_EHCI R8A7790_CLK_HSUSB R8A7790_CLK_HSCIF1
 				R8A7790_CLK_HSCIF0 R8A7790_CLK_SCIF1 R8A7790_CLK_SCIF0
 				R8A7790_CLK_DU2 R8A7790_CLK_DU1 R8A7790_CLK_DU0
@@ -1139,7 +1141,7 @@
 			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
 				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
 				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER R8A7790_CLK_SATA1
 				R8A7790_CLK_SATA0
@@ -1155,7 +1157,7 @@
 				 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7790_CLK_QSPI>, <&cp_clk>,
 				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_GPIO5 R8A7790_CLK_GPIO4 R8A7790_CLK_GPIO3
 				R8A7790_CLK_GPIO2 R8A7790_CLK_GPIO1 R8A7790_CLK_GPIO0
 				R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0 R8A7790_CLK_QSPI_MOD R8A7790_CLK_IICDVFS
-- 
1.9.1


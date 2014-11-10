From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 18:49:39 +0000
Subject: [PATCH v2 6/6] ARM: shmobile: r8a7794 dtsi: Change to using clock-indices
Message-Id: <1415645379-3366-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

With the addition of clock-indices in commit 8e33f91a0b84ae19 ("clk:
shmobile: clk-mstp: change to using clock-indices"), we can change the
DTSes to use the generic property instead of the deprecated
vendor-specific property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by
---
 arch/arm/boot/dts/r8a7794.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 95f656d22fdeca80..3259d82dd5577269 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -455,7 +455,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7794_CLK_MSIOF0>;
+			clock-indices = <R8A7794_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks@e6150134 {
@@ -465,7 +465,7 @@
 				 <&cp_clk>,
 				 <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_TMU1 R8A7794_CLK_TMU3 R8A7794_CLK_TMU2
 				R8A7794_CLK_CMT0 R8A7794_CLK_TMU0
 			>;
@@ -478,7 +478,7 @@
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_SCIFA2 R8A7794_CLK_SCIFA1 R8A7794_CLK_SCIFA0
 				R8A7794_CLK_MSIOF2 R8A7794_CLK_SCIFB0 R8A7794_CLK_SCIFB1
 				R8A7794_CLK_MSIOF1 R8A7794_CLK_SCIFB2
@@ -492,7 +492,7 @@
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_CMT1
 			>;
 			clock-output-names @@ -504,7 +504,7 @@
 			clocks = <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
@@ -519,7 +519,7 @@
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
 			clocks = <&zg_clk>, <&zg_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0 R8A7794_CLK_ETHER
 			>;
 			clock-output-names @@ -530,7 +530,7 @@
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_SCIFA3 R8A7794_CLK_SCIFA4 R8A7794_CLK_SCIFA5
 			>;
 			clock-output-names = "scifa3", "scifa4", "scifa5";
-- 
1.9.1


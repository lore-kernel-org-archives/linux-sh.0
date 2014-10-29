From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:19:11 +0000
Subject: [PATCH 4/6] ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
Message-Id: <1414592353-24044-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592353-24044-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

From: Ben Dooks <ben.dooks@codethink.co.uk>

With the addition of clock-indices in commit 8e33f91a0b84ae19 ("clk:
shmobile: clk-mstp: change to using clock-indices"), we can change the
DTSes to use the generic property instead of the deprecated
vendor-specific property.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[geert: Extracted r8a7790-specific part, rebased, reworded]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 34f22587555a95ae..7add12c3750aa2fb 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -990,7 +990,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_MSIOF0>;
+			clock-indices = <R8A7790_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks@e6150134 {
@@ -1001,7 +1001,7 @@
 				 <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
 				 <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_VCP1 R8A7790_CLK_VCP0 R8A7790_CLK_VPC1
 				R8A7790_CLK_VPC0 R8A7790_CLK_JPU R8A7790_CLK_SSP1
 				R8A7790_CLK_TMU1 R8A7790_CLK_3DG R8A7790_CLK_2DDMAC
@@ -1023,7 +1023,7 @@
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&zs_clk>,
 				 <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
 				R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
 				R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
@@ -1041,7 +1041,7 @@
 				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks R8A7790_CLK_SD0>, <&mmc0_clk>,
 				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
 				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0 R8A7790_CLK_MMCIF0
 				R8A7790_CLK_IIC0 R8A7790_CLK_PCIEC R8A7790_CLK_IIC1 R8A7790_CLK_SSUSB R8A7790_CLK_CMT1
@@ -1056,7 +1056,7 @@
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
 			clocks = <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
+			clock-indices = <R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
 			clock-output-names = "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
@@ -1066,7 +1066,7 @@
 				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
 				 <&zx_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_EHCI R8A7790_CLK_HSUSB R8A7790_CLK_HSCIF1
 				R8A7790_CLK_HSCIF0 R8A7790_CLK_SCIF1 R8A7790_CLK_SCIF0
 				R8A7790_CLK_DU2 R8A7790_CLK_DU1 R8A7790_CLK_DU0
@@ -1082,7 +1082,7 @@
 			clocks = <&zg_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>, <&p_clk>,
 				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7790_CLK_VIN3 R8A7790_CLK_VIN2 R8A7790_CLK_VIN1
 				R8A7790_CLK_VIN0 R8A7790_CLK_ETHER R8A7790_CLK_SATA1
 				R8A7790_CLK_SATA0
@@ -1098,7 +1098,7 @@
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


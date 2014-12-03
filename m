From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Dec 2014 11:51:45 +0000
Subject: [PATCH] ARM: shmobile: r8a7779 CCF DTS update
Message-Id: <20141203115145.5889.72521.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the r8a7779 CCF DTS with the following fixes:
 - Use MSTP0 for SCIF clock control
 - Use R8A7779_CLK_P as parent clock for SCIF (same as legacy code)
 - Use "clock-indicies" instead of "renesas,clock-indices"

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20141202-v3.18-rc7

 arch/arm/boot/dts/r8a7779.dtsi |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2014-12-03 20:22:26.000000000 +0900
@@ -200,7 +200,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -209,7 +209,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -218,7 +218,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -227,7 +227,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -236,7 +236,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -245,7 +245,7 @@
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
@@ -464,18 +464,18 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
 				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_HSPI R8A7779_CLK_TMU2
 				R8A7779_CLK_TMU1 R8A7779_CLK_TMU0
 				R8A7779_CLK_HSCIF1 R8A7779_CLK_HSCIF0
@@ -506,7 +506,7 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_USB01 R8A7779_CLK_USB2
 				R8A7779_CLK_DU R8A7779_CLK_VIN2
 				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
@@ -527,7 +527,7 @@
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_SDHI3 R8A7779_CLK_SDHI2
 				R8A7779_CLK_SDHI1 R8A7779_CLK_SDHI0
 				R8A7779_CLK_MMC1 R8A7779_CLK_MMC0

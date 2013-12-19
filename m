From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 19 Dec 2013 15:51:02 +0000
Subject: [PATCH 2/6] ARM: shmobile: r8a7791: Add MSIOF clocks in device tree
Message-Id: <1387468266-13625-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 17 +++++++++++++----
 include/dt-bindings/clock/r8a7791-clock.h |  5 +++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 0a82192..6a29341 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -394,6 +394,14 @@
 		};
 
 		/* Gate clocks */
+		mstp0_clks: mstp0_clks@e6150130 {
+			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+			clocks = <&mp_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7791_CLK_MSIOF0>;
+			clock-output-names = "msiof0";
+		};
 		mstp1_clks: mstp1_clks@e6150134 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
@@ -413,15 +421,16 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-				 <&mp_clk>;
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_SCIFA2 R8A7791_CLK_SCIFA1 R8A7791_CLK_SCIFA0
-				R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1 R8A7791_CLK_SCIFB2
+				R8A7791_CLK_MSIOF2 R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1
+				R8A7791_CLK_MSIOF1 R8A7791_CLK_SCIFB2
 			>;
 			clock-output-names -				"scifa2", "scifa1", "scifa0", "scifb0", "scifb1",
-				"scifb2";
+				"scifa2", "scifa1", "scifa0", "misof2", "scifb0",
+				"scifb1", "msiof1", "scifb2";
 		};
 		mstp3_clks: mstp3_clks@e615013c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index df1715b..a69e090 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -21,6 +21,9 @@
 #define R8A7791_CLK_SD0			7
 #define R8A7791_CLK_Z			8
 
+/* MSTP0 */
+#define R8A7791_CLK_MSIOF0		0
+
 /* MSTP1 */
 #define R8A7791_CLK_TMU1		11
 #define R8A7791_CLK_TMU3		21
@@ -35,8 +38,10 @@
 #define R8A7791_CLK_SCIFA2		2
 #define R8A7791_CLK_SCIFA1		3
 #define R8A7791_CLK_SCIFA0		4
+#define R8A7791_CLK_MSIOF2		5
 #define R8A7791_CLK_SCIFB0		6
 #define R8A7791_CLK_SCIFB1		7
+#define R8A7791_CLK_MSIOF1		8
 #define R8A7791_CLK_SCIFB2		16
 #define R8A7791_CLK_DMAC		18
 
-- 
1.8.3.2


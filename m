From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 31 Aug 2015 15:36:39 +0000
Subject: [PATCH 1/3] arm64: dts: r8a7795: add GPIO clocks
Message-Id: <1441035401-5843-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[horms: moved into clock node; removed non-clock nodes; updated changelog;
        used R8A7795 as prefix for clock defines]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[uli: removed clock-output-names]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 24 ++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0df0dea..ca1970d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -70,6 +70,14 @@
 			#clock-cells = <1>;
 			ranges;
 
+			cp_clk: cp_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&extal_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
 			zt_clk: zt {
 				compatible = "fixed-factor-clock";
 				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
@@ -274,6 +282,22 @@
 					#clock-cells = <1>;
 					clock-indices = <R8A7795_CLK_SCIF2>;
 				};
+
+				mstp9_clks: mstp9_clks@e6150994 {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+					clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
+						 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+						 <&cp_clk>, <&cp_clk>;
+					#clock-cells = <1>;
+					clock-indices = <
+						R8A7795_CLK_GPIO7 R8A7795_CLK_GPIO6
+						R8A7795_CLK_GPIO5 R8A7795_CLK_GPIO4
+						R8A7795_CLK_GPIO3 R8A7795_CLK_GPIO2
+						R8A7795_CLK_GPIO1 R8A7795_CLK_GPIO0
+					>;
+				};
 			};
 		};
 
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index d661602..bf7fd98 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -38,6 +38,14 @@
 /* MSTP8 */
 
 /* MSTP9 */
+#define R8A7795_CLK_GPIO0		12
+#define R8A7795_CLK_GPIO1		11
+#define R8A7795_CLK_GPIO2		10
+#define R8A7795_CLK_GPIO3		9
+#define R8A7795_CLK_GPIO4		8
+#define R8A7795_CLK_GPIO5		7
+#define R8A7795_CLK_GPIO6		6
+#define R8A7795_CLK_GPIO7		5
 
 /* MSTP10 */
 
-- 
2.4.6


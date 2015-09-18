From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:05:10 +0000
Subject: [PATCH 08/18 v3] arm64: renesas: r8a7795: Sound CTU/MIX support
Message-Id: <871tdw1o6g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - new patch

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 22 ++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b57e81c..1fddf55 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -536,6 +536,7 @@
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>;
 					clock-indices = <
 						R8A7795_CLK_SSI_ALL
@@ -543,6 +544,7 @@
 						R8A7795_CLK_SSI4 R8A7795_CLK_SSI3 R8A7795_CLK_SSI2 R8A7795_CLK_SSI1 R8A7795_CLK_SSI0
 						R8A7795_CLK_SCU_ALL
 						R8A7795_CLK_SCU_DVC1 R8A7795_CLK_SCU_DVC0
+						R8A7795_CLK_SCU_CTU1_MIX1 R8A7795_CLK_SCU_CTU0_MIX0
 						R8A7795_CLK_SCU_SRC9 R8A7795_CLK_SCU_SRC8 R8A7795_CLK_SCU_SRC7 R8A7795_CLK_SCU_SRC6 R8A7795_CLK_SCU_SRC5
 						R8A7795_CLK_SCU_SRC4 R8A7795_CLK_SCU_SRC3 R8A7795_CLK_SCU_SRC2 R8A7795_CLK_SCU_SRC1 R8A7795_CLK_SCU_SRC0
 					>;
@@ -1015,6 +1017,8 @@
 				<&mstp10_clks R8A7795_CLK_SCU_SRC5>, <&mstp10_clks R8A7795_CLK_SCU_SRC4>,
 				<&mstp10_clks R8A7795_CLK_SCU_SRC3>, <&mstp10_clks R8A7795_CLK_SCU_SRC2>,
 				<&mstp10_clks R8A7795_CLK_SCU_SRC1>, <&mstp10_clks R8A7795_CLK_SCU_SRC0>,
+				<&mstp10_clks R8A7795_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7795_CLK_SCU_CTU1_MIX1>,
+				<&mstp10_clks R8A7795_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7795_CLK_SCU_CTU1_MIX1>,
 				<&mstp10_clks R8A7795_CLK_SCU_DVC0>, <&mstp10_clks R8A7795_CLK_SCU_DVC1>,
 				<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&s0d4_clk>;
 			clock-names = "ssi-all",
@@ -1022,6 +1026,8 @@
 					"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
 					"src.9", "src.8", "src.7", "src.6", "src.5",
 					"src.4", "src.3", "src.2", "src.1", "src.0",
+					"ctu.0", "ctu.1",
+					"mix.0", "mix.1",
 					"dvc.0", "dvc.1",
 					"clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&cpg_clocks>;
@@ -1038,6 +1044,22 @@
 				};
 			};
 
+			rcar_sound,mix {
+				mix0: mix@0 { };
+				mix1: mix@1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu@0 { };
+				ctu01: ctu@1 { };
+				ctu02: ctu@2 { };
+				ctu03: ctu@3 { };
+				ctu10: ctu@4 { };
+				ctu11: ctu@5 { };
+				ctu12: ctu@6 { };
+				ctu13: ctu@7 { };
+			};
+
 			rcar_sound,src {
 				src0: src@0 {
 					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 74ca804..cc66a06 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -90,6 +90,8 @@
 #define R8A7795_CLK_SCU_ALL		17
 #define R8A7795_CLK_SCU_DVC1		18
 #define R8A7795_CLK_SCU_DVC0		19
+#define R8A7795_CLK_SCU_CTU1_MIX1	20
+#define R8A7795_CLK_SCU_CTU0_MIX0	21
 #define R8A7795_CLK_SCU_SRC9		22
 #define R8A7795_CLK_SCU_SRC8		23
 #define R8A7795_CLK_SCU_SRC7		24
-- 
1.9.1


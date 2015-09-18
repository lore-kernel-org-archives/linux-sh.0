From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:04:49 +0000
Subject: [PATCH 07/18 v3] arm64: renesas: r8a7795: Sound DVC support
Message-Id: <8737yc1o71.wl%kuninori.morimoto.gx@renesas.com>
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

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 15 +++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fdce918..b57e81c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -535,12 +535,14 @@
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
 						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>;
 					clock-indices = <
 						R8A7795_CLK_SSI_ALL
 						R8A7795_CLK_SSI9 R8A7795_CLK_SSI8 R8A7795_CLK_SSI7 R8A7795_CLK_SSI6 R8A7795_CLK_SSI5
 						R8A7795_CLK_SSI4 R8A7795_CLK_SSI3 R8A7795_CLK_SSI2 R8A7795_CLK_SSI1 R8A7795_CLK_SSI0
 						R8A7795_CLK_SCU_ALL
+						R8A7795_CLK_SCU_DVC1 R8A7795_CLK_SCU_DVC0
 						R8A7795_CLK_SCU_SRC9 R8A7795_CLK_SCU_SRC8 R8A7795_CLK_SCU_SRC7 R8A7795_CLK_SCU_SRC6 R8A7795_CLK_SCU_SRC5
 						R8A7795_CLK_SCU_SRC4 R8A7795_CLK_SCU_SRC3 R8A7795_CLK_SCU_SRC2 R8A7795_CLK_SCU_SRC1 R8A7795_CLK_SCU_SRC0
 					>;
@@ -1013,16 +1015,29 @@
 				<&mstp10_clks R8A7795_CLK_SCU_SRC5>, <&mstp10_clks R8A7795_CLK_SCU_SRC4>,
 				<&mstp10_clks R8A7795_CLK_SCU_SRC3>, <&mstp10_clks R8A7795_CLK_SCU_SRC2>,
 				<&mstp10_clks R8A7795_CLK_SCU_SRC1>, <&mstp10_clks R8A7795_CLK_SCU_SRC0>,
+				<&mstp10_clks R8A7795_CLK_SCU_DVC0>, <&mstp10_clks R8A7795_CLK_SCU_DVC1>,
 				<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&s0d4_clk>;
 			clock-names = "ssi-all",
 					"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 					"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
 					"src.9", "src.8", "src.7", "src.6", "src.5",
 					"src.4", "src.3", "src.2", "src.1", "src.0",
+					"dvc.0", "dvc.1",
 					"clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 
+			rcar_sound,dvc {
+				dvc0: dvc@0 {
+					dmas = <&audma0 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc@1 {
+					dmas = <&audma0 0xbe>;
+					dma-names = "tx";
+				};
+			};
+
 			rcar_sound,src {
 				src0: src@0 {
 					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 5e721b2..74ca804 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -88,6 +88,8 @@
 #define R8A7795_CLK_SSI1		14
 #define R8A7795_CLK_SSI0		15
 #define R8A7795_CLK_SCU_ALL		17
+#define R8A7795_CLK_SCU_DVC1		18
+#define R8A7795_CLK_SCU_DVC0		19
 #define R8A7795_CLK_SCU_SRC9		22
 #define R8A7795_CLK_SCU_SRC8		23
 #define R8A7795_CLK_SCU_SRC7		24
-- 
1.9.1


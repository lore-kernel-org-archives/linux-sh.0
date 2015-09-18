From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:04:33 +0000
Subject: [PATCH 06/18 v3] arm64: renesas: r8a7795: Sound SRC support
Message-Id: <874mis1o7j.wl%kuninori.morimoto.gx@renesas.com>
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

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 71 ++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7795-clock.h | 11 +++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index bdb0273..fdce918 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -529,11 +529,20 @@
 						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
 						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
 						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
-						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>;
+						<&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
+						<&s3d4_clk>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>,
+						<&mstp10_clks R8A7795_CLK_SCU_ALL>, <&mstp10_clks R8A7795_CLK_SCU_ALL>;
 					clock-indices = <
 						R8A7795_CLK_SSI_ALL
 						R8A7795_CLK_SSI9 R8A7795_CLK_SSI8 R8A7795_CLK_SSI7 R8A7795_CLK_SSI6 R8A7795_CLK_SSI5
 						R8A7795_CLK_SSI4 R8A7795_CLK_SSI3 R8A7795_CLK_SSI2 R8A7795_CLK_SSI1 R8A7795_CLK_SSI0
+						R8A7795_CLK_SCU_ALL
+						R8A7795_CLK_SCU_SRC9 R8A7795_CLK_SCU_SRC8 R8A7795_CLK_SCU_SRC7 R8A7795_CLK_SCU_SRC6 R8A7795_CLK_SCU_SRC5
+						R8A7795_CLK_SCU_SRC4 R8A7795_CLK_SCU_SRC3 R8A7795_CLK_SCU_SRC2 R8A7795_CLK_SCU_SRC1 R8A7795_CLK_SCU_SRC0
 					>;
 				};
 			};
@@ -999,14 +1008,74 @@
 				<&mstp10_clks R8A7795_CLK_SSI5>, <&mstp10_clks R8A7795_CLK_SSI4>,
 				<&mstp10_clks R8A7795_CLK_SSI3>, <&mstp10_clks R8A7795_CLK_SSI2>,
 				<&mstp10_clks R8A7795_CLK_SSI1>, <&mstp10_clks R8A7795_CLK_SSI0>,
+				<&mstp10_clks R8A7795_CLK_SCU_SRC9>, <&mstp10_clks R8A7795_CLK_SCU_SRC8>,
+				<&mstp10_clks R8A7795_CLK_SCU_SRC7>, <&mstp10_clks R8A7795_CLK_SCU_SRC6>,
+				<&mstp10_clks R8A7795_CLK_SCU_SRC5>, <&mstp10_clks R8A7795_CLK_SCU_SRC4>,
+				<&mstp10_clks R8A7795_CLK_SCU_SRC3>, <&mstp10_clks R8A7795_CLK_SCU_SRC2>,
+				<&mstp10_clks R8A7795_CLK_SCU_SRC1>, <&mstp10_clks R8A7795_CLK_SCU_SRC0>,
 				<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&s0d4_clk>;
 			clock-names = "ssi-all",
 					"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 					"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+					"src.9", "src.8", "src.7", "src.6", "src.5",
+					"src.4", "src.3", "src.2", "src.1", "src.0",
 					"clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 
+			rcar_sound,src {
+				src0: src@0 {
+					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x85>, <&audma1 0x9a>;
+					dma-names = "rx", "tx";
+				};
+				src1: src@1 {
+					interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x87>, <&audma1 0x9c>;
+					dma-names = "rx", "tx";
+				};
+				src2: src@2 {
+					interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x89>, <&audma1 0x9e>;
+					dma-names = "rx", "tx";
+				};
+				src3: src@3 {
+					interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
+					dma-names = "rx", "tx";
+				};
+				src4: src@4 {
+					interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
+					dma-names = "rx", "tx";
+				};
+				src5: src@5 {
+					interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
+					dma-names = "rx", "tx";
+				};
+				src6: src@6 {
+					interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x91>, <&audma1 0xb4>;
+					dma-names = "rx", "tx";
+				};
+				src7: src@7 {
+					interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x93>, <&audma1 0xb6>;
+					dma-names = "rx", "tx";
+				};
+				src8: src@8 {
+					interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x95>, <&audma1 0xb8>;
+					dma-names = "rx", "tx";
+				};
+				src9: src@9 {
+					interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x97>, <&audma1 0xba>;
+					dma-names = "rx", "tx";
+				};
+			};
+
 			rcar_sound,ssi {
 				ssi0: ssi@0 {
 					interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index c4cacd9..5e721b2 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -87,5 +87,16 @@
 #define R8A7795_CLK_SSI2		13
 #define R8A7795_CLK_SSI1		14
 #define R8A7795_CLK_SSI0		15
+#define R8A7795_CLK_SCU_ALL		17
+#define R8A7795_CLK_SCU_SRC9		22
+#define R8A7795_CLK_SCU_SRC8		23
+#define R8A7795_CLK_SCU_SRC7		24
+#define R8A7795_CLK_SCU_SRC6		25
+#define R8A7795_CLK_SCU_SRC5		26
+#define R8A7795_CLK_SCU_SRC4		27
+#define R8A7795_CLK_SCU_SRC3		28
+#define R8A7795_CLK_SCU_SRC2		29
+#define R8A7795_CLK_SCU_SRC1		30
+#define R8A7795_CLK_SCU_SRC0		31
 
 #endif /* __DT_BINDINGS_CLOCK_R8A7795_H__ */
-- 
1.9.1


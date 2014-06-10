From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Jun 2014 08:10:11 +0000
Subject: [PATCH 2/3 v2] ARM: shmobile: r8a7790: add R-Car sound support on DTSI
Message-Id: <87bnu1chhx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch support PIO transfer only at this point

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- follow [PATCH 1/3 v2] patch

 arch/arm/boot/dts/r8a7790.dtsi |   56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index dcf7e1e..99fa33c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -919,4 +919,60 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	rcar_sound: rcar_sound@0xec500000 {
+		#sound-dai-cells = <1>;
+		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
+		interrupt-parent = <&gic>;
+		reg =	<0 0xec500000 0 0x1000>, /* SCU */
+			<0 0xec5a0000 0 0x100>,  /* ADG */
+			<0 0xec540000 0 0x1000>, /* SSIU */
+			<0 0xec541000 0 0x1280>; /* SSI */
+		clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
+			<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
+			<&mstp10_clks R8A7790_CLK_SSI7>, <&mstp10_clks R8A7790_CLK_SSI6>,
+			<&mstp10_clks R8A7790_CLK_SSI5>, <&mstp10_clks R8A7790_CLK_SSI4>,
+			<&mstp10_clks R8A7790_CLK_SSI3>, <&mstp10_clks R8A7790_CLK_SSI2>,
+			<&mstp10_clks R8A7790_CLK_SSI1>, <&mstp10_clks R8A7790_CLK_SSI0>,
+			<&mstp10_clks R8A7790_CLK_SCU_SRC9>, <&mstp10_clks R8A7790_CLK_SCU_SRC8>,
+			<&mstp10_clks R8A7790_CLK_SCU_SRC7>, <&mstp10_clks R8A7790_CLK_SCU_SRC6>,
+			<&mstp10_clks R8A7790_CLK_SCU_SRC5>, <&mstp10_clks R8A7790_CLK_SCU_SRC4>,
+			<&mstp10_clks R8A7790_CLK_SCU_SRC3>, <&mstp10_clks R8A7790_CLK_SCU_SRC2>,
+			<&mstp10_clks R8A7790_CLK_SCU_SRC1>, <&mstp10_clks R8A7790_CLK_SCU_SRC0>,
+			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
+		clock-names = "ssi-all",
+				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+				"src.9", "src.8", "src.7", "src.6", "src.5",
+				"src.4", "src.3", "src.2", "src.1", "src.0",
+				"clk_a", "clk_b", "clk_c", "clk_i";
+
+		status = "disabled";
+
+		rcar_sound,src {
+			src0: src@0 { };
+			src1: src@1 { };
+			src2: src@2 { };
+			src3: src@3 { };
+			src4: src@4 { };
+			src5: src@5 { };
+			src6: src@6 { };
+			src7: src@7 { };
+			src8: src@8 { };
+			src9: src@9 { };
+		};
+
+		rcar_sound,ssi {
+			ssi0: ssi@0 { interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi1: ssi@1 { interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi2: ssi@2 { interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi3: ssi@3 { interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi4: ssi@4 { interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi5: ssi@5 { interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi6: ssi@6 { interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi7: ssi@7 { interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi8: ssi@8 { interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
+		};
+	};
 };
-- 
1.7.9.5


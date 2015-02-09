From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 09 Feb 2015 16:02:38 +0000
Subject: [PATCH v2 10/15] ARM: shmobile: r8a7778: add sound to DT
Message-Id: <1423497763-3450-11-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds an entry for an R-Car Gen. 1 sound controller.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 98ad685..8700e2e 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -220,6 +220,61 @@
 		status = "disabled";
 	};
 
+	rcar_sound: rcar_sound@ffd90000 {
+		#sound-dai-cells = <1>;
+		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1", "renesas,rcar_sound";
+		reg =	<0xffd90000 0x1000>,	/* SRU */
+			<0xffd91000 0x1240>,	/* SSI */
+			<0xfffe0000 0x24>;	/* ADG */
+		clocks = <&mstp3_clks R8A7778_CLK_SSI8>,
+			<&mstp3_clks R8A7778_CLK_SSI7>,
+			<&mstp3_clks R8A7778_CLK_SSI6>,
+			<&mstp3_clks R8A7778_CLK_SSI5>,
+			<&mstp3_clks R8A7778_CLK_SSI4>,
+			<&mstp0_clks R8A7778_CLK_SSI3>,
+			<&mstp0_clks R8A7778_CLK_SSI2>,
+			<&mstp0_clks R8A7778_CLK_SSI1>,
+			<&mstp0_clks R8A7778_CLK_SSI0>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC8>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC7>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC6>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC5>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC4>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC3>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC2>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC1>,
+			<&mstp5_clks R8A7778_CLK_SCU_SRC0>,
+			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+			<&cpg_clocks R8A7778_CLK_S1>;
+		clock-names = "ssi.8", "ssi.7", "ssi.6", "ssi.5", "ssi.4",
+			"ssi.3", "ssi.2", "ssi.1", "ssi.0",
+			"src.8", "src.7", "src.6", "src.5", "src.4",
+			"src.3", "src.2", "src.1", "src.0",
+			"clk_a", "clk_b", "clk_c", "clk_i";
+
+		status = "disabled";
+
+		rcar_sound,src {
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
+			ssi3: ssi@3 { interrupts = <0 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi4: ssi@4 { interrupts = <0 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi5: ssi@5 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi6: ssi@6 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi7: ssi@7 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi8: ssi@8 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi9: ssi@9 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+		};
+	};
+
 	scif0: serial@ffe40000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-- 
2.2.2


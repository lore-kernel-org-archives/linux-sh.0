From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Jan 2016 02:37:57 +0000
Subject: [PATCH v3 04/14] ARM: shmobile: r8a7793: add R-Car sound support to device tree
Message-Id: <1452825487-15931-5-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452825487-15931-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1452825487-15931-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instantiate R-Car sound node in r8a7793 device tree.
This only supports PIO transfers.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index fa8a0d772d51..90959a925edd 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1101,4 +1101,87 @@
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
+
+	rcar_sound: sound@ec500000 {
+		/*
+		 * #sound-dai-cells is required
+		 *
+		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+		 */
+		compatible =  "renesas,rcar_sound-r8a7793", "renesas,rcar_sound-gen2";
+		reg =	<0 0xec500000 0 0x1000>, /* SCU */
+			<0 0xec5a0000 0 0x100>,  /* ADG */
+			<0 0xec540000 0 0x1000>, /* SSIU */
+			<0 0xec541000 0 0x280>;  /* SSI */
+		reg-names = "scu", "adg", "ssiu", "ssi";
+
+		clocks = <&mstp10_clks R8A7793_CLK_SSI_ALL>,
+			<&mstp10_clks R8A7793_CLK_SSI9>, <&mstp10_clks R8A7793_CLK_SSI8>,
+			<&mstp10_clks R8A7793_CLK_SSI7>, <&mstp10_clks R8A7793_CLK_SSI6>,
+			<&mstp10_clks R8A7793_CLK_SSI5>, <&mstp10_clks R8A7793_CLK_SSI4>,
+			<&mstp10_clks R8A7793_CLK_SSI3>, <&mstp10_clks R8A7793_CLK_SSI2>,
+			<&mstp10_clks R8A7793_CLK_SSI1>, <&mstp10_clks R8A7793_CLK_SSI0>,
+			<&mstp10_clks R8A7793_CLK_SCU_SRC9>, <&mstp10_clks R8A7793_CLK_SCU_SRC8>,
+			<&mstp10_clks R8A7793_CLK_SCU_SRC7>, <&mstp10_clks R8A7793_CLK_SCU_SRC6>,
+			<&mstp10_clks R8A7793_CLK_SCU_SRC5>, <&mstp10_clks R8A7793_CLK_SCU_SRC4>,
+			<&mstp10_clks R8A7793_CLK_SCU_SRC3>, <&mstp10_clks R8A7793_CLK_SCU_SRC2>,
+			<&mstp10_clks R8A7793_CLK_SCU_SRC1>, <&mstp10_clks R8A7793_CLK_SCU_SRC0>,
+			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
+		clock-names = "ssi-all",
+				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+				"src.9", "src.8", "src.7", "src.6", "src.5",
+				"src.4", "src.3", "src.2", "src.1", "src.0",
+				"clk_a", "clk_b", "clk_c", "clk_i";
+		power-domains = <&cpg_clocks>;
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
+			ssi0: ssi@0 {
+				interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi1: ssi@1 {
+				 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi2: ssi@2 {
+				interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi3: ssi@3 {
+				interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi4: ssi@4 {
+				interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi5: ssi@5 {
+				interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi6: ssi@6 {
+				interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi7: ssi@7 {
+				interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi8: ssi@8 {
+				interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi9: ssi@9 {
+				interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
 };
-- 
2.1.4


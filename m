From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Dec 2015 02:52:55 +0000
Subject: [PATCH/RFC 18/19] ARM: shmobile: r8a7793: Add Audio CTU support to device tree
Message-Id: <1449802376-11301-19-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instantiate audio CTU support in r8a7793 device tee.

Based on similar work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index ed2acd9967b1..d9ba1c97cefc 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1178,6 +1178,7 @@
 			<&mstp10_clks R8A7793_CLK_SCU_SRC5>, <&mstp10_clks R8A7793_CLK_SCU_SRC4>,
 			<&mstp10_clks R8A7793_CLK_SCU_SRC3>, <&mstp10_clks R8A7793_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7793_CLK_SCU_SRC1>, <&mstp10_clks R8A7793_CLK_SCU_SRC0>,
+			<&mstp10_clks R8A7793_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7793_CLK_SCU_CTU1_MIX1>,
 			<&mstp10_clks R8A7793_CLK_SCU_DVC0>, <&mstp10_clks R8A7793_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
@@ -1185,6 +1186,7 @@
 				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
+				"ctu.0", "ctu.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&cpg_clocks>;
@@ -1202,6 +1204,17 @@
 			};
 		};
 
+		rcar_sound,ctu {
+			ctu00: ctu@0 { };
+			ctu01: ctu@1 { };
+			ctu02: ctu@2 { };
+			ctu03: ctu@3 { };
+			ctu10: ctu@4 { };
+			ctu11: ctu@5 { };
+			ctu12: ctu@6 { };
+			ctu13: ctu@7 { };
+		};
+
 		rcar_sound,src {
 			src0: src@0 {
 				interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4


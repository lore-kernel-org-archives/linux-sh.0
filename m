From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jul 2015 00:26:42 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7790: Add Audio MIX support on DTSI
Message-Id: <87r3o2cq9h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txj898qu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txj898qu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6aa1d75..f1cdccc 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1540,6 +1540,7 @@
 			<&mstp10_clks R8A7790_CLK_SCU_SRC3>, <&mstp10_clks R8A7790_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7790_CLK_SCU_SRC1>, <&mstp10_clks R8A7790_CLK_SCU_SRC0>,
 			<&mstp10_clks R8A7790_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7790_CLK_SCU_CTU1_MIX1>,
+			<&mstp10_clks R8A7790_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7790_CLK_SCU_CTU1_MIX1>,
 			<&mstp10_clks R8A7790_CLK_SCU_DVC0>, <&mstp10_clks R8A7790_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
@@ -1548,6 +1549,7 @@
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"ctu.0", "ctu.1",
+				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
@@ -1564,6 +1566,11 @@
 			};
 		};
 
+		rcar_sound,mix {
+			mix0: mix@0 { };
+			mix1: mix@1 { };
+		};
+
 		rcar_sound,ctu {
 			ctu00: ctu@0 { };
 			ctu01: ctu@1 { };
-- 
1.9.1


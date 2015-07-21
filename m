From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jul 2015 00:27:24 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: Add Audio MIX support on DTSI
Message-Id: <87oaj6cq8a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index cdd55b8..d37339bd7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1586,6 +1586,7 @@
 			<&mstp10_clks R8A7791_CLK_SCU_SRC3>, <&mstp10_clks R8A7791_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7791_CLK_SCU_SRC1>, <&mstp10_clks R8A7791_CLK_SCU_SRC0>,
 			<&mstp10_clks R8A7791_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7791_CLK_SCU_CTU1_MIX1>,
+			<&mstp10_clks R8A7791_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7791_CLK_SCU_CTU1_MIX1>,
 			<&mstp10_clks R8A7791_CLK_SCU_DVC0>, <&mstp10_clks R8A7791_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
@@ -1594,6 +1595,7 @@
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"ctu.0", "ctu.1",
+				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
@@ -1610,6 +1612,11 @@
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


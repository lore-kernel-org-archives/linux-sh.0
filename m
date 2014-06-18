From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:13:58 +0000
Subject: [PATCH 02/10] ARM: shmobile: r8a7791: add DVC support on DTSI
Message-Id: <877g4ey3zc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1997f16..336a6c0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1005,16 +1005,23 @@
 			<&mstp10_clks R8A7791_CLK_SCU_SRC5>, <&mstp10_clks R8A7791_CLK_SCU_SRC4>,
 			<&mstp10_clks R8A7791_CLK_SCU_SRC3>, <&mstp10_clks R8A7791_CLK_SCU_SRC2>,
 			<&mstp10_clks R8A7791_CLK_SCU_SRC1>, <&mstp10_clks R8A7791_CLK_SCU_SRC0>,
+			<&mstp10_clks R8A7791_CLK_SCU_DVC0>, <&mstp10_clks R8A7791_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
 				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
 				"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
 				"src.9", "src.8", "src.7", "src.6", "src.5",
 				"src.4", "src.3", "src.2", "src.1", "src.0",
+				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
 		status = "disabled";
 
+		rcar_sound,dvc {
+			dvc0: dvc@0 { };
+			dvc1: dvc@1 { };
+		};
+
 		rcar_sound,src {
 			src0: src@0 { };
 			src1: src@1 { };
-- 
1.7.9.5


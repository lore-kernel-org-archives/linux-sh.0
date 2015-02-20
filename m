From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:32:15 +0000
Subject: [PATCH 22/24 v2] ASoC: rsnd: add sample code of missing clocks
Message-Id: <87k2zcna7z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 .../devicetree/bindings/sound/renesas,rsnd.txt     |   21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 87e0fc2..503967b 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -47,6 +47,27 @@ rcar_sound: rcar_sound@ec500000 {
 		<0 0xec540000 0 0x1000>, /* SSIU */
 		<0 0xec541000 0 0x1280>; /* SSI */
 
+	clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
+		<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
+		<&mstp10_clks R8A7790_CLK_SSI7>, <&mstp10_clks R8A7790_CLK_SSI6>,
+		<&mstp10_clks R8A7790_CLK_SSI5>, <&mstp10_clks R8A7790_CLK_SSI4>,
+		<&mstp10_clks R8A7790_CLK_SSI3>, <&mstp10_clks R8A7790_CLK_SSI2>,
+		<&mstp10_clks R8A7790_CLK_SSI1>, <&mstp10_clks R8A7790_CLK_SSI0>,
+		<&mstp10_clks R8A7790_CLK_SCU_SRC9>, <&mstp10_clks R8A7790_CLK_SCU_SRC8>,
+		<&mstp10_clks R8A7790_CLK_SCU_SRC7>, <&mstp10_clks R8A7790_CLK_SCU_SRC6>,
+		<&mstp10_clks R8A7790_CLK_SCU_SRC5>, <&mstp10_clks R8A7790_CLK_SCU_SRC4>,
+		<&mstp10_clks R8A7790_CLK_SCU_SRC3>, <&mstp10_clks R8A7790_CLK_SCU_SRC2>,
+		<&mstp10_clks R8A7790_CLK_SCU_SRC1>, <&mstp10_clks R8A7790_CLK_SCU_SRC0>,
+		<&mstp10_clks R8A7790_CLK_SCU_DVC0>, <&mstp10_clks R8A7790_CLK_SCU_DVC1>,
+		<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
+	clock-names = "ssi-all",
+			"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+			"ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
+			"src.9", "src.8", "src.7", "src.6", "src.5",
+			"src.4", "src.3", "src.2", "src.1", "src.0",
+			"dvc.0", "dvc.1",
+			"clk_a", "clk_b", "clk_c", "clk_i";
+
 	rcar_sound,dvc {
 		dvc0: dvc@0 { };
 		dvc1: dvc@1 { };
-- 
1.7.9.5


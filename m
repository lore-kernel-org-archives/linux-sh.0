From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jun 2014 00:57:42 +0000
Subject: [PATCH 07/10 v2] ASoC: rsnd: enable SRC setting via DT
Message-Id: <87vbrssar8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
	<8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

some special board wants to exchange sampling rate by using SRC.
This patch enables its settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - src_node -> np on of_property_read_u32()

 .../devicetree/bindings/sound/renesas,rsnd.txt     |    2 +-
 sound/soc/sh/rcar/src.c                            |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 41a120c..1d88d42 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -24,7 +24,7 @@ SSI subnode properties:
 - no-busif			: BUSIF is not ussed when [mem -> SSI] via DMA case
 
 SRC subnode properties:
-no properties at this point
+- convert-rate			: SRC convert rate if needed
 
 DAI subnode properties:
 - playback			: list of playback modules
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 4d39505..7f3c7d7 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -612,11 +612,11 @@ static void rsnd_of_parse_src(struct platform_device *pdev,
 			      const struct rsnd_of_data *of_data,
 			      struct rsnd_priv *priv)
 {
-	struct device_node *src_node;
+	struct device_node *src_node, *np;
 	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
 	struct rsnd_src_platform_info *src_info;
 	struct device *dev = &pdev->dev;
-	int nr;
+	int nr, i;
 
 	if (!of_data)
 		return;
@@ -640,6 +640,16 @@ static void rsnd_of_parse_src(struct platform_device *pdev,
 	info->src_info		= src_info;
 	info->src_info_nr	= nr;
 
+	i = 0;
+	for_each_child_of_node(src_node, np) {
+		src_info = info->src_info + i;
+
+		of_property_read_u32(np, "convert-rate",
+				     &src_info->convert_rate);
+
+		i++;
+	}
+
 rsnd_of_parse_src_end:
 	of_node_put(src_node);
 }
-- 
1.7.9.5


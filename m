From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jun 2014 00:59:28 +0000
Subject: [PATCH 10/10 v2] ASoC: rsnd: add DT support to DVC
Message-Id: <87r42gsaoa.wl%kuninori.morimoto.gx@renesas.com>
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

Now, DVC can use DT

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 .../devicetree/bindings/sound/renesas,rsnd.txt     |    8 +++++
 sound/soc/sh/rcar/core.c                           |   13 +++++--
 sound/soc/sh/rcar/dvc.c                            |   38 ++++++++++++++++++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 1d88d42..652573e 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -13,6 +13,9 @@ Required properties:
 - rcar_sound,src		: Should contain SRC feature.
 				  The number of SRC subnode should be same as HW.
 				  see below for detail.
+- rcar_sound,dvc		: Should contain DVC feature.
+				  The number of DVC subnode should be same as HW.
+				  see below for detail.
 - rcar_sound,dai		: DAI contents.
 				  The number of DAI subnode should be same as HW.
 				  see below for detail.
@@ -40,6 +43,11 @@ rcar_sound: rcar_sound@0xffd90000 {
 		<0 0xec540000 0 0x1000>, /* SSIU */
 		<0 0xec541000 0 0x1280>; /* SSI */
 
+	rcar_sound,dvc {
+		dvc0: dvc@0 { };
+		dvc1: dvc@1 { };
+	};
+
 	rcar_sound,src {
 		src0: src@0 { };
 		src1: src@1 { };
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 49d9b31..907d480 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -286,7 +286,13 @@ static void rsnd_dma_of_path(struct rsnd_dma *dma,
 			mod[i] = src;
 			src = NULL;
 		} else {
-			mod[i] = dvc;
+			if ((!is_play) && (this = src))
+				this = dvc;
+
+			mod[i] = (is_play) ? src : dvc;
+			i++;
+			mod[i] = (is_play) ? dvc : src;
+			src = NULL;
 			dvc = NULL;
 		}
 
@@ -719,12 +725,13 @@ static void rsnd_of_parse_dai(struct platform_device *pdev,
 	struct device_node *dai_node,	*dai_np;
 	struct device_node *ssi_node,	*ssi_np;
 	struct device_node *src_node,	*src_np;
+	struct device_node *dvc_node,	*dvc_np;
 	struct device_node *playback, *capture;
 	struct rsnd_dai_platform_info *dai_info;
 	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
 	struct device *dev = &pdev->dev;
 	int nr, i;
-	int dai_i, ssi_i, src_i;
+	int dai_i, ssi_i, src_i, dvc_i;
 
 	if (!of_data)
 		return;
@@ -750,6 +757,7 @@ static void rsnd_of_parse_dai(struct platform_device *pdev,
 
 	ssi_node = of_get_child_by_name(dev->of_node, "rcar_sound,ssi");
 	src_node = of_get_child_by_name(dev->of_node, "rcar_sound,src");
+	dvc_node = of_get_child_by_name(dev->of_node, "rcar_sound,dvc");
 
 #define mod_parse(name)							\
 if (name##_node) {							\
@@ -785,6 +793,7 @@ if (name##_node) {							\
 
 			mod_parse(ssi);
 			mod_parse(src);
+			mod_parse(dvc);
 
 			if (playback)
 				of_node_put(playback);
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index deef310..9096fb0 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -235,6 +235,42 @@ struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id)
 	return &((struct rsnd_dvc *)(priv->dvc) + id)->mod;
 }
 
+static void rsnd_of_parse_dvc(struct platform_device *pdev,
+			      const struct rsnd_of_data *of_data,
+			      struct rsnd_priv *priv)
+{
+	struct device_node *node;
+	struct rsnd_dvc_platform_info *dvc_info;
+	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
+	struct device *dev = &pdev->dev;
+	int nr;
+
+	if (!of_data)
+		return;
+
+	node = of_get_child_by_name(dev->of_node, "rcar_sound,dvc");
+	if (!node)
+		return;
+
+	nr = of_get_child_count(node);
+	if (!nr)
+		goto rsnd_of_parse_dvc_end;
+
+	dvc_info = devm_kzalloc(dev,
+				sizeof(struct rsnd_dvc_platform_info) * nr,
+				GFP_KERNEL);
+	if (!dvc_info) {
+		dev_err(dev, "dvc info allocation error\n");
+		goto rsnd_of_parse_dvc_end;
+	}
+
+	info->dvc_info		= dvc_info;
+	info->dvc_info_nr	= nr;
+
+rsnd_of_parse_dvc_end:
+	of_node_put(node);
+}
+
 int rsnd_dvc_probe(struct platform_device *pdev,
 		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
@@ -246,6 +282,8 @@ int rsnd_dvc_probe(struct platform_device *pdev,
 	char name[RSND_DVC_NAME_SIZE];
 	int i, nr;
 
+	rsnd_of_parse_dvc(pdev, of_data, priv);
+
 	nr = info->dvc_info_nr;
 	if (!nr)
 		return 0;
-- 
1.7.9.5


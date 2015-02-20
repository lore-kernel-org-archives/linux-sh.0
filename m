From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:30:22 +0000
Subject: [PATCH 18/24 v2] ASoC: rsnd: src: add rsnd_src_of_node()
Message-Id: <87pp94nab6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds rsnd_src_of_node() to get SRC subnode from DT.
This is prepare for new DT bindings for 1st DMAC

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 sound/soc/sh/rcar/src.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index e279205..5a601be 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -28,6 +28,9 @@ struct rsnd_src {
 #define RSND_SRC_NAME_SIZE 16
 
 #define rsnd_src_convert_rate(p) ((p)->info->convert_rate)
+#define rsnd_src_of_node(priv) \
+	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,src")
+
 #define rsnd_mod_to_src(_mod)				\
 	container_of((_mod), struct rsnd_src, mod)
 
@@ -807,7 +810,7 @@ static void rsnd_of_parse_src(struct platform_device *pdev,
 	if (!of_data)
 		return;
 
-	src_node = of_get_child_by_name(dev->of_node, "rcar_sound,src");
+	src_node = rsnd_src_of_node(priv);
 	if (!src_node)
 		return;
 
-- 
1.7.9.5


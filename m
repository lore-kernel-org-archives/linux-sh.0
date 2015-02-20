From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:30:02 +0000
Subject: [PATCH 17/24 v2] ASoC: rsnd: ssi: add rsnd_ssi_of_node()
Message-Id: <87r3tknabn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds rsnd_ssi_of_node() to get SSI subnode from DT.
This is prepare for new DT bindings for 1st DMAC

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 sound/soc/sh/rcar/ssi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 7e48d56..2133eb3 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -83,6 +83,8 @@ struct rsnd_ssi {
 #define rsnd_ssi_clk_from_parent(ssi) ((ssi)->parent)
 #define rsnd_ssi_mode_flags(p) ((p)->info->flags)
 #define rsnd_ssi_dai_id(ssi) ((ssi)->info->dai_id)
+#define rsnd_ssi_of_node(priv) \
+	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,ssi")
 
 int rsnd_ssi_use_busif(struct rsnd_mod *mod)
 {
@@ -633,7 +635,7 @@ static void rsnd_of_parse_ssi(struct platform_device *pdev,
 	if (!of_data)
 		return;
 
-	node = of_get_child_by_name(dev->of_node, "rcar_sound,ssi");
+	node = rsnd_ssi_of_node(priv);
 	if (!node)
 		return;
 
-- 
1.7.9.5


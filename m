From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:30:41 +0000
Subject: [PATCH 19/24 v2] ASoC: rsnd: dvc: add rsnd_dvc_of_node()
Message-Id: <87oaoonaal.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds rsnd_dvc_of_node() to get DVC subnode from DT.
This is prepare for new DT bindings for 1st DMAC

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 sound/soc/sh/rcar/dvc.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d7f9ed9..e099018 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -24,6 +24,9 @@ struct rsnd_dvc {
 	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
 };
 
+#define rsnd_dvc_of_node(priv) \
+	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,dvc")
+
 #define rsnd_mod_to_dvc(_mod)	\
 	container_of((_mod), struct rsnd_dvc, mod)
 
-- 
1.7.9.5


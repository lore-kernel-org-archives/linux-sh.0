From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 08:55:09 +0000
Subject: [PATCH 02/12] ASoC: rsnd: fixup loop exit timing of dma name search
Message-Id: <87a99azjf6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current dma name search loop didn't care about SSI index
This patch fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4e86265..ed76901 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -297,7 +297,6 @@ static void rsnd_dma_of_name(struct rsnd_dma *dma,
 	for (i = 1; i < MOD_MAX; i++) {
 		if (!src) {
 			mod[i] = ssi;
-			break;
 		} else if (!dvc) {
 			mod[i] = src;
 			src = NULL;
@@ -308,6 +307,9 @@ static void rsnd_dma_of_name(struct rsnd_dma *dma,
 
 		if (mod[i] = this)
 			index = i;
+
+		if (mod[i] = ssi)
+			break;
 	}
 
 	if (is_play) {
-- 
1.7.9.5


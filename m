From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 14 Mar 2014 00:56:43 +0000
Subject: [PATCH 2/2] ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87a9ctpph2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
	<87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
Cc: Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
Then, rcar will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 sound/soc/sh/rcar/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 743de5e..3a4fe9d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -486,10 +486,10 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		rdai->clk_master = 1;
+		rdai->clk_master = 0;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		rdai->clk_master = 0;
+		rdai->clk_master = 1; /* codec is slave, cpu is master */
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.9.5


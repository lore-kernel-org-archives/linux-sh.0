From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:57:19 +0000
Subject: [PATCH 6/7] ASoC: rsnd: remove old clock style support
Message-Id: <87k3as20er.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, broonie@kernel.org
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

All platform which used old style was
switched to new style.
R-Car sound can remove old style clock support,
use device dependent clock now.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/adg.c |   39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 69c4426..41556b2 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -397,9 +397,8 @@ int rsnd_adg_probe(struct platform_device *pdev,
 {
 	struct rsnd_adg *adg;
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct clk *clk, *clk_orig;
+	struct clk *clk;
 	int i;
-	bool use_old_style = false;
 
 	adg = devm_kzalloc(dev, sizeof(*adg), GFP_KERNEL);
 	if (!adg) {
@@ -407,45 +406,13 @@ int rsnd_adg_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	clk_orig	= devm_clk_get(dev, NULL);
 	adg->clk[CLKA]	= devm_clk_get(dev, "clk_a");
 	adg->clk[CLKB]	= devm_clk_get(dev, "clk_b");
 	adg->clk[CLKC]	= devm_clk_get(dev, "clk_c");
 	adg->clk[CLKI]	= devm_clk_get(dev, "clk_i");
 
-	/*
-	 * It request device dependent audio clock.
-	 * But above all clks will indicate rsnd module clock
-	 * if platform doesn't it
-	 */
-	for_each_rsnd_clk(clk, adg, i) {
-		if (clk_orig = clk) {
-			dev_warn(dev,
-				 "doesn't have device dependent clock, use independent clock\n");
-			use_old_style = true;
-			break;
-		}
-	}
-
-	/*
-	 * note:
-	 * these exist in order to keep compatible with
-	 * platform which has device independent audio clock,
-	 * but will be removed soon
-	 */
-	if (use_old_style) {
-		adg->clk[CLKA] = devm_clk_get(NULL, "audio_clk_a");
-		adg->clk[CLKB] = devm_clk_get(NULL, "audio_clk_b");
-		adg->clk[CLKC] = devm_clk_get(NULL, "audio_clk_c");
-		adg->clk[CLKI] = devm_clk_get(NULL, "audio_clk_internal");
-	}
-
-	for_each_rsnd_clk(clk, adg, i) {
-		if (IS_ERR(clk)) {
-			dev_err(dev, "Audio clock failed\n");
-			return -EIO;
-		}
-	}
+	for_each_rsnd_clk(clk, adg, i)
+		dev_dbg(dev, "clk %d : %p\n", i, clk);
 
 	rsnd_adg_ssi_clk_init(priv, adg);
 
-- 
1.7.9.5


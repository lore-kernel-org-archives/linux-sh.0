From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 28 Oct 2015 15:03:48 +0000
Subject: [PATCH] [RFC] ASoC: rsnd: Add missing initialization of ADG req_rate
Message-Id: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the "clock-frequency" DT property is not found, req_rate is used
uninitialized, and the "audio_clkout" clock will be created with an
arbitrary clock rate.

This uninitialized kernel stack data may leak to userspace through
/sys/kernel/debug/clk/clk_summary, cfr. the value in the "rate" column:

       clock     enable_cnt  prepare_cnt        rate   accuracy   phase
    --------------------------------------------------------------------
     audio_clkout         0            0  4001836240          0 0

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should the absence of this property be considered an error?

Documentation/devicetree/bindings/sound/renesas,rsnd.txt states that
both "#clock-cells" and "clock-frequency" are required properties, but
none of the R-Car Gen1 and Gen2 DTSes seem to have them?
---
 sound/soc/sh/rcar/adg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 2a5b3a293cd243db..b123734f9fbdabd9 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -437,7 +437,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
 	u32 ckr, rbgx, rbga, rbgb;
-	u32 rate, req_rate, div;
+	u32 rate, req_rate = 0, div;
 	uint32_t count = 0;
 	unsigned long req_48kHz_rate, req_441kHz_rate;
 	int i;
-- 
1.9.1


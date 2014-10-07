From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 07 Oct 2014 13:09:26 +0000
Subject: [PATCH] ASoC: simple-card: Initialize headphone and mic GPIO numbers
Message-Id: <1412687366-6400-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The uninitialized default of 0 for gpio_hp_det and gpio_mic_det doesn't
play well with asm-generic's gpio_is_valid():

	static inline bool gpio_is_valid(int number)
	{
		return number >= 0 && number < ARCH_NR_GPIOS;
	}

Hence on r8a7740/armadillo-legacy:

	sh-mobile-hdmi sh-mobile-hdmi: SH Mobile HDMI Audio Codec
	sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones
	sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Mic Jack

After that the kernel log is spammed ca. 7 times per second with:

	sh-mobile-hdmi sh-mobile-hdmi: ASoC: DAPM unknown pin Headphones

Initialize the GPIO numbers with a negative number (-ENOENT) to fix this.

Fixes: 3fe240326cc395c6 ("ASoC: simple-card: Add mic and hp detect gpios.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is against sound-asoc/for-next

 sound/soc/generic/simple-card.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fcb431fe20b4ae7b..d1b7293c133eaa45 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -501,6 +501,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	priv->snd_card.dai_link = dai_link;
 	priv->snd_card.num_links = num_links;
 
+	priv->gpio_hp_det = -ENOENT;
+	priv->gpio_mic_det = -ENOENT;
+
 	/* Get room for the other properties */
 	priv->dai_props = devm_kzalloc(dev,
 			sizeof(*priv->dai_props) * num_links,
-- 
1.9.1


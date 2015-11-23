From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Nov 2015 09:35:54 +0000
Subject: [PATCH] ASoC: rcar: remove unused variable
Message-Id: <4929159.b95vLdVRYU@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

After a recent cleanup, the soc_card variable became unused
and now produces a warning:

soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
soc/sh/rcar/core.c:801:23: warning: unused variable 'soc_card' [-Wunused-variable]

This removes the variable.

Fixes: 1a497983a5ae ("ASoC: Change the PCM runtime array to a list")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index c6685f14b9cb..90b244c1f526 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -798,7 +798,6 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 			    void (*update)(struct rsnd_dai_stream *io,
 					   struct rsnd_mod *mod))
 {
-	struct snd_soc_card *soc_card = rtd->card;
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_kcontrol *kctrl;
 	struct snd_kcontrol_new knew = {


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 10 Apr 2015 07:15:06 +0000
Subject: Re: [PATCH 3/3] ASoC: simple-card: Remove support for setting differing DAI formats
Message-Id: <878ue08ngb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>	<87bnjj431h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnjj431h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

Hi Lars, Mark

> Having to set different formats on the CPU side and the CODEC side of a DAI
> link is usually indication that something is terribly wrong and in most
> cases is a result of a broken driver that implements a set_fmt() callback
> which does not follow the specification. In the past this feature has been
> used to work around broken drivers, rather than fixing them. We don't really
> want to encourage this, so remove support for setting different formats on
> both ends of the link.
> 
> Along the way switch to static DAI format setup by setting the the dai_fmt
> field of the snd_soc_dai_link rather than calling snd_soc_dai_fmt().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> same as original patch
> 
>  include/sound/simple_card.h     |  1 -
>  sound/soc/generic/simple-card.c | 30 ++++++++----------------------
>  2 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/include/sound/simple_card.h b/include/sound/simple_card.h
> index 1255ddb..b9b4f28 100644
> --- a/include/sound/simple_card.h
> +++ b/include/sound/simple_card.h
> @@ -16,7 +16,6 @@
>  
>  struct asoc_simple_dai {
>  	const char *name;
> -	unsigned int fmt;
>  	unsigned int sysclk;
>  	int slots;
>  	int slot_width;
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index c49a408..33feee9 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -125,14 +125,6 @@ static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
>  {
>  	int ret;
>  
> -	if (set->fmt) {
> -		ret = snd_soc_dai_set_fmt(dai, set->fmt);
> -		if (ret && ret != -ENOTSUPP) {
> -			dev_err(dai->dev, "simple-card: set_fmt error\n");
> -			goto err;
> -		}
> -	}

This patch removed above snd_soc_dai_set_fmt() here,
and samethings is done in snd_soc_instantiate_card().

But, I noticed it breaks set_fmt() and pcm_new() timing.
Before: set_fmt -> pcm_new 
After:  pcm_new -> set_fmt

My driver adds kctrl on pcm_new timing, and it refers
set_fmt's settings. but now, set_fmt happen *after* pcm_new.
(it adds new kctrl if it has SND_SOC_DAIFMT_CBS_CFS)

My solution is these 2
 pattern1) exchange set_fmt/pcm_new timing. see below
 pattern2) exchange kctrl assumption (always set kctrl)

Maybe I should try pattern2 ?

---------------------------------------
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 76bfff2..24d6733 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1604,6 +1604,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
                }
        }
 
+       for (i = 0; i < card->num_links; i++) {
+               if (card->dai_link[i].dai_fmt)
+                       snd_soc_runtime_set_dai_fmt(&card->rtd[i],
+                                                   card->dai_link[i].dai_fmt);
+       }
+
        /* probe all DAI links on this card */
        for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
                        order++) {
@@ -1642,12 +1648,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
                snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
                                        card->num_of_dapm_routes);
 
-       for (i = 0; i < card->num_links; i++) {
-               if (card->dai_link[i].dai_fmt)
-                       snd_soc_runtime_set_dai_fmt(&card->rtd[i],
-                               card->dai_link[i].dai_fmt);
-       }
-
        snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
                 "%s", card->name);
        snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),

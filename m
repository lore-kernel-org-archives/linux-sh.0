From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 10 Apr 2015 09:21:54 +0000
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: simple-card: Remove support for setting differing DAI formats
Message-Id: <87vbh4730i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
	<87bnjj431h.wl%kuninori.morimoto.gx@renesas.com>
	<878ue08ngb.wl%kuninori.morimoto.gx@renesas.com>
	<55278F58.6030909@metafoo.de>
In-Reply-To: <55278F58.6030909@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>


Hi Lars

Thank you for your feedback

> > Before: set_fmt -> pcm_new
> > After:  pcm_new -> set_fmt
> >
> > My driver adds kctrl on pcm_new timing, and it refers
> > set_fmt's settings. but now, set_fmt happen *after* pcm_new.
> > (it adds new kctrl if it has SND_SOC_DAIFMT_CBS_CFS)
> 
> What does that control do? This seems to be a bit of a layering
> violation to create a control in the PCM driver based on the
> configuration of the DAI link.

Our device can support runtime sampling rate convert, and our driver
is supporting it via DPCM. but, this feature needs "clock master".
This control is for it.

> > ---------------------------------------
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 76bfff2..24d6733 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -1604,6 +1604,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
> >                  }
> >          }
> >
> > +       for (i = 0; i < card->num_links; i++) {
> > +               if (card->dai_link[i].dai_fmt)
> > +                       snd_soc_runtime_set_dai_fmt(&card->rtd[i],
> > +                                                   card->dai_link[i].dai_fmt);
> > +       }
> > +
> 
> This seems to be to early, the DAI's should at least have been
> probed. I think we should put it in soc_probe_link_dais() after the
> the dai_link->init section.

Thanks

soc_probe_link_dais() needs many loops
	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST; 
			order++) {
		for (i = 0; i < card->num_links; i++) {

but, it is checking

	if (order != SND_SOC_COMP_ORDER_LAST)
		return 0;

This means we can put it under soc_probe_link_dais()
I can send formal patch if this is OK.

# But, I wonder what is good explain about this patch ...
# indeed I noticed this issue from
# 1efb53a220b78fdfdbb97b726a2156713e75bdab
# (ASoC: simple-card: Remove support for setting differing DAI formats)
# but, it is simple-card user only...

--------
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 76bfff2..9777e78 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1324,6 +1324,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 		}
 	}
 
+	if (dai_link->dai_fmt)
+		snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+
 	ret = soc_post_component_init(rtd, dai_link->name);
 	if (ret)
 		return ret;
@@ -1642,12 +1645,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
 					card->num_of_dapm_routes);
 
-	for (i = 0; i < card->num_links; i++) {
-		if (card->dai_link[i].dai_fmt)
-			snd_soc_runtime_set_dai_fmt(&card->rtd[i],
-				card->dai_link[i].dai_fmt);
-	}
-
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s", card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
---------

Best regards
---
Kuninori Morimoto

From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 10 Apr 2015 09:25:58 +0000
Subject: Re: [alsa-devel] [PATCH 3/3] ASoC: simple-card: Remove support for setting differing DAI formats
Message-Id: <55279726.7090208@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
 <87bnjj431h.wl%kuninori.morimoto.gx@renesas.com>
 <878ue08ngb.wl%kuninori.morimoto.gx@renesas.com>
 <55278F58.6030909@metafoo.de>
 <87vbh4730i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbh4730i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>

On 04/10/2015 11:21 AM, Kuninori Morimoto wrote:
> This means we can put it under soc_probe_link_dais()
> I can send formal patch if this is OK.

Looks perfect.

>
> # But, I wonder what is good explain about this patch ...
> # indeed I noticed this issue from
> # 1efb53a220b78fdfdbb97b726a2156713e75bdab
> # (ASoC: simple-card: Remove support for setting differing DAI formats)
> # but, it is simple-card user only...
>
> --------
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 76bfff2..9777e78 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1324,6 +1324,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
>   		}
>   	}
>
> +	if (dai_link->dai_fmt)
> +		snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
> +
>   	ret = soc_post_component_init(rtd, dai_link->name);
>   	if (ret)
>   		return ret;
> @@ -1642,12 +1645,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
>   		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
>   					card->num_of_dapm_routes);
>
> -	for (i = 0; i < card->num_links; i++) {
> -		if (card->dai_link[i].dai_fmt)
> -			snd_soc_runtime_set_dai_fmt(&card->rtd[i],
> -				card->dai_link[i].dai_fmt);
> -	}
> -
>   	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
>   		 "%s", card->name);
>   	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
> ---------
>
> Best regards
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


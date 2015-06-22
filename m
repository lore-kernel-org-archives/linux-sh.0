From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jun 2015 08:41:18 +0000
Subject: Re: [PATCH] ASoC: rsrc-card: Remove unused variable in rsrc_card_startup()
Message-Id: <87wpyw6stl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434962073-9597-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434962073-9597-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


Hi Geert

Thank you for your patch
But, this patch was already posted/applied

http://thread.gmane.org/gmane.linux.alsa.devel/140317

> sound/soc/sh/rcar/rsrc-card.c: In function 'rsrc_card_startup':
> sound/soc/sh/rcar/rsrc-card.c:78:6: warning: unused variable 'ret' [-Wunused-variable]
>   int ret;
>       ^
> 
> Fixes: 047000278da3a17f ("ASoC: rsrc-card: cleanup for DPCM")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  sound/soc/sh/rcar/rsrc-card.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
> index 8caca2e180c39122..84e935711e29e442 100644
> --- a/sound/soc/sh/rcar/rsrc-card.c
> +++ b/sound/soc/sh/rcar/rsrc-card.c
> @@ -75,8 +75,6 @@ static int rsrc_card_startup(struct snd_pcm_substream *substream)
>  	struct rsrc_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
>  	struct rsrc_card_dai *dai_props >  		rsrc_priv_to_props(priv, rtd - rtd->card->rtd);
> -	int ret;
> -
>  
>  	return clk_prepare_enable(dai_props->clk);
>  }
> -- 
> 1.9.1
> 


Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in

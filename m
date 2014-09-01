From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 01 Sep 2014 07:42:47 +0000
Subject: Re: [alsa-devel] [PATCHv1 1/7] ASoC: simple-card: Merge single and muti	DAI link code.
Message-Id: <87tx4rzszx.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
	<1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1409545781-20530-2-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi Xiubo

Thank you for your patch.
This clean-up is very nice for me.
But, I have 1 small comment

>  asoc_simple_card_sub_parse_of(struct device_node *np,
>  			      struct asoc_simple_dai *dai,
>  			      struct device_node **p_node,
> -			      const char **name)
> +			      const char **name,
> +			      unsigned int *daifmt)
>  {
>  	struct device_node *node;
>  	struct clk *clk;
>  	u32 val;
>  	int ret;
>  
> +	if (!daifmt)
> +		return -EINVAL;
> +
> +	/*
> +	 * Parse format, bitclock-inversion and frame-inversion
> +	 * for DAI each device.
> +	 */
> +	*daifmt = snd_soc_of_parse_daifmt(np, NULL, NULL, NULL);
> +	*daifmt &= ~(SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK);
(snip)
>  	ret = asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai,
>  					    &dai_link->cpu_of_node,
> -					    &dai_link->cpu_dai_name);
> +					    &dai_link->cpu_dai_name,
> +					    &daifmt);
(snip)
> +	dai_props->cpu_dai.fmt |= daifmt;
(snip)
>  	ret = asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai,
>  					    &dai_link->codec_of_node,
> -					    &dai_link->codec_dai_name);
> +					    &dai_link->codec_dai_name,
> +					    &daifmt);
(snip)
> +	dai_props->codec_dai.fmt |= daifmt;

These are using

      asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai, xxx)
      asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai, xxx)

I guess, asoc_simple_card_sub_parse_of() can update
below inside function

	dai_props->cpu_dai.fmt |= daifmt;
	dai_props->codec_dai.fmt |= daifmt;


Best regards
---
Kuninori Morimoto

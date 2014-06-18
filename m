From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 18 Jun 2014 14:20:18 +0000
Subject: Re: [PATCH 09/12] ASoC: rsnd: enable SRC setting via DT
Message-Id: <53A1A022.1020801@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
 <87zjhay4s6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjhay4s6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sh@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>

Hello.

On 06/18/2014 12:56 PM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> some special board wants to exchange sampling rate by using SRC.
> This patch enables its settings.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[...]

> diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
> index 4d39505..93a5e58 100644
> --- a/sound/soc/sh/rcar/src.c
> +++ b/sound/soc/sh/rcar/src.c
[...]
> @@ -640,6 +640,16 @@ static void rsnd_of_parse_src(struct platform_device *pdev,
>   	info->src_info		= src_info;
>   	info->src_info_nr	= nr;
>
> +	i = 0;
> +	for_each_child_of_node(src_node, np) {
> +		src_info = info->src_info + i;
> +
> +		of_property_read_u32(src_node, "convert-rate",

    Are you sure it's 'src_node' here, not 'np'?

> +				     &src_info->convert_rate);
> +
> +		i++;
> +	}
> +

WBR, Sergei


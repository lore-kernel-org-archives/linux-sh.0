From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 00:09:14 +0000
Subject: Re: [PATCH] ASoC: fsi: Remove obsolete sh_fsi2 platform_device_id entry
Message-Id: <20150715000913.GA30642@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

On Tue, Jul 14, 2015 at 01:59:34PM +0200, Geert Uytterhoeven wrote:
> Since the removal of the r8a7740 legacy board code in commit
> 1fa59bda21c7fa36 ("ARM: shmobile: Remove legacy board code for
> Armadillo-800 EVA"), all former users of the "sh_fsi2" platform device
> name are only supported in generic DT-only ARM multi-platform builds.
> The driver doesn't need to match platform devices by name anymore, hence
> remove the corresponding platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> The commit mentioned above is in -next, destined for v4.3.
> ---
>  sound/soc/sh/fsi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 142c066eaee2ecb1..0215c78cbddf5491 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1911,7 +1911,6 @@ MODULE_DEVICE_TABLE(of, fsi_of_match);
>  
>  static const struct platform_device_id fsi_id_table[] = {
>  	{ "sh_fsi",	(kernel_ulong_t)&fsi1_core },
> -	{ "sh_fsi2",	(kernel_ulong_t)&fsi2_core },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(platform, fsi_id_table);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Apr 2011 08:24:20 +0000
Subject: Re: [PATCH] ALSA: add a module alias to the FSI driver
Message-Id: <20110418082420.GD3720@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Fri, Apr 15, 2011 at 08:17:34PM +0200, Guennadi Liakhovetski wrote:
> This patch enables FSI driver autoloading on sh-mobile systems.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This appears correct to me.

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  sound/soc/sh/fsi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 0c9997e..88b669c 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1321,3 +1321,4 @@ module_exit(fsi_mobile_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("SuperH onchip FSI audio driver");
>  MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
> +MODULE_ALIAS("platform:fsi-pcm-audio");
> -- 
> 1.7.2.5
> 

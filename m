From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Mon, 18 Apr 2011 08:55:55 +0000
Subject: Re: [PATCH] ALSA: add a module alias to the FSI driver
Message-Id: <1303116955.3523.1.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Simon@alsa-project.org, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>, Horman <horms@verge.net.au>

On Fri, 2011-04-15 at 20:17 +0200, Guennadi Liakhovetski wrote:
> This patch enables FSI driver autoloading on sh-mobile systems.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
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

Acked-by: Liam Girdwood <lrg@ti.com>


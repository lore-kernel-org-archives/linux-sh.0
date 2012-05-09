From: kuninori.morimoto.gx@renesas.com
Date: Wed, 09 May 2012 23:59:48 +0000
Subject: Re: [PATCH 8/9 v3] ASoC: fsi: prepare for conversion to the shdma base library
Message-Id: <87obpwq51q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de>
	<1336576161-27082-9-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336576161-27082-9-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

At Wed, 09 May 2012 17:09:20 +0200,
Guennadi wrote:
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


>  sound/soc/sh/fsi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 74ed2df..c28314b 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1532,8 +1532,8 @@ static void fsi_handler_init(struct fsi_priv *fsi)
>  	fsi->capture.priv	= fsi;
>  
>  	if (fsi->info->tx_id) {
> -		fsi->playback.slave.slave_id	= fsi->info->tx_id;
> -		fsi->playback.handler		= &fsi_dma_push_handler;
> +		fsi->playback.slave.shdma_slave.slave_id = fsi->info->tx_id;
> +		fsi->playback.handler = &fsi_dma_push_handler;
>  	}
>  }
>  
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

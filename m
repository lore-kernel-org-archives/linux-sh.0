From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Apr 2012 09:25:19 +0000
Subject: Re: [PATCH] ASoC: fsi:  Add missing argument to device_prep_slave_sg()
Message-Id: <87aa2q4jk4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1333616835-973-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1333616835-973-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for your patch

Maybe this is same as
http://www.spinics.net/lists/linux-sh/msg10806.html

> An extra paramter, context, was added to device_prep_slave_sg()
> by "dmaengine: add context parameter to prep_slave_sg and prep_dma_cyclic".
> This patch updates the FSI driver so that it compiles once again.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  sound/soc/sh/fsi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> index 378cc5b..a2114e5 100644
> --- a/sound/soc/sh/fsi.c
> +++ b/sound/soc/sh/fsi.c
> @@ -1003,7 +1003,7 @@ static void fsi_dma_do_tasklet(unsigned long data)
>  
>  	desc = chan->device->device_prep_slave_sg(chan, &sg, 1, dir,
>  						  DMA_PREP_INTERRUPT |
> -						  DMA_CTRL_ACK);
> +						  DMA_CTRL_ACK, NULL);
>  	if (!desc) {
>  		dev_err(dai->dev, "device_prep_slave_sg() fail\n");
>  		return;
> -- 
> 1.7.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Best regards
---
Kuninori Morimoto

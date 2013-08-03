From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 03 Aug 2013 22:36:50 +0000
Subject: Re: [PATCH v2] tmio_mmc_dma: fix PIO fallback on SDHI
Message-Id: <Pine.LNX.4.64.1308040026020.11632@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201308030233.29446.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308030233.29446.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, cjb@laptop.org, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

On Sat, 3 Aug 2013, Sergei Shtylyov wrote:

> I'm testing SH-Mobile SDHI driver in DMA mode with  a new DMA controller  using
> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
> to PIO but all commands time out after that.  It turned out that the fallback
> code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
> to them cleared, so that the function bails out early instead  of clearing the
> DMA bit in the CTL_DMA_ENABLE register. The regression was introduced by commit
> 162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock).
> Moving tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
> tmio_mmc_start_dma_{rx|tx}() helps.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org # 3.1+

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Not sure though how far back in stable this really has to go. We don't 
have any real-life problem reports with older kernels, do we? I think 
approach to which patches should get into stable changed recently.

Thanks
Guennadi

> 
> ---
> The patch is against Chris Ball's 'mmc.git' repo, 'master' branch.
> 
> Changes in version 2:
> - removed extra check from tmio_mmc_enable_dma();
> - moved tmio_mmc_enable_dma() calls to the top of the PIO fallback code in
>   tmio_mmc_start_dma_{rx|tx}().
> 
>  drivers/mmc/host/tmio_mmc_dma.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: renesas/drivers/mmc/host/tmio_mmc_dma.c
> =================================> --- renesas.orig/drivers/mmc/host/tmio_mmc_dma.c
> +++ renesas/drivers/mmc/host/tmio_mmc_dma.c
> @@ -104,6 +104,7 @@ static void tmio_mmc_start_dma_rx(struct
>  pio:
>  	if (!desc) {
>  		/* DMA failed, fall back to PIO */
> +		tmio_mmc_enable_dma(host, false);
>  		if (ret >= 0)
>  			ret = -EIO;
>  		host->chan_rx = NULL;
> @@ -116,7 +117,6 @@ pio:
>  		}
>  		dev_warn(&host->pdev->dev,
>  			 "DMA failed: %d, falling back to PIO\n", ret);
> -		tmio_mmc_enable_dma(host, false);
>  	}
>  
>  	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
> @@ -185,6 +185,7 @@ static void tmio_mmc_start_dma_tx(struct
>  pio:
>  	if (!desc) {
>  		/* DMA failed, fall back to PIO */
> +		tmio_mmc_enable_dma(host, false);
>  		if (ret >= 0)
>  			ret = -EIO;
>  		host->chan_tx = NULL;
> @@ -197,7 +198,6 @@ pio:
>  		}
>  		dev_warn(&host->pdev->dev,
>  			 "DMA failed: %d, falling back to PIO\n", ret);
> -		tmio_mmc_enable_dma(host, false);
>  	}
>  
>  	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

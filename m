From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 01 Feb 2012 17:14:28 +0000
Subject: Re: [PATCH 1/2] dma: sh_dma: not all SH DMAC implementations support MEMCPY
Message-Id: <1328115748.1610.34.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, 2012-01-18 at 10:14 +0100, Guennadi Liakhovetski wrote:
> Add a flag to allow platforms to specify, whether a DMAC instance supports
> the MEMCPY operation. To avoid regressions, preserve the current default.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Applied both, Thanks
> ---
>  drivers/dma/shdma.c    |    3 ++-
>  include/linux/sh_dma.h |    1 +
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
> index cabcfe8..e4ed4da 100644
> --- a/drivers/dma/shdma.c
> +++ b/drivers/dma/shdma.c
> @@ -1267,7 +1267,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&shdev->common.channels);
>  
> -	dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
> +	if (!pdata->slave_only)
> +		dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
>  	if (pdata->slave && pdata->slave_num)
>  		dma_cap_set(DMA_SLAVE, shdev->common.cap_mask);
>  
> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> index e11e171..db637b9 100644
> --- a/include/linux/sh_dma.h
> +++ b/include/linux/sh_dma.h
> @@ -70,6 +70,7 @@ struct sh_dmae_pdata {
>  	unsigned int needs_tend_set:1;
>  	unsigned int no_dmars:1;
>  	unsigned int chclr_present:1;
> +	unsigned int slave_only:1;
>  };
>  
>  /* DMA register */


-- 
~Vinod


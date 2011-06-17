From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Jun 2011 07:21:39 +0000
Subject: Re: [RFC][PATCH 3/6] dmaengine: shdma: add dmaor_is_32bit flag
Message-Id: <Pine.LNX.4.64.1106170918390.27141@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pr56tp1mh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pr56tp1mh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 17 Jun 2011, Kuninori Morimoto wrote:

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/dma/shdma.c    |   14 ++++++++++++--
>  include/linux/sh_dma.h |    2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
> index 9412de3..aa91309 100644
> --- a/drivers/dma/shdma.c
> +++ b/drivers/dma/shdma.c
> @@ -70,12 +70,22 @@ static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
>  
>  static u16 dmaor_read(struct sh_dmae_device *shdev)
>  {
> -	return __raw_readw(shdev->chan_reg + DMAOR / sizeof(u32));
> +	u32 __iomem *addr = shdev->chan_reg + DMAOR / sizeof(u32);
> +
> +	if (shdev->pdata->dmaor_is_32bit)
> +		return (u16)__raw_readl(addr);

Is this type-casting needed? Does the compiler complain without it?

> +	else
> +		return __raw_readw(addr);
>  }
>  
>  static void dmaor_write(struct sh_dmae_device *shdev, u16 data)
>  {
> -	__raw_writew(data, shdev->chan_reg + DMAOR / sizeof(u32));
> +	u32 __iomem *addr = shdev->chan_reg + DMAOR / sizeof(u32);
> +
> +	if (shdev->pdata->dmaor_is_32bit)
> +		__raw_writel((u32)data, addr);

ditto

> +	else
> +		__raw_writew(data, addr);
>  }
>  
>  static void chcr_write(struct sh_dmae_chan *sh_dc, u32 data)
> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> index dab2ddc..6a98daf 100644
> --- a/include/linux/sh_dma.h
> +++ b/include/linux/sh_dma.h
> @@ -64,6 +64,8 @@ struct sh_dmae_pdata {
>  	u16 dmaor_init;
>  	u32 chcr_offset;
>  	u32 chcr_ie_bit;
> +
> +	u32 dmaor_is_32bit:1;

"unsigned int dmaor_is_32bit : 1" would be my choice;)

Thanks
Guennadi

>  };
>  
>  /* DMA register */
> -- 
> 1.7.4.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

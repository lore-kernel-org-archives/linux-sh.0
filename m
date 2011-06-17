From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Jun 2011 06:45:13 +0000
Subject: Re: [RFC][PATCH 1/6] dmaengine: shdma: add chcr_write/read function
Message-Id: <Pine.LNX.4.64.1106170834550.27141@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 17 Jun 2011, Kuninori Morimoto wrote:

> CHCR register position is not same in all DMAC.
> This patch adds new "int chcr_offset" to decide it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Looks good to me, just one nitpick:

> ---
>  drivers/dma/shdma.c    |   35 +++++++++++++++++++++++++++--------
>  drivers/dma/shdma.h    |    1 +
>  include/linux/sh_dma.h |    1 +
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 

[snip]

> diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
> index 6c73b65..1305b67 100644
> --- a/drivers/dma/shdma.h
> +++ b/drivers/dma/shdma.h
> @@ -47,6 +47,7 @@ struct sh_dmae_device {
>  	struct list_head node;
>  	u32 __iomem *chan_reg;
>  	u16 __iomem *dmars;
> +	u32 chcr_offset;

Something like unsigned int would do here too. IMHO, fixed size types like 
u32, s32, u16 etc. only make sense where the size of the variable really 
matters, e.g., where it should match hardware registers or where the data 
can be used on different architectures, e.g., passed over a network or 
stored on a non-volatile medium, or even just passed between programs, 
possibly built with different ABIs on a system, running in some 
compatibility mode, because standard C integer types can have different 
sizes on different architectures. Your chcr_offset doesn't belong to any 
of these categories. It is just an offset, added to a suitably typed 
address. And as such it can be any (unsigned) integer type, e.g., 
"unsigned int."

>  };
>  
>  #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> index b08cd4e..4f2cad9 100644
> --- a/include/linux/sh_dma.h
> +++ b/include/linux/sh_dma.h
> @@ -62,6 +62,7 @@ struct sh_dmae_pdata {
>  	const unsigned int *ts_shift;
>  	int ts_shift_num;
>  	u16 dmaor_init;
> +	u32 chcr_offset;

ditto.

>  };
>  
>  /* DMA register */
> -- 
> 1.7.4.1

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Dec 2013 09:10:42 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: fixup DMA mask
Message-Id: <20131219091041.GF12239@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbypyzv3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87vbypyzv3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 16, 2013 at 07:16:06PM +0100, Laurent Pinchart wrote:
> Hi Morimoto-san,
> 
> On Monday 16 December 2013 00:16:52 Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > 4dcfa60071b3d23f0181f27d8519f12e37cefbb9
> > (ARM: DMA-API: better handing of DMA masks for coherent allocations)
> > exchanged DMA mask check method.
> > Below warning will appear without this patch
> > 
> > asoc-simple-card asoc-simple-card.0: \
> >   Coherent DMA mask 0xffffffffffffffff is larger than dma_addr_t allows
> > asoc-simple-card asoc-simple-card.0: \
> >   Driver did not use or check the return value from dma_set_coherent_mask()?
> 
> I was investigating the same problem with LCDC on Armadillo when I've read 
> your patch, so thank you :-)
> 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I will queue this up as a fix for v3.13.

> 
> > ---
> >  arch/arm/mach-shmobile/board-bockw.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-bockw.c
> > b/arch/arm/mach-shmobile/board-bockw.c index fd9ab9f..24b4161 100644
> > --- a/arch/arm/mach-shmobile/board-bockw.c
> > +++ b/arch/arm/mach-shmobile/board-bockw.c
> > @@ -693,7 +693,7 @@ static void __init bockw_init(void)
> >  			.id             = i,
> >  			.data           = &rsnd_card_info[i],
> >  			.size_data      = sizeof(struct asoc_simple_card_info),
> > -			.dma_mask       = ~0,
> > +			.dma_mask	= DMA_BIT_MASK(32),
> >  		};
> > 
> >  		platform_device_register_full(&cardinfo);
> -- 
> Regards,
> 
> Laurent Pinchart
> 

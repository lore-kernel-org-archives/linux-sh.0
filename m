From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 21 Jan 2014 12:10:30 +0000
Subject: Re: [PATCH v3 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <1784316.ZelAfIxChY@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386765786-1926-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386765786-1926-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 07 January 2014 16:08:37 Laurent Pinchart wrote:
> Hello,
> 
> Ping ? Could this patch series (with patches v3.1 1/3, v3 2/3 and v3 3/3) be
> applied for v3.14 ? Same question for "DMA: shdma: Enable driver
> compilation with COMPILE_TEST".

PING ?

> On Wednesday 11 December 2013 13:43:04 Laurent Pinchart wrote:
> > Use the %zu and %pad printk specifiers to print size_t and dma_addr_t
> > variables, and cast pointers to uintptr_t instead of unsigned int where
> > applicable. This fixes warnings on platforms where pointers and/or
> > dma_addr_t have a different size than int
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: dmaengine@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/dma/sh/shdma-base.c | 8 ++++----
> >  drivers/dma/sh/shdma-of.c   | 3 ++-
> >  drivers/dma/sh/sudmac.c     | 4 ++--
> >  3 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> > index 2e7b394..5367e01 100644
> > --- a/drivers/dma/sh/shdma-base.c
> > +++ b/drivers/dma/sh/shdma-base.c
> > @@ -227,7 +227,7 @@ bool shdma_chan_filter(struct dma_chan *chan, void
> > *arg) struct shdma_chan *schan = to_shdma_chan(chan);
> > 
> >  	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
> >  	const struct shdma_ops *ops = sdev->ops;
> > 
> > -	int match = (int)arg;
> > +	int match = (long)arg;
> > 
> >  	int ret;
> >  	
> >  	if (match < 0)
> > 
> > @@ -491,8 +491,8 @@ static struct shdma_desc *shdma_add_desc(struct
> > shdma_chan *schan, }
> > 
> >  	dev_dbg(schan->dev,
> > 
> > -		"chaining (%u/%u)@%x -> %x with %p, cookie %d\n",
> > -		copy_size, *len, *src, *dst, &new->async_tx,
> > +		"chaining (%zu/%zu)@%pad -> %pad with %p, cookie %d\n",
> > +		copy_size, *len, src, dst, &new->async_tx,
> > 
> >  		new->async_tx.cookie);
> >  	
> >  	new->mark = DESC_PREPARED;
> > 
> > @@ -555,7 +555,7 @@ static struct dma_async_tx_descriptor
> > *shdma_prep_sg(struct shdma_chan *schan, goto err_get_desc;
> > 
> >  		do {
> > 
> > -			dev_dbg(schan->dev, "Add SG #%d@%p[%d], dma %llx\n",
> > +			dev_dbg(schan->dev, "Add SG #%d@%p[%zu], dma %llx\n",
> > 
> >  				i, sg, len, (unsigned long long)sg_addr);
> >  			
> >  			if (direction = DMA_DEV_TO_MEM)
> > 
> > diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
> > index 06473a0..b4ff9d3 100644
> > --- a/drivers/dma/sh/shdma-of.c
> > +++ b/drivers/dma/sh/shdma-of.c
> > @@ -33,7 +33,8 @@ static struct dma_chan *shdma_of_xlate(struct
> > of_phandle_args *dma_spec, /* Only slave DMA channels can be allocated via
> > DT */
> > 
> >  	dma_cap_set(DMA_SLAVE, mask);
> > 
> > -	chan = dma_request_channel(mask, shdma_chan_filter, (void *)id);
> > +	chan = dma_request_channel(mask, shdma_chan_filter,
> > +				   (void *)(uintptr_t)id);
> > 
> >  	if (chan)
> >  	
> >  		to_shdma_chan(chan)->hw_req = id;
> > 
> > diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
> > index c7e9cdf..4e7df43 100644
> > --- a/drivers/dma/sh/sudmac.c
> > +++ b/drivers/dma/sh/sudmac.c
> > @@ -178,8 +178,8 @@ static int sudmac_desc_setup(struct shdma_chan *schan,
> > 
> >  	struct sudmac_chan *sc = to_chan(schan);
> >  	struct sudmac_desc *sd = to_desc(sdesc);
> > 
> > -	dev_dbg(sc->shdma_chan.dev, "%s: src=%x, dst=%x, len=%d\n",
> > -		__func__, src, dst, *len);
> > +	dev_dbg(sc->shdma_chan.dev, "%s: src=%pad, dst=%pad, len=%zu\n",
> > +		__func__, &src, &dst, *len);
> > 
> >  	if (*len > schan->max_xfer_len)
> >  	
> >  		*len = schan->max_xfer_len;

-- 
Regards,

Laurent Pinchart


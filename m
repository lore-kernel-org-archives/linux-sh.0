From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Nov 2013 16:03:25 +0000
Subject: Re: [PATCH 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <2028164.izn6i5W5EG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385512192-10303-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512192-10303-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Andy,

On Wednesday 27 November 2013 12:27:41 Shevchenko, Andriy wrote:
> On Wed, 2013-11-27 at 01:29 +0100, Laurent Pinchart wrote:
> 
> > Use the %zu printk specifier to print size_t variables, and cast
> > pointers to unsigned long instead of unsigned int where applicable. This
> > fixes warnings on platforms where pointers and/or dma_addr_t have a
> > different size than int.
> 
> Few comments below.
> 
> > diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> > index 2e7b394..b37d584 100644
> > --- a/drivers/dma/sh/shdma-base.c
> > +++ b/drivers/dma/sh/shdma-base.c
> > @@ -227,7 +227,7 @@ bool shdma_chan_filter(struct dma_chan *chan, void
> > *arg)
> >  	struct shdma_chan *schan = to_shdma_chan(chan);
> >  	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
> >  	const struct shdma_ops *ops = sdev->ops;
> > -	int match = (int)arg;
> > +	int match = (long)arg;
> 
> As far as I understand this will lose data on 64bit platforms.
> Are you aware of it? Otherwise I don't see the advantage of such
> conversion. As far as I understand you may cast void * easily to long
> and back, otherwise you lost data.

That's correct, but shouldn't be an issue here. The match value is a small 
integer. The reason why I cast it to long is to avoid compilation warnings

> >  	int ret;
> >  
> >  	if (match < 0)
> > @@ -491,9 +491,9 @@ static struct shdma_desc *shdma_add_desc(struct
> > shdma_chan *schan,
> >  	}
> >  
> >  	dev_dbg(schan->dev,
> > -		"chaining (%u/%u)@%x -> %x with %p, cookie %d\n",
> > -		copy_size, *len, *src, *dst, &new->async_tx,
> > -		new->async_tx.cookie);
> > +		"chaining (%zu/%zu)@%lx -> %lx with %p, cookie %d\n",
> > +		copy_size, *len, (unsigned long)*src, (unsigned long)*dst,
> > +		&new->async_tx, new->async_tx.cookie);
> 
> Instead of dancing with casting (actually for dma_addr_t it should be
> ULL type), we can extend %pa to do this job for us:

That sounds good to me. Do you plan to submit a patch ? I'd like to get this 
series upstream in v3.14.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 10909c5..0806bf0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1354,10 +1354,17 @@ char *pointer(const char *fmt, char *buf, char
> *end, void *ptr,
>  		break;
>  	case 'a':
>  		spec.flags |= SPECIAL | SMALL | ZEROPAD;
> -		spec.field_width = sizeof(phys_addr_t) * 2 + 2;
>  		spec.base = 16;
> -		return number(buf, end,
> -			      (unsigned long long) *((phys_addr_t *)ptr), spec);
> +		switch (fmt[1]) {
> +		case 'D':
> +			spec.field_width = sizeof(dma_addr_t) * 2 + 2;
> +			return number(buf, end,
> +				(unsigned long long)*((dma_addr_t *)ptr), spec);
> +		default:
> +			spec.field_width = sizeof(phys_addr_t) * 2 + 2;
> +			return number(buf, end,
> +				(unsigned long long)*((phys_addr_t *)ptr), spec);
> +		}
>  	case 'd':
>  		return dentry_name(buf, end, ptr, spec, fmt);
>  	case 'D':
> 
> Thus, use %paD.
> 
> 
> >  	new->mark = DESC_PREPARED;
> >  	new->async_tx.flags = flags;
> > 
> > @@ -555,7 +555,7 @@ static struct dma_async_tx_descriptor
> > *shdma_prep_sg(struct shdma_chan *schan,
> >  			goto err_get_desc;
> >  
> >  		do {
> > -			dev_dbg(schan->dev, "Add SG #%d@%p[%d], dma %llx\n",
> > +			dev_dbg(schan->dev, "Add SG #%d@%p[%zu], dma %llx\n",
> >  				i, sg, len, (unsigned long long)sg_addr);
> >  
> >  			if (direction = DMA_DEV_TO_MEM)
> > diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
> > index 06473a0..7fdb67b 100644
> > --- a/drivers/dma/sh/shdma-of.c
> > +++ b/drivers/dma/sh/shdma-of.c
> > @@ -33,7 +33,8 @@ static struct dma_chan *shdma_of_xlate(struct
> > of_phandle_args *dma_spec,
> >  	/* Only slave DMA channels can be allocated via DT */
> >  	dma_cap_set(DMA_SLAVE, mask);
> >  
> > -	chan = dma_request_channel(mask, shdma_chan_filter, (void *)id);
> > +	chan = dma_request_channel(mask, shdma_chan_filter,
> > +				   (void *)(unsigned long)id);
> >  	if (chan)
> >  		to_shdma_chan(chan)->hw_req = id;
> >  
> > diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
> > index c7e9cdf..2112ed2 100644
> > --- a/drivers/dma/sh/sudmac.c
> > +++ b/drivers/dma/sh/sudmac.c
> > @@ -178,8 +178,8 @@ static int sudmac_desc_setup(struct shdma_chan
> > *schan,
> >  	struct sudmac_chan *sc = to_chan(schan);
> >  	struct sudmac_desc *sd = to_desc(sdesc);
> > 
> > -	dev_dbg(sc->shdma_chan.dev, "%s: src=%x, dst=%x, len=%d\n",
> > -		__func__, src, dst, *len);
> > +	dev_dbg(sc->shdma_chan.dev, "%s: src=%lx, dst=%lx, len=%zu\n",
> > +		__func__, (unsigned long)src, (unsigned long)dst, *len);
> >  
> >  	if (*len > schan->max_xfer_len)
> >  		*len = schan->max_xfer_len;
-- 
Regards,

Laurent Pinchart


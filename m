From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 11 Dec 2013 14:27:41 +0000
Subject: Re: [PATCH v3 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <1467807.P36IqR6kbP@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386765786-1926-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386765786-1926-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 11 December 2013 12:59:34 Shevchenko, Andriy wrote:
> On Wed, 2013-12-11 at 13:43 +0100, Laurent Pinchart wrote:
> 
> > Use the %zu and %pad printk specifiers to print size_t and dma_addr_t
> > variables, and cast pointers to uintptr_t instead of unsigned int where
> > applicable. This fixes warnings on platforms where pointers and/or
> > dma_addr_t have a different size than int
> 
> Thanks for an updated version. Now looks better with those %pad.
> One comment below.
> 
> > @@ -555,7 +555,7 @@ static struct dma_async_tx_descriptor
> > *shdma_prep_sg(struct shdma_chan *schan,
> >  			goto err_get_desc;
> >  
> >  		do {
> > -			dev_dbg(schan->dev, "Add SG #%d@%p[%d], dma %llx\n",
> > +			dev_dbg(schan->dev, "Add SG #%d@%p[%zu], dma %llx\n",
> >  				i, sg, len, (unsigned long long)sg_addr);
> 
> sg_addr -> %pad as well ?

Indeed. I'll repost this patch.

-- 
Regards,

Laurent Pinchart


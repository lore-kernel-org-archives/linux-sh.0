From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 28 Aug 2014 07:22:53 +0000
Subject: Re: [PATCH 5/6] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <20140828071053.GK13288@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 20, 2014 at 07:27:32PM +0200, Laurent Pinchart wrote:

> > > > >>> +static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan
> > > > >>> *chan,
> > > > >>> +					 dma_cookie_t cookie)
> > > > >>> +{
> > > > >>> +	struct rcar_dmac_desc *desc = chan->desc.running;
> > > > >>> +	struct rcar_dmac_hw_desc *hwdesc;
> > > > >>> +	size_t residue = 0;
> > > > >>> +
> > > > >>> +	if (!desc)
> > > > >>> +		return 0;
> > > > >> 
> > > > >> Why?
> > > > >> We should be able to query even when channel is not running, right?
> > > > > 
> > > > > Good question, should we ? :-)
> > > > > 
> > > > > This would require going through all lists to find the descriptor
> > > > > corresponding to the cookie, and returning either 0 (if the descriptor
> > > > > has
> > > > > been processed completely) or the descriptor length (if it hasn't been
> > > > > processed yet). This is potentially costly.
> > > > 
> > > > Not really, the status of descriptor will tell you.
> > > > 
> > > > > The first case can be easily handled using the cookie only, when
> > > > > dma_cookie_status() state returns DMA_COMPLETE then we know that the
> > > > > residue is 0. This is actually the current behaviour, as
> > > > > dma_cookie_status() zeroes the residue field.a
> > > > 
> > > > yes this is the key
> > > > 
> > > > > Is the second case something we need to support ? chan->desc.running
> > > > > is only NULL when there's no descriptor to process. In that case the
> > > > > cookie can either correspond to a descriptor already complete (first
> > > > > case), a descriptor prepared but not submitted or an invalid
> > > > > descriptor (in which case we can't report the residue anyway). Is
> > > > > there really a use case for reporting the residue for a descriptor not
> > > > > submitted ? That seems like a bad use of the API to me, I think it
> > > > > would be better to forbid it.
> > > > 
> > > > So you need to check only running list. For the queued up descriptor it
> > > > is easy enough. For the one which is running you are already doing the
> > > > calculation. For completed but still not preocessed it is zero anyway
> > > 
> > > I'm still not convinced. Reporting the residue for a descriptor that
> > > hasn't been started yet will require looping through lists with locks
> > > held, and I'm not sure to see what benefit it would bring. Do we have DMA
> > > engine users that retrieve (and use) the residue value of descriptors that
> > > haven't been started yet ?
> > 
> > well for the descriptor not started you have only one list to look.
> 
> Two of them actually, the pending (submitted but not issued) and the active 
> list. But regardless of whether that would be one or two lists, it would still 
> involve looping over descriptors with a lock held. If there's no use case for 
> this on the caller side, I'd rather not implement dead code.
But you can reduce that to 1 by keeping tracked of submitted desciptor
number along with completed we do now

Well its not about dead code, but about API expects, since API allows
it we should put restrictionss. If people use ut rarely then we dont need to
worry about performance on this one

-- 
~Vinod
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

-- 

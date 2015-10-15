From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Oct 2015 16:49:15 +0000
Subject: Re: [PATCH v3 4/6] dma: rcar-dma: use result of updated get_residue in tx_status
Message-Id: <12352025.ijSEGDcSkl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-5-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-5-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Monday 12 October 2015 20:42:32 Vinod Koul wrote:
> On Tue, Sep 29, 2015 at 10:44:46PM +0200, hamzahfrq.sub@gmail.com wrote:
> > From: Muhammad Hamza Farooq <mfarooq@visteon.com>
> > 
> > Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
> > ---
> > 
> >  drivers/dma/sh/rcar-dmac.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> > index 6c806d0..0b5a367 100644
> > --- a/drivers/dma/sh/rcar-dmac.c
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -1258,6 +1258,10 @@ static enum dma_status rcar_dmac_tx_status(struct
> > dma_chan *chan,> 
> >  	residue = rcar_dmac_chan_get_residue(rchan, cookie);
> >  	spin_unlock_irqrestore(&rchan->lock, flags);
> > 
> > +	/* if there's no residue, the cookie is complete */
> > +	if (!residue)
> > +		return DMA_COMPLETE;
> > +
> 
> why would we get this, you should not be here if the status is complete and
> exited before you checked the status

The status check is a software check, while the residue check reads hardware 
registers. The hardware might have complete the transfer but the interrupt 
handler might not have had a chance to run yet.

Is it valid from a DMA engine API point of view to return a DMA_IN_PROGRESS 
status with a 0 residue ?

-- 
Regards,

Laurent Pinchart


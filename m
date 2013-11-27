From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Nov 2013 10:04:10 +0000
Subject: Re: [PATCH] mtd: sh_flctl: Fix warnings due to improper casts
Message-Id: <6761292.WxSa3C6mKM@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385512511-10477-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131127021140.GV9468@ld-irv-0074.broadcom.com>
In-Reply-To: <20131127021140.GV9468@ld-irv-0074.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Norris <computersforpeace@gmail.com>, linux-sh@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org

Hi Brian,

On Tuesday 26 November 2013 18:11:40 Brian Norris wrote:
> On Wed, Nov 27, 2013 at 01:35:11AM +0100, Laurent Pinchart wrote:
> > Cast pointers to unsigned long instead of unsigned int. This fixes
> > warnings on platforms where pointers have a different size than int.
> > 
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: linux-mtd@lists.infradead.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/mtd/nand/sh_flctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
> > index a3c84eb..b1e2b13 100644
> > --- a/drivers/mtd/nand/sh_flctl.c
> > +++ b/drivers/mtd/nand/sh_flctl.c
> > @@ -151,7 +151,7 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
> >  	dma_cap_set(DMA_SLAVE, mask);
> >  	
> >  	flctl->chan_fifo0_tx = dma_request_channel(mask, shdma_chan_filter,
> > -					    (void *)pdata->slave_id_fifo0_tx);
> > +			(void *)(unsigned long)pdata->slave_id_fifo0_tx);
> 
> Perhaps the intermediate cast should be for uintptr_t instead of
> unsigned long, just to be more exact? (I see that uintptr_t is just
> typedef'd for unsigned long, but it still seems more precise.)

Good point. I'll fix that and resubmit.

> >  	dev_dbg(&pdev->dev, "%s: TX: got channel %p\n", __func__,
> >  		flctl->chan_fifo0_tx);
> > 
> > @@ -168,7 +168,7 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
> >  		goto err;
> >  	
> >  	flctl->chan_fifo0_rx = dma_request_channel(mask, shdma_chan_filter,
> > -					    (void *)pdata->slave_id_fifo0_rx);
> > +			(void *)(unsigned long)pdata->slave_id_fifo0_rx);
> 
> Ditto.
> 
> >  	dev_dbg(&pdev->dev, "%s: RX: got channel %p\n", __func__,
> >  		flctl->chan_fifo0_rx);

-- 
Regards,

Laurent Pinchart


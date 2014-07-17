From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Jul 2014 01:08:53 +0000
Subject: Re: [PATCH 4/7] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <25577078.3zuHvqsEun@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 16 July 2014 17:59:39 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > > +	if (chan->mid_rid >= 0)
> > > > +		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
> > > 
> > > I guess (chan->mid_rid < 0) case should be error
> > 
> > No, chan->mid_rid can be 0 when using memcpy mode. It's an error in slave
> > mode only.
> 
> ?
> mid_rid > 0 : slave mode
> mid_rid = 0 : memcpy mode
> mid_rid < 0 : error

Sorry, I spoke too fast. mid_rid = 0 is a valid hardware value in slave mode. 
mid_rid < 0 denotes memcpy mode.

> We can't do this ?
> 
> static void rcar_dmac_chan_start_xfer(xxx)
> {
>    if (chan->mid_rid < 0)
>           return err;
>    ...
>    rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
>    ...
> }
> 
> > > This kcalloc() is using fixed size.
> > > we can't use this ?
> > > 
> > > 	struct scatterlist sgl[RCAR_DMAC_MAX_SG_LEN];
> > 
> > That's what the shdma-base driver does, and gcc warns that it consumes
> > more than 1024 bytes of stack space. Given that the kernel stack size is
> > fixed we should be conservative to avoid stack overflows. I think we
> > should fix shdma- base.
> 
> Ahh... I understand
> Is it possible to put this in comment line ?

Sure.

> > > > +	dmac->clk = clk_get(&pdev->dev, "fck");
> > > > +	if (IS_ERR(dmac->clk)) {
> > > > +		dev_err(&pdev->dev, "unable to get fck clock\n");
> > > > +		return PTR_ERR(dmac->clk);
> > > > +	}
> > > 
> > > Maybe this is my misunderstanding,
> > > but, which clock are you expecting to "fck" clock ?
> > > Is it not same as pm_runtime_xxx()'s clock ?
> > 
> > It's the MSTP clock for the DMAC.
> 
> Hmm...
> So why do you use clk_xxx() instead of pm_runime_xxx() on suspend/resume ?
> I forgot detail, but, I got trouble when it used both clk_xxx() and
> pm_runime_xxx() for same clock.
> Because these have different counter.

Are you talking about letting the drivers/sh/pm_runtime.c code handle the 
clock automatically ? Yes, I think that should work. I'll test it.

> > > > +	/* Enable runtime PM and initialize the device. */
> > > > +	pm_runtime_enable(&pdev->dev);
> > > > +	ret = pm_runtime_get_sync(&pdev->dev);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = rcar_dmac_init(dmac);
> > > > +	pm_runtime_put(&pdev->dev);
> > > 
> > > power ON -> initialize -> power OFF here,
> > > and shdmac.c has similar method.
> > > And it works, but, it is a littile bit strange for me :P
> > 
> > Don't forget that runtime PM can be disabled in the kernel configuration.
> > In that case this is the only place where the DMAC hardware will be
> > initialized.
>
> This driver is counting driver users.
> So, I thought that we can initialize driver if it was 1st user.

It could be done, but that would be more complex as the DMAC would be 
reinitialized every time the use count increases from 0 to 1.

-- 
Regards,

Laurent Pinchart


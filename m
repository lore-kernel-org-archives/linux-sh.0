From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 11 Dec 2014 21:42:47 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <2462101.Er8OZg9N24@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de> <10746939.zT8Pinqvll@avalon> <20141210142314.GB8247@katana>
In-Reply-To: <20141210142314.GB8247@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wolfram,

On Wednesday 10 December 2014 15:23:15 Wolfram Sang wrote:
> On Wed, Dec 10, 2014 at 04:19:36PM +0200, Laurent Pinchart wrote:
> > (CC'ing the dmaengine mailing list)
> 
> Thanks!
> 
> > On Wednesday 10 December 2014 09:01:55 Wolfram Sang wrote:
> > > On Wed, Dec 10, 2014 at 02:44:01PM +0900, Magnus Damm wrote:
> > > > On Tue, Dec 9, 2014 at 11:09 PM, Wolfram Sang wrote:
> > > >> On Tue, Dec 09, 2014 at 11:53:45AM +0100, Geert Uytterhoeven wrote:
> > > >>> On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang wrote:
> > > >>>> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> > > >>>> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> > > >>>> @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct
> > > >>>> platform_device *dev)
> > > >>>> 
> > > >>>>         if (ret)
> > > >>>>         
> > > >>>>                 return ret;
> > > >>>> 
> > > >>>> +       /* Init DMA */
> > > >>>> +       sg_init_table(&pd->sg, 1);
> > > >>>> +       pd->dma_direction = DMA_NONE;
> > > >>>> +       ret = sh_mobile_i2c_request_dma_chan(pd->dev,
> > > >>>> DMA_DEV_TO_MEM,
> > > >>>> +                                            res->start + ICDR,
> > > >>>> &pd->dma_rx);
> > > >>>> +       if (ret = -EPROBE_DEFER)
> > > >>>> +               return ret;
> > > >>>> +
> > > >>>> +       ret = sh_mobile_i2c_request_dma_chan(pd->dev,
> > > >>>> DMA_MEM_TO_DEV,
> > > >>>> +                                            res->start + ICDR,
> > > >>>> &pd->dma_tx);
> > > >>>> +       if (ret = -EPROBE_DEFER) {
> > > >>>> +               sh_mobile_i2c_release_dma(pd);
> > > >>>> +               return ret;
> > > >>>> +       }
> > > >>>> +
> > > >>> 
> > > >>> If the DTS contains "dma" and "dma-names" properties, but
> > > >>> CONFIG_RCAR_DMAC is disabled, sh_mobile_i2c_request_dma_chan()
> > > >>> returns -EPROBE_DEFER, and the driver fails to initialize.
> > > >>> 
> > > >>> If I remove the "dma" and "dma-names" properties, the driver does
> > > >>> fall back to PIO mode.
> > > >>> 
> > > >>> I think this is a regression.
> > > >> 
> > > >> The only solution I can think of is to not bail out here and retry
> > > >> again before every transfer? Doesn't sound elegant, though...
> > > > 
> > > > I think we have to request for each and every transfer. And fall back
> > > > to PIO as default in a transparent way. This because the number of DMA
> > > > channels are limited compared to number of potential consumers, so
> > > > request failure may happen at any time.
> > > 
> > > AFAIR this scenario happens when submitting the transfer. The check
> > > for this is already in place. Requesting the channel is a different
> > > matter. Still, I'll cook up a patch and we will see what it looks
> > > like...
> > 
> > We could fix part of the issue by using virtual dma channels. In that case
> > channel requests wouldn't fail anymore due to resource starvation with a
> > large number of consumers. However, the request could still fail with
> > -EPROBE_DEFER. For a driver that wants to fall back to PIO when DMA is
> > unavailable I currently don't see another way than moving the channel
> > request at the time of the transfer.
> 
> Note that the I2C drives uses subsys_initcall() for historic reasons,
> while the DMA driver uses module_init(). This is hard to revert without
> introducing potential regressions on older boards. So, the I2C DMA
> support needs to handle deferred probe definately. I am with Laurent, I
> don't see any other way, but I'd be glad to be enlightened...

While I believe that requesting the channel at transfer time is the good 
solution, I think we should still try to move to module initcalls where 
possible. The risk of regressions is real so proper testing is needed. My 
question is, have you tried it ?

-- 
Regards,

Laurent Pinchart


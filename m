From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Dec 2014 09:42:46 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <4201209.QyaBUSHXat@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de> <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com> <20141215091314.GQ16827@intel.com>
In-Reply-To: <20141215091314.GQ16827-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Vinod,

On Monday 15 December 2014 14:43:14 Vinod Koul wrote:
> On Mon, Dec 15, 2014 at 09:31:01AM +0100, Geert Uytterhoeven wrote:
> > Please let me summarize...
> 
> Thanks :)
> 
> > During probe of a DMA client driver, the DMA engine driver may not be
> > available, causing dma_request_slave_channel*() to return -EPROBE-DEFER.
> > There are actually two different reasons that the DMA engine driver may
> > not be available:
> >
> > 1. The DMA engine driver hasn't been initialized yet, due to probe order.
> >    This is more likely to happen with i2c client drivers, as they are
> >    initialized from subsys_initcall() instead of module_init() (E.g. I
> >    never saw it with the spi-rspi driver).
> >    => The DMA client driver wants to return -EPROBE_DEFER too, and
> >       retry later.
> >   
> > 2. The DMA engine driver is not included in the kernel build.
> >    => The DMA client driver wants to fall back to PIO.
> > 
> > Now, how to distinguish between the two cases above?
> 
> Quite right, this is a good question. Today we cannot distinguish between
> the two. Should we improve the deferred probe to tell us when the init is
> complete and all the modules have been initialized?

I don't think that's possible, as you can never know when a module will be 
loaded.

> If we ever have such a mechanism to check then we know no modules are to be
> inserted then we can fall back to PIO mode. Without that we should use some
> timeout counter to fall back on, say try requesting 5 times and give up and
> move to PIO after that

That could be a performance improvement, but I wonder whether it's worth it. 
If DT specifies DMA channels for the I2C controller, and the DMA core is 
compiled in, and the DMA engine driver is compiled as a module and never 
loaded, then yes, there will be a small overhead for each I2C transaction, but 
I'd argue that such a combination of conditions is asking for trouble anyway 
:-)

> > Currently, e.g. i2c-sh_mobile always returns -EPROBE_DEFER, never falling
> > back to PIO, breaking case 2. While e.g. spi-rspi always falls back to
> > PIO, which is suboptimal in case 1 (but I never encountered that case with
> > spi).
> > 
> > Solutions under consideration:
> > 1. Wolfram posted a patch to make i2c-sh_mobile fall back to PIO, and
> >    retry DMA initialization in every request, so it will switch to DMA
> >    when it becomes available. But this is suboptimal, as it adds overhead
> >    to every request (and DMA may never become available in case 2).
> >   
> > 2. Delay i2c initialization, by moving from subsys_initcall() to
> >    module_init(), in the hope the i2c client driver will be initialized
> >    after the DMA engine.
> > 
> >    This is being discussed in the thread you quoted above.
> > 
> > I hope this explains the problem well.
> 
> Yes and it has nothing to do with channels being exhausted, the problem I
> assumed earlier!!

-- 
Regards,

Laurent Pinchart


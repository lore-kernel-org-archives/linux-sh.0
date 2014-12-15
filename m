From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 15 Dec 2014 14:48:11 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141215144804.GR16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
 <20141215091314.GQ16827@intel.com>
 <4201209.QyaBUSHXat@avalon>
In-Reply-To: <4201209.QyaBUSHXat@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 15, 2014 at 11:42:46AM +0200, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Monday 15 December 2014 14:43:14 Vinod Koul wrote:
> > On Mon, Dec 15, 2014 at 09:31:01AM +0100, Geert Uytterhoeven wrote:
> > > Please let me summarize...
> > 
> > Thanks :)
> > 
> > > During probe of a DMA client driver, the DMA engine driver may not be
> > > available, causing dma_request_slave_channel*() to return -EPROBE-DEFER.
> > > There are actually two different reasons that the DMA engine driver may
> > > not be available:
> > >
> > > 1. The DMA engine driver hasn't been initialized yet, due to probe order.
> > >    This is more likely to happen with i2c client drivers, as they are
> > >    initialized from subsys_initcall() instead of module_init() (E.g. I
> > >    never saw it with the spi-rspi driver).
> > >    => The DMA client driver wants to return -EPROBE_DEFER too, and
> > >       retry later.
> > >   
> > > 2. The DMA engine driver is not included in the kernel build.
> > >    => The DMA client driver wants to fall back to PIO.
> > > 
> > > Now, how to distinguish between the two cases above?
> > 
> > Quite right, this is a good question. Today we cannot distinguish between
> > the two. Should we improve the deferred probe to tell us when the init is
> > complete and all the modules have been initialized?
> 
> I don't think that's possible, as you can never know when a module will be 
> loaded.
In a production system it is quite reasonable to assume that usermode will
find all the modules available for the devices detected and insert them post
boot within a reasonable amount of time.

> > If we ever have such a mechanism to check then we know no modules are to be
> > inserted then we can fall back to PIO mode. Without that we should use some
> > timeout counter to fall back on, say try requesting 5 times and give up and
> > move to PIO after that
> 
> That could be a performance improvement, but I wonder whether it's worth it. 
> If DT specifies DMA channels for the I2C controller, and the DMA core is 
> compiled in, and the DMA engine driver is compiled as a module and never 
> loaded, then yes, there will be a small overhead for each I2C transaction, but 
> I'd argue that such a combination of conditions is asking for trouble anyway 
> :-)
Yes that is quite reasonable. For a proper production system it should be a
fair assumption that drivers for hardware available should be available and if
not possibly a buggy configuration which must be fixed anyway.

-- 
~Vinod


From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 17 Feb 2015 14:09:41 +0000
Subject: Re: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <7327655.BEsKsTMj3g@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 17 February 2015 00:10:10 Kuninori Morimoto wrote:
> Hi Arnd
> Cc Mark Brown
> 
> > > http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC372
> > 
> > I had the chance to discuss this in more depth with Laurent last
> > week. What it basically comes down to is that you try to do something
> > that the existing DT binding and slave API does not support: we
> > only really do DMA_DEV_TO_MEM or DMA_MEM_TO_DEV, but not DMA_DEV_TO_DEV.
> > 
> > To properly support this with the dmaengine API, we would likely first
> > need to extend the generic DT binding, and then implement the driver
> > to use that extended binding.
> > 
> > The easiest way out however seems to be to move the audmapp
> > implementation into the rcar audio driver itself. As Laurent pointed
> > out, it is not really a general-purpose dmaengine anyway and it
> > only ever gets used by one driver, so we could not find any downsides.
> 
> Hmm... OK I understand.
> 
> Mark
> 
> I try to move audmapp from current drivers/dma/sh/rcar-audmapp.c
> to sound/soc/sh/rcar/
> 

Sounds good.

I've thought some more about what it would really mean to support
DMA_DEV_TO_DEV with the existing framework and binding. I believe
we can actually do this with the existing DT binding if we really
wanted to, but the dmaengine code would have to change. At the
moment, we have 

struct dma_chan *dma_request_slave_channel_reason(struct device *dev,
                                                  const char *name);

as the main interface. What I think we would need is a respective
interface that takes two separate names for source and sink, like

struct dma_chan *dma_request_dev_to_dev_channel(struct device *dev,
                                                const char *source,
						 const char *sink);

Then you'd list all available sources and all sinks separately
in the device node for the audio device and combine the ones you
need.

Making this particular device specific to the audio driver is
still much easier, I just wanted to ensure we document it here
in case we need the same functionality later for something else.

There seems to be some weird workaround for a related problem
in sound/soc/fsl/fsl_asrc_dma.c, which tries to get two channels
individually, and then puts them into a private datas structre
and filter function to get a third channel that is actually being
used.

	Arnd

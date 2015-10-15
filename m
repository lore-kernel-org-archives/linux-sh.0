From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Oct 2015 13:38:02 +0000
Subject: Re: [PATCH 1/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
Message-Id: <6339568.5jUx9m7nQC@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Arnd,

Revisiting this old topic.

On Friday 23 January 2015 14:16:38 Arnd Bergmann wrote:
> On Thursday 22 January 2015 23:25:49 Laurent Pinchart wrote:
> > Actually the R-Car platforms suffer from the same multiplexing issue. We
> > have decided to implement a new R-Car DMAC driver due to the complexity
> > of adding new features to the existing code base, aiming at a "start
> > clean from scratch" approach.
> > 
> > Multiplexing isn't supported by the new driver. How to implement that
> > properly will need to be discussed when and if needed.
> 
> Ok, I see. Do these chips also multiplex between dma engine instances
> with different drivers, or only between similar dma engine IP blocks?

Only between different instances of the same IP core.

> When we created the generic dmaengine binding, we intentionally
> mandated the use of dma-names do allow you specify multiple connections
> in one property, and if they have the same name, the dmaengine core
> should be free to pick any of them.
> 
> I believe this was never implemented in Linux though, so the dmaengine
> core picks the first one with a matching name and does not try any
> others when it fails. We would need to come up with a good policy to
> decide in which order to try the channels, but implementing any scheme
> should not be too hard.

The biggest problem I see there is when to decide on channel allocation. The 
current DMA engine API expects association between slaves and DMA engines to 
be decided at channel request time. However, drivers usually request channels 
at probe time, even if they rarely use the channels. We end up with resources 
being allocated and held when they could really be shared. The virtual DMA 
channels API tries to fix that but doesn't push back allocation to usage time.

How should we fix that ? And more importantly, is it worth fixing ? It looks 
like pretty much everybody works around the issue on platforms where the 
number of slaves exceeds the number of channels.

> The current shdma multiplexing driver with the "renesas,shdma-mux" binding
> implements a different scheme, but also incomplete: The binding documents
> that it multiplexes between the dmaengine devices that are children of
> the mux. The driver instead multiplexes between all dmaengine devices
> that are registered through shdma_init() regardless of their location
> in DT. Apparently this resulted in the correct behavior for all the
> traditional SoCs on which all the dmaengines are multiplexed together,
> but it broke for the r-car audmapp that is not multiplexed in the same
> way.

I don't really like that implementation given that it uses DT to describe a 
virtual mux. For platforms where the number of DMA engines is low (such as R-
Car where we have two system DMA engines) I think listing possible channels 
explicitly in DT should be fine. If we had a high number of interchangeable 
DMA engines it would be another story.

-- 
Regards,

Laurent Pinchart


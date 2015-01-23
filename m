From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Jan 2015 13:16:38 +0000
Subject: Re: [PATCH 1/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
Message-Id: <6958556.TH4TtkM2f3@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 22 January 2015 23:25:49 Laurent Pinchart wrote:
> 
> Actually the R-Car platforms suffer from the same multiplexing issue. We have 
> decided to implement a new R-Car DMAC driver due to the complexity of adding 
> new features to the existing code base, aiming at a "start clean from scratch" 
> approach.
> 
> Multiplexing isn't supported by the new driver. How to implement that properly 
> will need to be discussed when and if needed.
> 

Ok, I see. Do these chips also multiplex between dma engine instances
with different drivers, or only between similar dma engine IP blocks?

When we created the generic dmaengine binding, we intentionally
mandated the use of dma-names do allow you specify multiple connections
in one property, and if they have the same name, the dmaengine core
should be free to pick any of them.

I believe this was never implemented in Linux though, so the dmaengine
core picks the first one with a matching name and does not try any
others when it fails. We would need to come up with a good policy to
decide in which order to try the channels, but implementing any scheme
should not be too hard.

The current shdma multiplexing driver with the "renesas,shdma-mux" binding
implements a different scheme, but also incomplete: The binding documents
that it multiplexes between the dmaengine devices that are children of
the mux. The driver instead multiplexes between all dmaengine devices
that are registered through shdma_init() regardless of their location
in DT. Apparently this resulted in the correct behavior for all the
traditional SoCs on which all the dmaengines are multiplexed together,
but it broke for the r-car audmapp that is not multiplexed in the same
way.

	Arnd

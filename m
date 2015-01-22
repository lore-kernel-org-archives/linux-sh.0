From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 00:24:05 +0000
Subject: Re: [PATCH] dmaengine: rcar-hpbdma: tidyup residue_granularity
Message-Id: <87iofzmzl4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbk0n3q3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbk0n3q3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > The driver doesn't support residue reporting at all.
> > residue_granularity should be set to DMA_RESIDUE_GRANULARITY_DESCRIPTOR.
> > Special thanks to Laurent
> > 
> > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> I thought the plan was to fix this in v4 of "[PATCH v3] dmaengine:: rcar-
> hpbdma: add dma_dev->directions" ?

Yes, I had same plan, but, it seems that dma/next branch already had
previous patch. so, I sent additional patch

I'm happy to create v4 patch of course.
 => Vinod ?


Best regards
---
Kuninori Morimoto

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Feb 2015 00:41:28 +0000
Subject: Re: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <87wq3g9hiz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd

Thank you for your feedback

> I've thought some more about what it would really mean to support
> DMA_DEV_TO_DEV with the existing framework and binding. I believe
> we can actually do this with the existing DT binding if we really
> wanted to, but the dmaengine code would have to change. At the
> moment, we have 
> 
> struct dma_chan *dma_request_slave_channel_reason(struct device *dev,
>                                                   const char *name);
> 
> as the main interface. What I think we would need is a respective
> interface that takes two separate names for source and sink, like
> 
> struct dma_chan *dma_request_dev_to_dev_channel(struct device *dev,
>                                                 const char *source,
> 						 const char *sink);
>
> Then you'd list all available sources and all sinks separately
> in the device node for the audio device and combine the ones you
> need.
> 
> Making this particular device specific to the audio driver is
> still much easier, I just wanted to ensure we document it here
> in case we need the same functionality later for something else.

Ahh... Actually I didn't 100% understand about your concern
of DT bindings. but, now I could.
Thank you for your explain


Best regards
---
Kuninori Morimoto

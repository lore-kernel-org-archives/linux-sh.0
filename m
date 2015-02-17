From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Feb 2015 00:10:10 +0000
Subject: Re: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <877fvhtn14.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd
Cc Mark Brown

> > http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC372
> 
> I had the chance to discuss this in more depth with Laurent last
> week. What it basically comes down to is that you try to do something
> that the existing DT binding and slave API does not support: we
> only really do DMA_DEV_TO_MEM or DMA_MEM_TO_DEV, but not DMA_DEV_TO_DEV.
> 
> To properly support this with the dmaengine API, we would likely first
> need to extend the generic DT binding, and then implement the driver
> to use that extended binding.
> 
> The easiest way out however seems to be to move the audmapp
> implementation into the rcar audio driver itself. As Laurent pointed
> out, it is not really a general-purpose dmaengine anyway and it
> only ever gets used by one driver, so we could not find any downsides.

Hmm... OK I understand.

Mark

I try to move audmapp from current drivers/dma/sh/rcar-audmapp.c
to sound/soc/sh/rcar/


Best regards
---
Kuninori Morimoto

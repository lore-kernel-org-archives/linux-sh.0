From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 23 Jul 2014 23:56:56 +0000
Subject: Re: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor list support
Message-Id: <87zjfzaata.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > 1. "filter" still can't care "dma0" or "audma0"
> > 
> >  	dmac0: dma-controller@e6700000 {
> > 	..
> > 	};
> > 	dmac1: dma-controller@e6720000 {
> > 	...
> > 	};
> > 	audma0: dma-contorller@ec700000 {
> > 	...
> > 	};
> > 	audma1: dma-controller@ec720000 {
> > 	...
> > 	};
> > 	audmapp: audio-dma-pp@0xec740000 {
> > 	...
> > 	};
> > 
> >   audio driver requests "audma0, 0x01",
> >   but, filter accepts it as "dmac0, 0x01"
> 
> Indeed, I've fixed the rcar-dmac driver to ignore channels handled by a 
> different driver, but not channels handled by the same driver but a different 
> device. I'll fix that.

Thank you

> By the way, I've noticed an issue with the snd_soc_rcar driver. If a 
> dma_request_slave_channel_compat() call fails in a module probe operation, the 
> rsnd_probe() function will return an error immediately
> 
>         for_each_rsnd_dai(rdai, priv, i) {
>                 ret = rsnd_dai_call(probe, &rdai->playback, rdai);
>                 if (ret)
>                         return ret;
> 
>                 ret = rsnd_dai_call(probe, &rdai->capture, rdai);
>                 if (ret)
>                         return ret;
>         }
>
> The modules that have been successfully probed are not cleaned up, so DMA 
> channels allocated by modules successfully probed are never released.

Hmm... indeed.
Thank you. I will fix.

> > 2. cyclic transfer doesn't work
> > 
> >    I got attached error.
> 
> I'm not too surprised as I haven't tested cyclic DMA yet :-) I'll fix it.

Hehehe :)

Please let me know if you need my help

Best regards
---
Kuninori Morimoto

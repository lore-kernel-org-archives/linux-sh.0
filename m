From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Dec 2014 00:27:17 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <87lhm41o1x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Vinod

> > pattern 1)
> > 	    1st DMA
> > 	[mem] -> [SSI] -> speaker
> > 
> > pattern 2)
> > 	    1st DMA  2nd DMA
> > 	[mem] -> [SRC] -> [SSI] -> speaker
> > 
> > pattern 3)
> > 	    1st DMA          2nd DMA
> > 	[mem] -> [SRC] -> [DVC] -> [SSI] -> speaker
> > 
> > SRC : 9 channel
> > DVC : 3 channel
> > SSI : 9 channel
> > 
> > Data path is board/platform specific at this point.
> > (it is nice if we can select these pattern flexibility in the future)
> > Unfortunately, this channel size is depends on SoC,
> > and above is "playback" pattern only, we need to have "capture" pattern too.
> > (similar path, but different direction and different ID).
> > Now, it is controlled under sound driver, because sound knows all
> > information and, board/platform specific data path.
> > 
> > I thought that it is possible if sound driver uses 2 generic sound DMA
> > layer, but is it wrong ?
> 
> It's not wrong, but I wonder if it's the best solution.
> 
> Supporting the R-Car DMAC with a generic DMA engine driver is I think the best 
> solution, as the DMAC is a general-purpose DMA engine, not specific to sound. 
> There's no issue there.
>
> The second DMA controller is specific to the sound subsystem. I thus wonder if 
> the additional complexity of supporting it through the DMA engine API (both in 
> terms of code complexity on the DMA driver side and the sound driver side and 
> in terms of DT bindings complexity) is worth it, or if it would be simpler and 
> cleaner to support it with a driver specific to R-Car sound. You're more 
> knowledgeable than I am on the subject, so I'll trust your judgment.

Yes, I agree to your opinion. R-Car DMAC should keep "general-purpose" DMA engine.
It is easy to control if 1st/2nd DMA was separated from sound driver point of view.
I guess sound HW which needs 2 DMAC is very rare case(?). I want "keep it simple"

Vinod, this means, we want to have 2 different DMA (= 1st/2nd) for sound.
1st DMA is general DMAC, 2nd DMA is sound specific DMAC.
What is you opinion ?

Best regards
---
Kuninori Morimoto

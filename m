From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 01:25:51 +0000
Subject: Re: [PATCH 1/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
Message-Id: <87mw5core8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd, Laurent

Laurent, can you please correct my comment if it was wrong/un-understandable ?

> > Current Renesas Audio DMAC Peri Peri driver is based on
> > SH_DMAE_BASE driver which is used for Renesas SH-Mobile.
> > But, basically, SH_DMAE_BASE driver was created for
> > SuperH SoC, and it is not fully cared for DT.
> > 
> > For example, current SH_DMAE_BASE base driver will return
> > non-matching DMA channel if some non-SH_DMAE_BASE drivers
> > are probed.
> > So, sound driver will get wrong DMA channel
> > if Audio DMAC (= rcar-dma) was not probed,
> > but Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.
> > 
> > OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE
> > driver, and Renesas R-Car series will not use it anymore.
> > Maintenance cost for fully cared DT support on SH_DMAE_BASE
> > will be very high
> > (and keeping compatibility will be very complex).
> > 
> > In addition, Audio DMAC Peri Peri itself is very simple device,
> > and, no SoC/board is using it from non-DT environment.
> > 
> > This patch simply removes current rcar-audmapp driver.
> > 
> 
> I'm confused by the description above. From what I understand,
> the purpose of the SH_DMAE_BASE driver is to multiplex between
> the DMA engines that all share the same slaves on some of the
> shmobile/r-mobile/r-car chips. If the audma driver does not
> share its slaves with another dmaengine, it needs to register
> its own of_dma_controller, which it does.
>
> The problem you describe with getting the wrong channel seems
> to me that the shdma_chan_filter() function matches any DMA
> engine that was registered through shdma_init(), because its
> device_alloc_chan_resources function pointer matches. This problem
> could be avoided by adding some flag in shdma_dev as a bug-fix
> (also for backports to stable kernels).
> 
> That said, together with patch 2, this seems like a useful
> simplification, it just needs a better description in my mind.

Historically we used SH_DMAE_BASE driver for DMAEngine when
SH-Mobile series. and now we have new R-Car series.

R-Car series DMAC <-> SH-Mbile series DMAC are similar, but
R-Car series DMAC has more advanced feature.
Then, adding new feature on SH_DMAE_BASE seems difficult (for many reasons)
So, we decided that R-Car series uses Laurent's rcar-dmac driver
(which is not SH_DMAE_BASE driver, so it doesn't use shdma_init)
instead of SH_DMAE_BASE driver.
But, because of timing reason, this audmapp which is used
from R-Car series was created as SH_DMAE_BASE driver.

SH_DMAE_BASE driver is mainly used from non-DT platform
(it is supporting DT, but difficult to fixup/understand today)
rcar-dmac is mainly used from DT platform.

Yes, SH_DMAE_BASE filter matches any DMAEngine,
but, it matches not only shdma_init base driver,
but matches with rcar-dmac.

From compatibility/complexity from point of view,
"audmapp independent from SH_DMAE_BASE" is easier than
"fixup SH_DMAE_BASE for DT".
Because no other R-Car SoC DMAC uses SH_DMAE_BASE driver

Best regards
---
Kuninori Morimoto

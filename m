From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Dec 2014 00:51:23 +0000
Subject: Re: [PATCH][resend] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <877fy0pbs6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvd4b2kh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvd4b2kh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

> > > > Current Renesas Audio DMAC Peri Peri driver is for Renesas R-Car series,
> > > > but it is based on SH_DMAE_BASE driver which is used for Renesas
> > > > SH-Mobile. But it is not fully cared about DT.
> > > > 
> > > > For example, current SH_DMAE_BASE base driver will return non-matching
> > > > DMA channel if some non-SH_DMAE_BASE drivers are probed.
> > > > So, sound driver will get wrong DMA channel if Audio DMAC (= rcar-dma)
> > > > was not probed and Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.
> > > > 
> > > > OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE driver, and
> > > > Renesas R-Car series will not use it anymore. Maintenance cost for fully
> > > > cared DT support on SH_DMAE_BASE will be very high
> > > > (and keeping compatibility will be very complex).
> > > > 
> > > > In addition, Audio DMAC Peri Peri itself is very simple device, and,
> > > > no SoC/board is usign it from non-DT environment.
> > > > 
> > > > This patch remakes rcar-audmapp driver simply independents
> > > > from SH_DMAE_BASE.
> > > 
> > > Hi Kuninori
> > > 
> > > Can you please split these changes into multiple smaller changes so that we
> > > can review this propely...
> Since this seems to be complet rewrite then remove old and add new driver
> would be easier too

Yes, this is complete rewrite patch.
Ok, I will send like this

 [1/2]: remove old driver
 [2/2]: add new driver

Best regards
---
Kuninori Morimoto

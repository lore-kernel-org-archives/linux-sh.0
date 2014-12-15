From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Dec 2014 10:31:09 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <87lhm95hmo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

> > > When we set simple settings to DMAC, then, it works automatically as cyclic transfer.
> > > The usage of this DMA is very limited, so it is super simple.
> > > In addition, this is 2nd DMA which is needed on sound.
> > >  1st DMA is controled by rcar-dmac.c
> > >  2nd DMA is this
> > > almost all settings are set by 1st DMA, 2nd DMA is just relay.
> > okay that needs to be called out explicitly. While reading driver it wasn't
> > very clear
> > So which one is the 1st DMA, how will the client configure these two DMAs?
> 
> 1st DMA is rcar-dma which was created by Laurent.
> And it has been sent to you now.
> 
> ${LINUX}/sound/soc/sh/rcar/core.c
> is the user of these 2 dmac.
> 1st DMAC gets "from mem address", and "to reg address".
> 2nd DMAC gets "from reg address", and "to reg address".
> DMAC's ID are came from DT.

Do you have some comments about this ?
Can I send v3 patch ?

Best regards
---
Kuninori Morimoto

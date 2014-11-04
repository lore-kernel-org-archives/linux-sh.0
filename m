From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Nov 2014 02:15:53 +0000
Subject: Re: [PATCH 03/12] ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
Message-Id: <87zjc77lsu.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq7g1xcl.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87wq7g1xcl.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > > > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > > > @@ -301,6 +301,62 @@
> > > >                 dma-channels = <15>;
> > > >         };
> > > >
> > > > +       audma0: dma-contorller@ec700000 {
> > > 
> > > dma-controller
> > 
> > Morimoto-san, please consider making an incremental patch for this.
> 
> Sorry, ignore that.
> For some reason I thought that I had picked up this series.
> Please roll any updates into a fresh version of the series :)

Done.
I sent v3 patch-set which fixed above

Best regards
---
Kuninori Morimoto

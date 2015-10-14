From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Oct 2015 02:58:31 +0000
Subject: Re: [PATCH 0/18 v3] arm64: renesas: add sound support
Message-Id: <87y4f6ma8f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1xg1oc7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1xg1oc7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for your help

> > > Kuninori Morimoto (18):
> > >       arm64: renesas: tidyup MSTP9 reverse definition order
> > >       arm64: renesas: r8a7795: add I2C support
> > >       arm64: renesas: r8a7795: add AUDIO_DMAC support
> > >       arm64: renesas: r8a7795: Sound SSI PIO support
> > >       arm64: renesas: r8a7795: Sound SSI DMA support
> > >       arm64: renesas: r8a7795: Sound SRC support
> > >       arm64: renesas: r8a7795: Sound DVC support
> > >       arm64: renesas: r8a7795: Sound CTU/MIX support
> > >       arm64: renesas: salvator-x: enable I2C
> > >       arm64: renesas: salvator-x: Sound SSI PIO support
> > >       arm64: renesas: salvator-x: Sound SSI DMA support
> > >       arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
> > >       arm64: renesas: salvator-x: Sound SRC support
> > >       arm64: renesas: salvator-x: Sound DVC support
> > >       arm64: defconfig: Enable Renesas R-Car I2C Controller
> > >       arm64: defconfig: add Renesas sound and AK4613 support
> > >       arm64: defconfig: add Renesas R-Car DMAC driver support
> > >       arm64: defconfig: add CS2000 driver support
> 
> I have taken the liberty of making some minor updates to rebase this series
> and add clock-names properties - it seems that is the way to go for now..

OK, I see

> > * The above should take care of all 18 patches in this patch-set.
> >   I believe all the other patch-sets in the set of patch-sets with this is
> >   part of are driver changes and that Geert intends to handle getting them
> >   into topic branches.
> > 
> > * Please check my work, I may well have made some errors when
> >   sifting through conflicts.
> 
> Please check!
> If there are any problems please consider reposting the i2c and/or
> sound series.

OK, will check

Best regards
---
Kuninori Morimoto

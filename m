From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Sep 2015 00:25:27 +0000
Subject: Re: [PATCH 06/14][RFC] arm64: renesas: r8a7795: add SSI DMA support
Message-Id: <87bnd9hklk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> >> >                                 ssi0: ssi@0 {
> >> >                                         interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
> >> > +                                       dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
> >> > +                                       dma-names = "rx", "tx", "rxu", "txu";
> >> >                                 };
(snip)
> E.g. the Gen2/Gen3 datasheets says SSI0_0 TX MID/RID is 0x15, not 0x16,
> so the r8a7791 and r8a7795 dtsis are both wrong?

Sorry, it is very confusable.
Sound driver is assuming rx, tx for SSI point.

     tx    rx
[DMA]------->[SSI]
     <------
     rx    tx


Best regards
---
Kuninori Morimoto

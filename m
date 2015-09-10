From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 09:30:47 +0000
Subject: Re: [PATCH 05/14][RFC] arm64: renesas: r8a7795: add AUDIO-DMAC support
Message-Id: <87si6mlj5b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k2ryn3y9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k2ryn3y9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > +                       #dma-cells = <1>;
> > +                       dma-channels = <15>;
> 
> 16 channels, not 15.
(snip)
> > +                       interrupt-names = "error",
> > +                                       "ch0", "ch1", "ch2", "ch3",
> > +                                       "ch4", "ch5", "ch6", "ch7",
> > +                                       "ch8", "ch9", "ch10", "ch11",
> > +                                       "ch12", "ch13";
> 
> Missing ch14 and ch15 are at irqs 382 and 383.

Thank you for pointing these, I didn't notice about these
will fix in v2

Best regards
---
Kuninori Morimoto

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Jul 2015 08:36:24 +0000
Subject: Re: [PATCH] ARM: shmobile: tidyup Renesas generic MSTP gate clocks compatible name
Message-Id: <87wpyjklg6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a8vfm9zb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a8vfm9zb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > @@ -18,7 +18,7 @@ Required Properties:
> >      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> >      - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
> >      - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
> > -    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> > +    - "renesas,cpg-mstp-clocks" for generic MSTP gate clocks
> 
> Already fixed in upstream commit 17df1fb2e502371b ("clk: shmobile: mstp:
> Document mandatory compatible fallback").

OK, thanks

Best regards
---
Kuninori Morimoto

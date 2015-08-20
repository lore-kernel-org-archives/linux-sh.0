From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 05:26:11 +0000
Subject: Re: [PATCH 05/16 v5][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <871teycz57.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871tffeqps.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871tffeqps.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -0,0 +1,93 @@
> 
> > +                       p_clk: p_clk {
> > +                               compatible = "fixed-factor-clock";
> > +                               clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
> > +                               #clock-cells = <0>;
> > +                               clock-div = <24>;
> > +                               clock-mult = <1>;
> > +                               clock-output-names = "p";
> > +                       };
> 
> I can't find a "p" clock. Shouldn't that be one of the "sXdY" clocks?

Good catch.
it seems "p" was changed to s3d4
will fix in v6


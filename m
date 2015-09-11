From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 07:58:13 +0000
Subject: Re: [PATCH/RFC v2 1/5] arm64: dts: r8a7795: add clock for EthernetAVB
Message-Id: <20150911075812.GA2835@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441936996-18437-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1441936996-18437-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2015 at 09:16:21AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Sep 11, 2015 at 4:03 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> > These clocks will be used by EthernetAVB
> >
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > [horms: use s3d2_clk; other minor updates]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> >
> > v0 [Kazuya Mizuguchi]
> >
> > v1 [Simon Horman]
> > * updated p_clk to s3d4_clk
> > * moved to clock node
> > * updated patch subject
> > * use R8A7795 as prefix for clock defines
> >
> > v2 [Simon Horman]
> > * As suggested by Geert Uytterhoeven
> >   - Use s2d4_clk use it instead: it is now already present in the base
> 
> s3d2?

There were several changes there. It looks like I failed to keep the
comment above in sync with the code.

> 
> >     of this series
> >   - Use R8A7795_CLK_ETHERAVB instead of R8A7795_CLK_AVB
> > * As suggested by Kuninori Morimoto and Sergei Shtylyov
> >   - Use "clock-indices" instead of "renesas,clock-indices"
> >
> > TODO:
> > * Drop clock-output-names from mstp8_clks ?
> > ---
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 12 ++++++++++++
> >  include/dt-bindings/clock/r8a7795-clock.h |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index d7e70f57d165..92c2b86a498f 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -274,6 +274,17 @@
> >                                         #clock-cells = <1>;
> >                                         clock-indices = <R8A7795_CLK_SCIF2>;
> >                                 };
> > +
> > +                               mstp8_clks: mstp8_clks@e6150990 {
> > +                                       compatible = "renesas,r8a7795-mstp-clocks",
> > +                                                    "renesas,cpg-mstp-clocks";
> > +                                       reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> > +                                       clocks =  <&s3d2_clk>;
> > +                                       #clock-cells = <1>;
> > +                                       clock-indices = <R8A7795_CLK_ETHERAVB>;
> > +                                       clock-output-names = "avb";
> 
> "etheravb", if you intend to keep it?

Sure. But should I keep it?

> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

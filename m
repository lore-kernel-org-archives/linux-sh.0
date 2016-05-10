From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 10 May 2016 08:31:09 +0000
Subject: Re: [PATCH RESEND 06/12] clk: sh: SH7750/51 PLL and divider clock driver
Message-Id: <877ff2pb5e.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
	<1462079316-27771-7-git-send-email-ysato@users.sourceforge.jp>
	<CAMuHMdXwC1CKmQ5X98-oGuZ1VAXYrR+vZsRa6qKPt6Cu9Q_-SA@mail.gmail.com>
In-Reply-To: <CAMuHMdXwC1CKmQ5X98-oGuZ1VAXYrR+vZsRa6qKPt6Cu9Q_-SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Sorry too late reply.

On Mon, 02 May 2016 05:48:28 +0900,
Geert Uytterhoeven wrote:
> 
> Hi Sato-san,
> 
> On Sun, May 1, 2016 at 7:08 AM, Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  .../bindings/clock/renesas,sh-div-clock.txt        |  24 ++
> >  .../bindings/clock/renesas,sh7750-div-clock.txt    |  27 ++
> >  .../bindings/clock/renesas,sh7750-pll-clock.txt    |  26 ++
> >  drivers/clk/Kconfig                                |   1 +
> >  drivers/clk/Makefile                               |   3 +-
> >  drivers/clk/sh/Kconfig                             |   5 +
> >  drivers/clk/sh/Makefile                            |   2 +
> >  drivers/clk/sh/clk-sh7750.c                        | 223 ++++++++++++++
> >  drivers/clk/sh/clk-shdiv.c                         | 338 +++++++++++++++++++++
> >  9 files changed, 648 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
> >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
> >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
> >  create mode 100644 drivers/clk/sh/Kconfig
> >  create mode 100644 drivers/clk/sh/Makefile
> >  create mode 100644 drivers/clk/sh/clk-sh7750.c
> >  create mode 100644 drivers/clk/sh/clk-shdiv.c
> >
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
> > new file mode 100644
> > index 0000000..399e0da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,sh-div-clock.txt
> > @@ -0,0 +1,24 @@
> > +* Renesas H8/300 divider clock
> 
> [...]
> 
> h8300?

Ouch. fixed.

> 
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
> > new file mode 100644
> > index 0000000..8c57ab5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
> > @@ -0,0 +1,27 @@
> > +* Renesas SH7750/51 divider clock
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must be "renesas,sh7750-div-clock"
> > +
> > +  - clocks: Reference to the parent clocks (mostly PLL)
> > +
> > +  - #clock-cells: Must be 0
> > +
> > +  - reg: Base address and length of the divide rate selector
> > +
> > +  - renesas,offset: bit offset of selector
> > +
> > +  - clock-output-names: The names of the clocks.
> > +
> > +Example
> > +-------
> > +
> > +        iclk: iclk {
> > +                compatible = "renesas,sh7750-div-clock";
> > +                clocks = <&pllclk>;
> > +                #clock-cells = <0>;
> > +                reg = <0xffc00000 2>;
> > +               renesas,offset = <6>;
> > +               clock-output-names = "ick";
> > +        };
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
> > new file mode 100644
> > index 0000000..06a3d31
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
> > @@ -0,0 +1,26 @@
> > +Renesas SH7750/51 PLL clock
> > +
> > +This device is Clock multiplyer
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must be "renesas,sh7750-pll-clock"
> > +
> > +  - clocks: Reference to the parent clocks
> > +
> > +  - #clock-cells: Must be 0
> > +
> > +  - renesas,mult: PLL1 multiply rate
> > +
> > +  - reg: Two rate selector (FRQCR / WDT) register address
> > +
> > +Example
> > +-------
> > +
> > +        pllclk: pllclk {
> > +                compatible = "renesas,sh7750-pll-clock";
> > +                clocks = <&oclk>;
> > +                #clock-cells = <0>;
> > +               renesas,mult = <12>;
> > +                reg = <0xffc00000 2>, <0xffc00008 4>;
> > +        };
> 
> As the registers of the PLL clock and the various div clocks are the
> same, I think it will be simpler to just write a single driver that provides
> all clocks, instead of describing all clocks in DT.
> 
> Cfr. drivers/clk/renesas/*-cpg-mssr.c vs. drivers/clk/renesas/clk-rcar-gen2.c
> + drivers/clk/renesas/clk-mstp.c + drivers/clk/renesas/clk-div6.c.

OK.
This part little complex.
I'll clean up this.

Thanks.

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

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>

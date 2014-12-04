From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 07:00:44 +0000
Subject: Re: [PATCH v2 0/6] ARM: shmobile: Change to using clock-indices
Message-Id: <20141204070043.GA25806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdX+EfnjZvnDyUprtuQ05Ekpnr7bxgTZA=2_CHMFTq1Y9A@mail.gmail.com>
 <20141204041144.GA9241@verge.net.au>
In-Reply-To: <20141204041144.GA9241@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mike Turquette <mturquette@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Thu, Dec 04, 2014 at 01:11:44PM +0900, Simon Horman wrote:
> On Wed, Dec 03, 2014 at 12:27:13PM +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Mon, Nov 10, 2014 at 7:49 PM, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > This patch series finalizes the conversion from the vendor-specific
> > > "renesas,clock-indices" to the generic "clock-indices", started by Ben Dooks.
> > >
> > > The patches for r8a7790 and r8a7791 were extracted from a patch that Ben sent
> > > before ("[PATCH 2/3] renesas: change to using clock-indices"), but it was never
> > > split/updated.
> > >
> > > Changes in v2:
> > >   - Drop the reference to "renesas,clock-indices" completely,
> > >   - Add Acked-by.
> > >
> > > Thanks for applying!
> > 
> > As Mike has accepted the bindings update in clk-next, can you please apply
> > the dtsi updates?
> 
> Sure, I will look into doing so; most likely tomorrow.

Thanks, I have now done so.

There was some fuzz when applying most of the patches,
I'd appreciate it if you could check that I got things right.

> > Thanks!
> > 
> > > Ben Dooks (2):
> > >   ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
> > >   ARM: shmobile: r8a7791 dtsi: Change to using clock-indices
> > >
> > > Geert Uytterhoeven (4):
> > >   clk: shmobile: Deprecate renesas,clock-indices
> > >   ARM: shmobile: r8a7740 dtsi: Change to using clock-indices
> > >   ARM: shmobile: r8a7779 dtsi: Change to using clock-indices
> > >   ARM: shmobile: r8a7794 dtsi: Change to using clock-indices
> > >
> > >  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  8 ++++----
> > >  arch/arm/boot/dts/r8a7740.dtsi                     | 10 +++++-----
> > >  arch/arm/boot/dts/r8a7779.dtsi                     |  6 +++---
> > >  arch/arm/boot/dts/r8a7790.dtsi                     | 20 +++++++++++---------
> > >  arch/arm/boot/dts/r8a7791.dtsi                     | 22 ++++++++++++----------
> > >  arch/arm/boot/dts/r8a7794.dtsi                     | 14 +++++++-------
> > >  6 files changed, 42 insertions(+), 38 deletions(-)
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

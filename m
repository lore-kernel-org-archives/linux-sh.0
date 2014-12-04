From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 07:15:42 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 CCF DTS update
Message-Id: <20141204071541.GC25806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203115145.5889.72521.sendpatchset@w520>
In-Reply-To: <20141203115145.5889.72521.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 04, 2014 at 01:37:10PM +0900, Magnus Damm wrote:
> Hi Geert,
> 
> On Wed, Dec 3, 2014 at 9:56 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Magnus,
> >
> > On Wed, Dec 3, 2014 at 1:52 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> On Wed, Dec 3, 2014 at 9:25 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>> On Wed, Dec 3, 2014 at 12:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >>>> Update the r8a7779 CCF DTS with the following fixes:
> >>>>  - Use MSTP0 for SCIF clock control
> >>>>  - Use R8A7779_CLK_P as parent clock for SCIF (same as legacy code)
> >>>>  - Use "clock-indicies" instead of "renesas,clock-indices"
> >>>
> >>> We already have
> >>> "[PATCH v2 3/6] ARM: shmobile: r8a7779 dtsi: Change to using clock-indices"
> >>> (http://www.spinics.net/lists/linux-sh/msg37285.html) for the latter.
> >>
> >> Yes, I noticed that too late I'm afraid. =)
> >>
> >> Are you aware of any outstanding issue for that series?
> >
> > Not that I'm aware of. As Mike merged the bindings update, I had pinged
> > Simon about the rest of the series, just before you sent your patch.
> 
> Thanks, sounds like I should make a V2 of this patch once Simon has
> merged patch 3/6 above.

In general I prefer one fix per patch.

So unless there is a dependency between the remaining two fixes
could you please make them separate patches when you drop the
clock-indicies changes?

> 
> >>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >>>> ---
> >>>>
> >>>>  Written on top of renesas-devel-20141202-v3.18-rc7
> >>>>
> >>>>  arch/arm/boot/dts/r8a7779.dtsi |   30 +++++++++++++++---------------
> >>>>  1 file changed, 15 insertions(+), 15 deletions(-)
> >>>>
> >>>> --- 0001/arch/arm/boot/dts/r8a7779.dtsi
> >>>> +++ work/arch/arm/boot/dts/r8a7779.dtsi 2014-12-03 20:22:26.000000000 +0900
> >>>> @@ -200,7 +200,7 @@
> >>>>                 compatible = "renesas,scif-r8a7779", "renesas,scif";
> >>>>                 reg = <0xffe40000 0x100>;
> >>>>                 interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> >>>> -               clocks = <&cpg_clocks R8A7779_CLK_P>;
> >>>> +               clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
> >>>>                 clock-names = "sci_ick";
> >>>>                 status = "disabled";
> >>>>         };
> >>>
> >>> According to the datasheet, the SCIF can use both S1 and "SCIF_CLK" (I assume
> >>> that's the MSTP clock output for SCIF?) as clock input, selectable using the
> >>> XIN bit of the Clock Select Register (CKS).
> >>> Do you have more information?
> >>
> >> I suspect that you may look at the left side of the r8a7779 SCIF
> >> overview page near the BRG where there is a "clks1" and the external
> >> SCIF_CLK. I'm looking at the right side and the "baud rate generator"
> >> where clkp is hooked up.
> >
> > Oh right, that "clkp" is really "clkp through MSTP bit X"?
> 
> Yes, this is how we historically have hooked up the SCIF clocks. It is
> however not entirely clear from the documentation how the MSTP bit is
> connected, so the assumption may be wrong. And the SCIF driver has
> support for interface clocks as well. The "clkp through MSTP bit X"
> implementation seems better than the current code at least.
> 
> >> The SCIF driver today has relatively limited support for the BRG
> >> (which confusingly enough is a second baud rate generator, how many do
> >> one need?). With the "regular" baud rate generator and the BRG unit
> >> some of the SCIF variants can be configured to use many different
> >> clocks.
> >>
> >> We currently lack code for the following:
> >> A) Describe all the clocks hooked up to the SCIF
> >> B) Select the best clock for any given baud rate
> >>
> >> So with this patch we simply ignore the BRG.
> >
> > OK. Fair enough.
> >
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks!
> 
> / magnus
> 

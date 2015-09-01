From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 01 Sep 2015 12:30:40 +0000
Subject: Re: [PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <1641516.pMxNnC39aM@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple> <1692617.kRMz5BT8ct@avalon> <CANqRtoSw92UoVBvTJfzGvxmYwefNndqqnj2_8iqi5O=FUeLMGA@mail.gmail.com>
In-Reply-To: <CANqRtoSw92UoVBvTJfzGvxmYwefNndqqnj2_8iqi5O=FUeLMGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Magnus,

On Tuesday 01 September 2015 19:59:01 Magnus Damm wrote:
> On Tue, Sep 1, 2015 at 3:00 PM, Laurent Pinchart wrote:
> > On Monday 31 August 2015 21:49:04 Magnus Damm wrote:
> >> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >> 
> >> This V5 patch adds initial CPG support for R-Car Generation 3 and in
> >> particular the R8A7795 SoC.
> >> 
> >> The R-Car Gen3 clock hardware has a register write protection feature
> >> that needs to be shared between the CPG function needs to be shared
> >> between the CPG and MSTP hardware somehow. So far this feature is simply
> >> ignored.
> >> 
> >> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >> ---
> >> 
> >>  Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
> >>  - Simplified clks array handling - thanks Geert!
> >>  - Updated th DT binding documentation to reflect latest state
> >>  - of_property_count_strings() -> of_property_count_u32_elems() fix
> >>  
> >>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
> >>  - Reworked driver to incorporate most feedback from Stephen Boyd -
> >>  thanks!!
> >>  - Major things like syscon and driver model require more discussion.
> >>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
> >>  
> >>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
> >>  - Reworked driver to rely on clock index instead of strings.
> >>  - Dropped use of "clock-output-names".
> >>  
> >>  Earlier versions: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>  Initial version: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >>  
> >>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
> >>  |   32 +
> >>  drivers/clk/Makefile                                |    1
> >>  drivers/clk/shmobile/Makefile                       |    1
> >>  drivers/clk/shmobile/clk-rcar-gen3.c                |  245 ++++++++++
> >>  4 files changed, 279 insertions(+)
> >> 
> >> --- /dev/null
> >> +++
> >> work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks
> >> .txt
> >> 2015-08-31 15:49:10.000000000 +0900 @@ -0,0 +1,32 @@
> >> +* Renesas R-Car Gen3 Clock Pulse Generator (CPG)
> >> +
> >> +The CPG generates core clocks for the R-Car Gen3 SoCs. It includes three
> >> PLLs
> >> +and several fixed ratio dividers.
> >> +
> >> +Required Properties:
> >> +
> >> +  - compatible: Must be one of
> >> +    - "renesas,r8a7795-cpg-clocks" for the r8a7795 CPG
> >> +    - "renesas,rcar-gen3-cpg-clocks" for the generic R-Car Gen3 CPG
> >> +
> >> +  - reg: Base address and length of the memory resource used by the CPG
> >> +
> >> +  - clocks: References to the parent clocks: first to the EXTAL clock
> >> +  - #clock-cells: Must be 1
> >> +  - clock-indices: Indices of the exported clocks
> > 
> > Do we actually need the clock-indices property, as CPG clocks are numbered
> > sequentially ? It seems to me like we could drop the property, especially
> > given that the number of clocks is hardcoded in the driver anyway.
> 
> There are two reasons why they are there:
> 1) I like to be able to search DT files to see which node that is
> providing what clock.

The clocks are listed in the CPG section of include/dt-bindings/clock/r8a7795-
clock.h so that should already give a hint. Additionally I don't think you'll 
search the CPG core clocks very often in the DT sources as they're usually not 
used directly by devices :-)

> 2) When adding support for additional SoCs we may add new index to the
> driver. New SoC may get sparsely populated index lists and old ones
> will omit the recently added index.

If the CPG core differs between SoCs shouldn't that be handled by the DT 
compatibility string ?

> >> +/*
> >> + *   MD              EXTAL           PLL0    PLL1    PLL2    PLL3   
> >> PLL4
> >> + * 14 13 19 17       (MHz)           *1      *1      *1
> >> + *-------------------------------------------------------------------
> >> + * 0  0  0  0        16.66 x 1       x180/2  x192/2  x144/2  x192   
> >> x144
> >> + * 0  0  0  1        16.66 x 1       x180/2  x192/2  x144/2  x128   
> >> x144
> >> + * 0  0  1  0        Prohibited setting
> >> + * 0  0  1  1        16.66 x 1       x180/2  x192/2  x144/2  x192   
> >> x144
> >> + * 0  1  0  0        20    x 1       x150/2  x156/2  x120/2  x156   
> >> x120
> >> + * 0  1  0  1        20    x 1       x150/2  x156/2  x120/2  x106   
> >> x120
> >> + * 0  1  1  0        Prohibited setting
> >> + * 0  1  1  1        20    x 1       x150/2  x156/2  x120/2  x156   
> >> x120
> >> + * 1  0  0  0        25    x 1       x120/2  x128/2  x96/2   x128    x96
> >> + * 1  0  0  1        25    x 1       x120/2  x128/2  x96/2   x84     x96
> >> + * 1  0  1  0        Prohibited setting
> >> + * 1  0  1  1        25    x 1       x120/2  x128/2  x96/2   x128    x96
> >> + * 1  1  0  0        33.33 / 2       x180/2  x192/2  x144/2  x192   
> >> x144
> >> + * 1  1  0  1        33.33 / 2       x180/2  x192/2  x144/2  x128   
> >> x144
> >> + * 1  1  1  0        Prohibited setting
> >> + * 1  1  1  1        33.33 / 2       x180/2  x192/2  x144/2  x192   
> >> x144
> >> + *
> >> + * *1 : datasheet indicates VCO output (PLLx = VCO/2)
> > 
> > As explained in a separate e-mail there's a few clocks on R8A7795 that
> > derive directly from PLL1 VCO. I thus wonder whether we shouldn't expose
> > the PLL1 clock as the VCO output and create VCO/2 using a fixed factor
> > clock in DT.
>
> Do you think that would reduce complexity or simplify the code? If so
> I think we should do it. Otherwise I think it makes sense to simply
> follow the data sheet.

I've commented on this in a reply to Geert's e-mail.

-- 
Regards,

Laurent Pinchart


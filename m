From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 02 Sep 2015 05:21:14 +0000
Subject: Re: [PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <2372675.RSIvUA3Urg@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple> <1641516.pMxNnC39aM@avalon> <CANqRtoQ_21KjoT2CUzx=oReO-JSLWr3jBv7RcJWoFH+M_ZVuhw@mail.gmail.com>
In-Reply-To: <CANqRtoQ_21KjoT2CUzx=oReO-JSLWr3jBv7RcJWoFH+M_ZVuhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Magnus,

On Wednesday 02 September 2015 11:27:27 Magnus Damm wrote:
> On Tue, Sep 1, 2015 at 9:30 PM, Laurent Pinchart wrote:
> > On Tuesday 01 September 2015 19:59:01 Magnus Damm wrote:
> >> On Tue, Sep 1, 2015 at 3:00 PM, Laurent Pinchart wrote:
> >>> On Monday 31 August 2015 21:49:04 Magnus Damm wrote:
> >>>> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >>>> 
> >>>> This V5 patch adds initial CPG support for R-Car Generation 3 and in
> >>>> particular the R8A7795 SoC.
> >>>> 
> >>>> The R-Car Gen3 clock hardware has a register write protection feature
> >>>> that needs to be shared between the CPG function needs to be shared
> >>>> between the CPG and MSTP hardware somehow. So far this feature is
> >>>> simply ignored.
> >>>> 
> >>>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >>>> ---
> >>>> 
> >>>>  Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
> >>>>  - Simplified clks array handling - thanks Geert!
> >>>>  - Updated th DT binding documentation to reflect latest state
> >>>>  - of_property_count_strings() -> of_property_count_u32_elems() fix
> >>>>  
> >>>>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
> >>>>  - Reworked driver to incorporate most feedback from Stephen Boyd -
> >>>>  thanks!!
> >>>>  - Major things like syscon and driver model require more discussion.
> >>>>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
> >>>>  
> >>>>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
> >>>>  - Reworked driver to rely on clock index instead of strings.
> >>>>  - Dropped use of "clock-output-names".
> >>>>  
> >>>>  Earlier versions: Kuninori Morimoto
> >>>>  <kuninori.morimoto.gx@renesas.com>
> >>>>  Initial version: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> >>>>  
> >>>>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.
> >>>>  txt  |   32 +
> >>>>  drivers/clk/Makefile                                |    1
> >>>>  drivers/clk/shmobile/Makefile                       |    1
> >>>>  drivers/clk/shmobile/clk-rcar-gen3.c                |  245 ++++++++++
> >>>>  4 files changed, 279 insertions(+)
> >>>> 
> >>>> --- /dev/null
> >>>> +++
> >>>> work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clo
> >>>> cks.txt
> >>>> 2015-08-31 15:49:10.000000000 +0900 @@ -0,0 +1,32 @@
> >>>> +* Renesas R-Car Gen3 Clock Pulse Generator (CPG)
> >>>> +
> >>>> +The CPG generates core clocks for the R-Car Gen3 SoCs. It includes
> >>>> three PLLs
> >>>> +and several fixed ratio dividers.
> >>>> +
> >>>> +Required Properties:
> >>>> +
> >>>> +  - compatible: Must be one of
> >>>> +    - "renesas,r8a7795-cpg-clocks" for the r8a7795 CPG
> >>>> +    - "renesas,rcar-gen3-cpg-clocks" for the generic R-Car Gen3 CPG
> >>>> +
> >>>> +  - reg: Base address and length of the memory resource used by the
> >>>> CPG
> >>>> +
> >>>> +  - clocks: References to the parent clocks: first to the EXTAL clock
> >>>> +  - #clock-cells: Must be 1
> >>>> +  - clock-indices: Indices of the exported clocks
> >>> 
> >>> Do we actually need the clock-indices property, as CPG clocks are
> >>> numbered sequentially ? It seems to me like we could drop the property,
> >>> especially given that the number of clocks is hardcoded in the driver
> >>> anyway.
> >> 
> >> There are two reasons why they are there:
> >> 1) I like to be able to search DT files to see which node that is
> >> providing what clock.
> > 
> > The clocks are listed in the CPG section of
> > include/dt-bindings/clock/r8a7795- clock.h so that should already give a
> > hint. Additionally I don't think you'll search the CPG core clocks very
> > often in the DT sources as they're usually not used directly by devices
> > :-)
> 
> You are right that they may not be searched very frequently. But at
> least the CPG is consistent with MSTP with this implementation. =)
> 
> >> 2) When adding support for additional SoCs we may add new index to the
> >> driver. New SoC may get sparsely populated index lists and old ones
> >> will omit the recently added index.
> > 
> > If the CPG core differs between SoCs shouldn't that be handled by the DT
> > compatibility string ?
> 
> You know that I personally always prefered an incremental approach
> with little speculation in DT. =)
> 
> So using SoC specific compat strings over generic ones would in
> general be my preferred choice. I suspect the initial developer of
> this patch simply followed the same style as Gen2 with a generic
> compat string.
> 
> Does this mean that you for the r8a7795 CPG prefer SoC specific compat
> string to begin with over a more generic one? If we go for SoC
> specific compat string then perhaps we also should change file names?

We use an SoC-specific compat string already so we won't be stuck in the 
future. I would keep matching on the generic compatible string for now until 
the unlikely future event that a Gen3 SoC would have a different CPG. I don't 
think there's too much point in making DT bindings (and the corresponding 
code) more complex than necessary to plan for an unlikely future hardware 
change that we know nothing about at this point anyway.

-- 
Regards,

Laurent Pinchart


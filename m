From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 28 Aug 2014 23:58:55 +0000
Subject: Re: [PATCH v4] clk: shmobile: div6: support selectable-input clocks
Message-Id: <1780299.8YZEnbE9lj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1409238671-30452-1-git-send-email-ulrich.hecht+renesas@gmail.com> <20140828160528.GN14650@leverpostej>
In-Reply-To: <20140828160528.GN14650@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, "horms@verge.net.au" <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ulrich Hecht <ulrich.hecht@gmail.com>

Hi Mark and Ulrich,

On Thursday 28 August 2014 17:05:28 Mark Rutland wrote:
> On Thu, Aug 28, 2014 at 04:11:11PM +0100, Ulrich Hecht wrote:
> > From: Ulrich Hecht <ulrich.hecht@gmail.com>
> > 
> > Support for setting the parent at initialization time based on the current
> > hardware configuration in DIV6 clocks with selectable parents as found in
> > the r8a73a4, r8a7740, sh73a0, and other SoCs.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > 
> > This is v3 plus some style adjustments suggested by Laurent.
> > 
> > CU
> > Uli
> > 
> > Changes since v3:
> > - note that renesas,src-shift and renesas,src-width depend on each other
> > - clarified description
> > - minor coding style fixes
> > 
> > Changes since v2:
> > - add r8a73a4 to bindings
> > - use u32 where appropriate
> > - don't split error message
> > 
> > Changes since v1:
> > - make sure unrelated register bits are preserved
> > - use the plural for the clocks property in bindings
> > 
> >  .../bindings/clock/renesas,cpg-div6-clocks.txt     | 12 +++++++-
> >  drivers/clk/shmobile/clk-div6.c                    | 32 +++++++++++++----
> >  2 files changed, 38 insertions(+), 6 deletions(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> > b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> > index 952e373..2633ea1 100644
> > --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> > +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> > @@ -7,14 +7,24 @@ to 64.
> > 
> >  Required Properties:
> >    - compatible: Must be one of the following
> > +    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6
> > clocks
> > +    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
> >      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
> >      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
> > +    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-MobileAG5) DIV6 clocks
> >      - "renesas,cpg-div6-clock" for generic DIV6 clocks
> >    
> >    - reg: Base address and length of the memory resource used by the DIV6
> >    clock
> >
> > -  - clocks: Reference to the parent clock
> > +  - clocks: Reference to the parent clock(s)
> >    - #clock-cells: Must be 0
> >    - clock-output-names: The name of the clock as a free-form string
> > 
> > +Optional Properties:
> > +
> > +  - renesas,src-shift: Bit position of the input clock selector (default:
> > +    fixed input clock; requires renesas,src-width)
> > +  - renesas,src-width: Bit width of the input clock selector (default:
> > fixed
> > +    input clock; requires renesas,src-shift)
> 
> I'm slightly confused by these properties, but I'm not at all familiar
> with the HW.
> 
> How variable is the format of the configuration register?
> 
> Is it fixed for a given compatible string?
> 
> Are there other fields we care about?

On SH73A0 the DIV6-compatible clocks have different register layouts.

Bits     Name     	Function
-----------------------------------------------------------------------------
14-12    EXSRC    Source Selection (VCLK[123] clocks)
8        CKSTP    Clock Stop
7        	EXSRC    Source Selection (BSC, FL, MSU, MFG[12], DSITX clocks)
7-6      EXSRC    Source Selection (SD[012], FSI[AB], SPUA, SUPV, HSI clocks)
7-6      PDIV     PLL Division Ratio (VCLK3 clock)
5-0      DIV      Division Ratio

If we consider the EXSRC on bit 7 as a special case of EXSRC on bits 7-6, and 
the PDIV field as being present for all VCLK clocks with the only valid value 
being 0 for VCLK1 and VCLK2, this splits the DIV6 clocks in two categories, 
the VCLK clocks and the other clocks.

On R8A73A4 the situation is similar, with three categories:

- EXSRC on bits 7-6 (BSC, DSI[01]TX, SD[012], MMC[01], FSI[AB], SPUV, SLIMB, 
HSI, SSP, SSPRS, MPHY, C2C)
- EXSRC on bits 14-12 and PDIV on bits 7-6 (VCLK[12345])
- no EXSRC (HSIC)

Similarly R8A7740 has the following categories:

- EXSRC on bits 7-6 (FMSI, FMSO, FSI[AB], SPU, VOU)
- EXSRC on bits 14-12 and no PDIV bits (VCLK[12])
- no EXSRC (STPR)

On R8A7790 and R8A7791 all the DIV6-compatible clocks (SD[123], MMC[01], SSP, 
SSPRS) share the same register layout with just the CKSTP and DIV bits.

We could thus extend the DIV6 clocks with clock source selection using the 
following layout

Bits     Name     	Function
-----------------------------------------------------------------------------
8        CKSTP    Clock Stop
7-6      EXSRC    Source Selection
5-0      DIV      Division Ratio

The clocks property would be a list of one, two, three or four clock 
references, mapping to the 00, 01, 10 and 11 values of the EXSRC field. Empty 
references (just a 0 value) would be used to denote invalid values of the 
EXSRC field.

A new compatible string would then be added for the VCLK clocks with the 
following layout

Bits     Name     	Function
-----------------------------------------------------------------------------
14-12    EXSRC    Source Selection (VCLK[123] clocks)
8        CKSTP    Clock Stop
7-6      PDIV     PLL Division Ratio (VCLK3 clock)
5-0      DIV      Division Ratio

The clocks property would be handled as for the common DIV6 clocks, and we 
would need to define a way to describe the valid values of the PDIV field. As 
far as I can see, the PDIV values are identical for all VCLK clocks when 
implemented (00 -> 1/1, 01 -> 1/2, 10 -> Reserved, 11 -> 1/4), so a single 
renesas,has-pdiv property should be enough.

-- 
Regards,

Laurent Pinchart


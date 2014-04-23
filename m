From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 23 Apr 2014 13:50:29 +0000
Subject: Re: [RFC] ARM: shmobile: minimal r8a7740 common clock framework implementation
Message-Id: <2530393.CCOP17CNyz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1397041484-12552-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1397041484-12552-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tuesday 22 April 2014 15:19:15 Ulrich Hecht wrote:
> Hi!
> 
> On Wed, Apr 9, 2014 at 3:30 PM, Laurent Pinchart wrote:
> > Thank you for the patch.
> 
> And thank you for your insights.
> 
> > Given that the goal is to get rid of arch/arm/mach-* at some point, I
> > believe it would make sense to drop r8a7740_clocks_init()
> 
> Further research has revealed that the mode bits of the r8a7740 cannot
> be read from the inside at all,

Ouch. 

> so we have to hardcode it in the board file anyway, making
> r8a7740_clocks_init() unnecessary.

I've been wondering whether the driver couldn't be doing without knowledge of 
the mode pins at all. MD_CK1 seems to be needed, but let me share my reasoning 
in case I've missed something that would allow the driver to operate without 
knowing the MD_CK1 value.

MD_CK0 selects whether the board uses a direct clock input or a crystal 
oscillator. It only controls a multiplexer that routes the XTAL1 pin or the 
crystal oscillation circuit output (connected to the XTAL1 and EXTAL1 pins) to 
the system clock. It thus has no influence on the system clock frequency or 
parent, and isn't needed by the CPG driver (your patch set doesn't use the 
bit).

MD_CK2 selects whether the R clock is derived from the system clock or from 
the optional clock source connected to the EXTALR input. We could control the 
R clock parent based on the fact that the CPG DT node has or has no EXTALR 
clock parent specified.

MD_CK1 controls the XTAL1 /2 divisor. When using the restricted external clock 
frequency range, the XTAL1 frequency must be between 24MHz and 26.67MHz for 
MD_CK1 = 0 (no division), and between 48 MHz and 50 MHz for MD_CK1 = 1 (divide 
by 2). We could thus infer the MD_CK1 settings based on the external clock 
frequency. However, when using the full external clock frequency ranges, 
that's not possible anymore as the ranges overlap. I thus don't see a good way 
to avoid explicit knowledge of MD_CK1, but I might have overlooked something.

> > The extal1_clk frequency is board-dependent, I would specify it in DT
> > board files instead. I think (but might be wrong) that extal2 is optional.
> > In that case maybe we should set the frequency to 0 here and overwrite it
> > in DT board files for boards that supply the clock.
> 
> OK.
> 
> > The SUB divider actually supplies two clocks, sub1 and sub2, that have the
> > same frequency but can be individually enabled/disabled.
> 
> I guess those can be treated like MSTP clocks, with sub as the parent.
> I suppose there should be a generic "gated clock"...

There's a clk-gate driver that exports a clk_register_gate() function, you can 
use it in the SUB clock driver.

> > Other clocks that you don't support yet share that characteristic, and
> > even have sub-dividers (for the HDMI clocks instead).
> 
> The HDMI clocks actually seem to be the only ones with that feature,
> so I'd hide them in cpg_clocks together with the other weirdo stuff.
> (There seem to be a lot of clocks on other SoCs as well that vaguely
> resemble DIV6 clocks, but are not really compatible in a manner useful
> for abstraction.)

Yes, there's lot of small differences that make implementations more painful 
than they should be :-/ It's not a huge issue though, just a shame that we 
can't share more code.

> > The sub clocks also have a selectable parent. Have you thought about how
> > you would like to implement that ?
> 
> That'll be dealt with by the "renesas,src-shift" and
> "renesas,src-width" properties.
> 
> > This should be R8A7740_CLK_CMT1.
> 
> OK.
> 
> >> +#include <linux/math64.h>
> > 
> > I don't think this header is needed.
> 
> No, it isn't.
> 
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/spinlock.h>
> >> +#include <mach/r8a7740.h>
> > 
> > If I'm not mistaken you're including mach/r8a7740.h for the MD_CK*
> > definitions only. As we're trying to get rid of the mach/ headers, what
> > about using BIT() directly instead ?
> 
> OK.
> 
> >> +             u32 value = clk_readl(cpg->reg + CPG_FRQCRC);
> >> +             parent_name = "system";
> >> +             mult = ((value >> 24) & 0x7f) + 1;
> > 
> > STC is a 6-bits field if I'm not mistaken, the mask should thus be 0x3f.
> 
> My docs say that as well, but the legacy clock code doesn't agree, and
> neither does reality: When I set the mask to 0x3f, the clocks are
> wrong and the serial console prints a lot of garbage, so I'll leave it
> as is.

Is bit 30 set then ? What about bit 31 ?

> >> +     cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> >> +     clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
> >> +     if (cpg = NULL || clks = NULL) {
> >> +             /* We're leaking memory on purpose, there's no point in
> >> cleaning
> >> +              * up as the system won't boot anyway.
> >> +              */
> >> +             pr_err("%s: failed to allocate cpg\n", __func__);
> > 
> > kzalloc() prints an OOM message on error, there's no need to duplicate it
> > here.
> 
> OK.
> 
> >> +/* MSTP4 */
> >> +#define R8A7740_CLK_USBHOST  16
> > 
> > Should we call this USBH to match the datasheet ?
> 
> I'm not particular. :)
> 
> I'll post an updated patch next.

-- 
Regards,

Laurent Pinchart

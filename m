From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 22 Apr 2014 13:19:15 +0000
Subject: Re: [RFC] ARM: shmobile: minimal r8a7740 common clock framework implementation
Message-Id: <CAO3366xH-v=XiLXEUsR_YKS97XnM=RJb98gyaMbK3+TieuR-3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397041484-12552-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1397041484-12552-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

On Wed, Apr 9, 2014 at 3:30 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Thank you for the patch.

And thank you for your insights.

> Given that the goal is to get rid of arch/arm/mach-* at some point, I believe
> it would make sense to drop r8a7740_clocks_init()

Further research has revealed that the mode bits of the r8a7740 cannot
be read from the inside at all, so we have to hardcode it in the board
file anyway, making r8a7740_clocks_init() unnecessary.

> The extal1_clk frequency is board-dependent, I would specify it in DT board
> files instead.
> I think (but might be wrong) that extal2 is optional. In that case maybe we
> should set the frequency to 0 here and overwrite it in DT board files for
> boards that supply the clock.

OK.

> The SUB divider actually supplies two clocks, sub1 and sub2, that have the
> same frequency but can be individually enabled/disabled.

I guess those can be treated like MSTP clocks, with sub as the parent.
I suppose there should be a generic "gated clock"...

> Other clocks that you
> don't support yet share that characteristic, and even have sub-dividers (for
> the HDMI clocks instead).

The HDMI clocks actually seem to be the only ones with that feature,
so I'd hide them in cpg_clocks together with the other weirdo stuff.
(There seem to be a lot of clocks on other SoCs as well that vaguely
resemble DIV6 clocks, but are not really compatible in a manner useful
for abstraction.)

> The sub clocks also have a selectable parent. Have
> you thought about how you would like to implement that ?

That'll be dealt with by the "renesas,src-shift" and
"renesas,src-width" properties.

> This should be R8A7740_CLK_CMT1.

OK.

>> +#include <linux/math64.h>
>
> I don't think this header is needed.

No, it isn't.

>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/spinlock.h>
>> +#include <mach/r8a7740.h>
>
> If I'm not mistaken you're including mach/r8a7740.h for the MD_CK* definitions
> only. As we're trying to get rid of the mach/ headers, what about using BIT()
> directly instead ?

OK.

>> +             u32 value = clk_readl(cpg->reg + CPG_FRQCRC);
>> +             parent_name = "system";
>> +             mult = ((value >> 24) & 0x7f) + 1;
>
> STC is a 6-bits field if I'm not mistaken, the mask should thus be 0x3f.

My docs say that as well, but the legacy clock code doesn't agree, and
neither does reality: When I set the mask to 0x3f, the clocks are
wrong and the serial console prints a lot of garbage, so I'll leave it
as is.

>> +     cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
>> +     clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
>> +     if (cpg = NULL || clks = NULL) {
>> +             /* We're leaking memory on purpose, there's no point in cleaning
>> +              * up as the system won't boot anyway.
>> +              */
>> +             pr_err("%s: failed to allocate cpg\n", __func__);
>
> kzalloc() prints an OOM message on error, there's no need to duplicate it
> here.

OK.

>> +/* MSTP4 */
>> +#define R8A7740_CLK_USBHOST  16
>
> Should we call this USBH to match the datasheet ?

I'm not particular. :)

I'll post an updated patch next.

CU
Uli

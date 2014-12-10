From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 10 Dec 2014 16:53:22 +0000
Subject: Re: [PATCH v7 1/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <CAO3366zNEUhMM3MkDb-=j6S7+oh+uU_iiAp5DM_HB1QchBEArA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 10, 2014 at 4:38 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 10 December 2014 15:45:22 Ulrich Hecht wrote:
>> Driver for the SH73A0's clocks that are too specific to be supported by a
>> generic driver.
[...]
>> +static struct div4_clk div4_clks[] = {
>> +     { "zg", "pll0", CPG_FRQCRA, 16 },
>
> I've already commented on this in v6, the comment has probably been
> overlooked. According to the datasheet the ZGFC value 1010 results in a x1/5
> factor, which  doesn't match the value in the div4_div_table below. I wonder
> if it could be an error in the datasheet though.

The legacy driver doesn't make an exception for zg.  Looks like an
error in the datasheet to me.

> It's nice to see the unused mask and flags gone, but how to you plan to
> implement the fact that different div4 clocks have different allowed divider
> values ? :-)

Well, not now, at any rate...

>> +static const struct clk_div_table z_div_table[] = {
>> +     /* ZSEL = 0 */
>> +     { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 },
>> +     { 6, 1 }, { 7, 1 }, { 8, 1 }, { 9, 1 }, { 10, 1 }, { 11, 1 },
>> +     { 12, 1 }, { 13, 1 }, { 14, 1 }, { 15, 1 },
>
> Do we have to list all entries, or could a single one be enough ?

Hmm... u-boot initializes to all zeros, so just the first one might do.

>> +             if (!(mult & 0x8000))
>> +                     mult = 1;
>> +             else
>> +                     mult = (mult & 0x3f) + 1;
>
> It took me a bit of time to figure out that the PLLE bit always reflects the
> PLL state, regardless of whether it's in manual or automatic mode. Could you
> please add a comment to capture that ? Something like
>
> "The PLLE bit controls the PLL in automatic mode only, but always reflects the
> PLL state even in manual mode."

Yes, that is probably a good idea.

>> +     /* Set SDHI clocks to a known state */
>> +     clk_writel(0x108, cpg->reg + CPG_SD0CKCR);
>> +     clk_writel(0x108, cpg->reg + CPG_SD1CKCR);
>> +     clk_writel(0x108, cpg->reg + CPG_SD2CKCR);
>
> Why is this needed ?

Cargo cult programming, it's what the legacy driver does.  It
essentially just stops the clock (which u-boot leaves on), so it's
possible that it is not really necessary.

Geert, could I ask you to to occasionally check if this works without
the three SD clock initialization lines and without the "{ 1, 1 }" to
"{ 15, 1 }" entries in z_div_table?

CU
Uli

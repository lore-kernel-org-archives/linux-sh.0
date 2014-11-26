From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Nov 2014 22:32:19 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid changing divisor in .disable()
Message-Id: <1467380.GE8It95ssd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1416846048-3821-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416846048-3821-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wednesday 26 November 2014 10:39:38 Geert Uytterhoeven wrote:
> On Wed, Nov 26, 2014 at 1:10 AM, Laurent Pinchart wrote:
> > On Monday 24 November 2014 17:20:48 Geert Uytterhoeven wrote:
> >> While DIV6 clocks require the divisor field to be non-zero when stopping
> >> the clock, some clocks (e.g. ZB on sh73a0) fail to be re-enabled later
> >> if the divisor field is changed when stopping the clock.
> >> 
> >> To fix this, do not touch the divisor field if it's already non-zero.
> >> 
> >> On kzm9g, the smsc911x Ethernet controller is connected to the sh73a0
> >> Bus State Controller, which is clocked by the ZB clock. Without this
> >> fix, if the ZB clock is disabled during system suspend, and re-enabled
> >> during resume, the kernel locks up when the smsc911x driver tries to
> >> access the Ethernet registers.
> > 
> > Do we have any idea what happens at the hardware level ? Could it be that
> > the divider set when stopping the clock has an invalid value ? Does the
> > problem occur if you set the divider to a valid value instead of
> > CPG_DIV6_DIV_MASK when stopping the clock ?
> 
> Yes, the problem also happened when using another value (I think I used 3 or
> 4, while the default value is 2)  when stopping the clock, while it ran
> fine when using the other divider value all the time (so the divider value
> was valid).

OK.

> > The problem could also be caused by the new divider not being taken into
> > account fast enough if modified during the same write cycle as the CKSTP
> > bit when restarting the clock. Does the system still lock if you set the
> > divider and clear the CKSTP bit in two seperate write operations when
> > restarting the clock ?
> 
> I hadn't tried that. Let's see...
> 
> As "the divider must be non-zero when stopping the clock", I have to clear
> the CKSTP bit first, and restore the divider in the second step, i.e.
> 
> #include <linux/clk-private.h>
> 
>         val = clk_readl(clock->reg);
>         val &= ~CPG_DIV6_CKSTP;
>         val2 = (val & ~CPG_DIV6_DIV_MASK) | CPG_DIV6_DIV(clock->div - 1);
>         pr_info("DIV6 %s on: 0x%08x, 0x%08x", hw->clk->name, val, val2);
>         clk_writel(val, clock->reg);
>         pr_info("[delay]\n");
>         clk_writel(val2, clock->reg);
> 
> This also works, but there must be a small delay in between the two writes.
> If I remove the pr_info("[delay]\n"), it still fails about half of the time.
> Sometimes even during bootup, when it enables the zb clock while it's
> already running, and thus when writing the existing value (0x2) twice in a
> row.
> 
> Given we don't know the minimal required delay, I still prefer my solution
> (until we find a DIV6 clock where the default divisor is zero, and it
> fails again?).
> 
> What do you think?

I'm fine with your fix as a (long-term) temporary solution. Could you please 
clearly state in the commit message (and possibly in a small comment in the 
code) that we don't know why the hardware fails without the patch ?

I think we should also try to understand the root cause, as I have an 
unpleasant feeling the problem will come back to bite us later. Time to light 
candles and invoke the Renesas hardware designer demon ? :-)

-- 
Regards,

Laurent Pinchart


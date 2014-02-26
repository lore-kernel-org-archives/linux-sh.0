From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Feb 2014 21:53:03 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <2510385.4lBXQqHTss@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <530C9D2A.8030409@baylibre.com>
In-Reply-To: <530C9D2A.8030409@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Mike,

On Wednesday 26 February 2014 12:54:55 Mike Turquette wrote:
> Quoting Laurent Pinchart (2014-02-25 09:48:38)
> > On Tuesday 25 February 2014 18:07:54 Benoit Cousson wrote:
> > > On 25/02/2014 17:01, Laurent Pinchart wrote:
> > > > On Tuesday 25 February 2014 14:39:54 Benoit Cousson wrote:
> > > >> +  /*
> > > >> +   * Set KICK bit in FRQCRB to update hardware setting and
> > > >> +   * wait for completion.
> > > >> +   */
> > > >> +  kick = clk_readl(zclk->kick_reg);
> > > >> +  kick |= CPG_FRQCRB_KICK;
> > > >> +  clk_writel(kick, zclk->kick_reg);
> > > > 
> > > > Does CCF guarantee that two set_rate calls for different clocks will
> > > > not occur concurrently ? If so a brief comment would be nice.
> > > > Otherwise we need a lock around this.
> > > 
> > > So far, this is the only user of the register. That's why there is no
> > > lock. It is explained in the changelog. But if you want I can re-use the
> > > same comment here.
> > 
> > A comment would be nice, yes. You can make it shorter than the commit
> > message.
>
> CCF holds a global mutex during a call to clk_set_rate. So clk_prepare,
> clk_unprepare, clk_set_parent or a competing clk_set_rate will not touch
> this register during the critical section.
> 
> However it is possible to reenter the framework, but usually you control
> that code flow.
> 
> The main two reasons to introduce your own more granular register-level
> locking are:
> 
> 1) clk_enable & clk_disable hold a separate global spinlock (not the
> global mutex), so if this register is used for set_rate operations AND
> enable/disable operations then you'll need a spinlock.
> 
> 2) Other stuff outside of the clk framework touches this register
> (sounds like it is not the case here).

Thanks a lot for the explanation. I've cooked up a small documentation patch 
to avoid the need to repeat this over and over, I'll send it separately.

Looking at the implementation I found something that looked like a locking bug 
in the Qualcomm clock drivers at first sight.

clk-rpg.c calls __clk_is_enabled() from within its configure_bank() function. 
That function ends up being called from within the .set_rate, .set_parent and 
.set_rate_and_parent operations. This leads to __clk_is_enabled() being called 
without the enable spinlock held.

Now, clk-rpg.c provides an .is_enabled handler (clk_is_enabled_regmap) so 
we're at least not accessing the clock enable_count counter without the proper 
lock being held. I don't know whether clk_is_enabled_regmap() will handle 
locking properly though.

Exporting __clk_is_enabled() looks a bit dangerous to me. It might make sense 
to replace the __clk_is_enabled() call in clk-rpg.c with a direct call to 
clk_is_enabled_regmap(), but we still have two other users (namely 
drivers/cpufreq/kirkwood-cpufreq.c and arch/arm/mach-omap2/pm24xx.c) in the 
mainline kernel.

-- 
Regards,

Laurent Pinchart


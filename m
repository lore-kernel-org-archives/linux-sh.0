From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Feb 2014 17:48:38 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <2596385.IziaUX178P@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <530C9D2A.8030409@baylibre.com>
In-Reply-To: <530C9D2A.8030409@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Benoit,

On Tuesday 25 February 2014 18:07:54 Benoit Cousson wrote:
> On 25/02/2014 17:01, Laurent Pinchart wrote:
> > Hi Benoit,
> > 
> > Thank you for the patch.
> 
> You're welcome. Thanks for your comments.
> 
> > On Tuesday 25 February 2014 14:39:54 Benoit Cousson wrote:
> >> The Z clock frequency change is effective only after setting the kick
> >> bit located in the FRQCRB register.
> >> Without that, the CA15 CPUs clock rate will never change.
> >> 
> >> Fix that by checking if the kick bit is cleared and enable it to make
> >> the clock rate change effective. The bit is cleared automatically upon
> >> completion.
> >> 
> >> Note: The kick bit is used as well to change 3 other emulation clocks:
> >> Debug Trace port clock (ZTR), Debug Trace bus clock (ZT), and Debug
> >> clock (ZTRD2). It is not clear from the spec [1] if there
> >> is any relation between the CPU clock rate and these emulation clocks.
> >> Moreover, these clocks are probably supposed to be controled by an
> >> external debugger / tracer like Lauterbach PowerTrace.
> >> For all these reasons, the current implementation does not expose these
> >> clock nodes and thus does not have to consider the multiple accesses
> >> to the kick bit.
> >> 
> >> Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
> >> Cc: Mike Turquette <mturquette@linaro.org>
> >> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >> 
> >> [1] R-Car-H2-v0.6-en.pdf - page 186
> >> ---
> >> 
> >> Salut Laurent,
> >> 
> >> If you have any information about these emulation clocks, please let me
> >> know.
> > 
> > I don't I'm afraid. All I know is that we don't use them for now, so I
> > wouldn't care :-)
> > 
> >> Moreover, the CCF clock driver is shared with the r8a7791, so a test on
> >> that platform will be good.
> > 
> > I can do that. I assume you're working on Lager then ?
> 
> Yes I am. I don't have any Koelsch board.
> 
> > How can I exercise the code ? Using cpufreq to change the CA15 clock
> > frequency ? A brief test procedure would be appreciated.
> 
> Sure. First you can use dhrystone to check that the CPU frequency is
> changing or not.

OK.

> So far, changing the clock rate will not affect the dhrystone value at
> all becasue the magic kick bit is not set.
> 
> debugfs does not seems to allow write access to the clk_rate, so using
> cpufreq is propably the best way to test it.
> 
> I have a small series to add DVFS for Lager (Multiplatform boot only), I
> can share you that code if you want.

That would be nice, thanks.

> Naive question: How did you test that z-clock code originally ?

Simple answer: I haven't :-)

> >>    drivers/clk/shmobile/clk-rcar-gen2.c | 26 ++++++++++++++++++++++++--
> >>    1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > By the way the patch was corrupted with line wraps and additional spaces.
> 
> Gosh! I edited it slightly by hand with thunderbird before submitting...
> I probably messed it up. Sorry :-(
> 
> >> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c
> >> b/drivers/clk/shmobile/clk-rcar-gen2.c
> >> index a59ec21..9f12746 100644
> >> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> >> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c

[snip]

> >> @@ -83,17 +86,35 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw,
> >> unsigned long rate,
> >>    {
> >>    	struct cpg_z_clk *zclk = to_z_clk(hw);
> >>    	unsigned int mult;
> >> -	u32 val;
> >> +	u32 val, kick;
> >> +	int i;
> > 
> > The loop counter will always be positive, please use an unsigned int.
> 
> OK.
> 
> >>    	mult = div_u64((u64)rate * 32, parent_rate);
> >>    	mult = clamp(mult, 1U, 32U);
> >> 
> >> +	if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
> >> +		return -EBUSY;
> >> +
> >>    	val = clk_readl(zclk->reg);
> >>    	val &= ~CPG_FRQCRC_ZFC_MASK;
> >>    	val |= (32 - mult) << CPG_FRQCRC_ZFC_SHIFT;
> >>    	clk_writel(val, zclk->reg);
> >> 
> >> -	return 0;ir: cannot create directory
> >> `/home/ubuntu/projects/ti-glsdk_omap5-uevm_6_03_00_01/targetfs':
> >> Permission denied
> >> +	/*
> >> +	 * Set KICK bit in FRQCRB to update hardware setting and
> >> +	 * wait for completion.
> >> +	 */
> >> +	kick = clk_readl(zclk->kick_reg);
> >> +	kick |= CPG_FRQCRB_KICK;
> >> +	clk_writel(kick, zclk->kick_reg);
> > 
> > Does CCF guarantee that two set_rate calls for different clocks will not
> > occur concurrently ? If so a brief comment would be nice. Otherwise we
> > need a lock around this.
> 
> So far, this is the only user of the register. That's why there is no
> lock. It is explained in the changelog. But if you want I can re-use the
> same comment here.

A comment would be nice, yes. You can make it shorter than the commit message.

> >> +
> >> +	for (i = 1000; i; i--)
> >> +		if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
> >> +			cpu_relax();
> >> +		else
> >> +			return 0;
> > 
> > Please put braces around the for() content.
> 
> OK, no problem, if you prefer that.
> 
> > How many iterations does this need in practice ?
> 
> I don't have any clue :-)

Could you test it ?

> I don't like these kind of magic numbers as well, but without further
> information, it is hard to know.
> 
> Based on TI experience, there is no way to get any accurate information
> about this kind of transition time even from HW enginners. Most of the
> time the best you can get is a tens of micro-sec or a hundred of clock
> cycles.
> 
> FWIW, this "value" is based on what was already done and merged for the
> zlock inside the clock-r8a73a4.c code (non-CCF).
> 
> > I also wonder if we really need to wait or if we could just return and
> > assume the clock frequency will change soon enough.
> 
> We do need to wait, that the recommended procedure from the spec, and
> this is the only way to ensure the frequency is properly changed.
> 
> In the case of DVFS sequence, you do not want to start reducing the
> voltage before you are 100% sure the frequency was reduced before. So
> that's the only safe way to do that.

Good point.

-- 
Regards,

Laurent Pinchart


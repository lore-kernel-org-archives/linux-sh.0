From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Nov 2014 00:10:43 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid changing divisor in .disable()
Message-Id: <6685924.ByhjAR6OUp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1416846048-3821-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416846048-3821-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 24 November 2014 17:20:48 Geert Uytterhoeven wrote:
> While DIV6 clocks require the divisor field to be non-zero when stopping
> the clock, some clocks (e.g. ZB on sh73a0) fail to be re-enabled later
> if the divisor field is changed when stopping the clock.
> 
> To fix this, do not touch the divisor field if it's already non-zero.
> 
> On kzm9g, the smsc911x Ethernet controller is connected to the sh73a0
> Bus State Controller, which is clocked by the ZB clock. Without this
> fix, if the ZB clock is disabled during system suspend, and re-enabled
> during resume, the kernel locks up when the smsc911x driver tries to
> access the Ethernet registers.

Do we have any idea what happens at the hardware level ? Could it be that the 
divider set when stopping the clock has an invalid value ? Does the problem 
occur if you set the divider to a valid value instead of CPG_DIV6_DIV_MASK 
when stopping the clock ?

The problem could also be caused by the new divider not being taken into 
account fast enough if modified during the same write cycle as the CKSTP bit 
when restarting the clock. Does the system still lock if you set the divider 
and clear the CKSTP bit in two seperate write operations when restarting the 
clock ?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/clk/shmobile/clk-div6.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/shmobile/clk-div6.c
> b/drivers/clk/shmobile/clk-div6.c index 639241e31e03ec24..905bf98a74fcfb1e
> 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -54,12 +54,17 @@ static int cpg_div6_clock_enable(struct clk_hw *hw)
>  static void cpg_div6_clock_disable(struct clk_hw *hw)
>  {
>  	struct div6_clock *clock = to_div6_clock(hw);
> +	u32 val;
> 
> -	/* DIV6 clocks require the divisor field to be non-zero when stopping
> +	val = clk_readl(clock->reg);
> +	val |= CPG_DIV6_CKSTP;
> +	/*
> +	 * DIV6 clocks require the divisor field to be non-zero when stopping
>  	 * the clock.
>  	 */
> -	clk_writel(clk_readl(clock->reg) | CPG_DIV6_CKSTP | CPG_DIV6_DIV_MASK,
> -		   clock->reg);
> +	if (!(val & CPG_DIV6_DIV_MASK))
> +		val |= CPG_DIV6_DIV_MASK;
> +	clk_writel(val, clock->reg);
>  }
> 
>  static int cpg_div6_clock_is_enabled(struct clk_hw *hw)

-- 
Regards,

Laurent Pinchart


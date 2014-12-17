From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Dec 2014 14:40:36 +0000
Subject: Re: [PATCH v2] clk: shmobile: div6: Avoid changing divisor in .disable()
Message-Id: <3863706.CETrbFjrjW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418826607-11817-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418826607-11817-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 17 December 2014 15:30:07 Geert Uytterhoeven wrote:
> While DIV6 clocks require the divisor field to be non-zero when stopping
> the clock, some clocks (e.g. ZB on sh73a0) fail to be re-enabled later
> if the divisor field is changed when stopping the clock.
> The reason for this is unknown.
> 
> To fix this, do not touch the divisor field if it's already non-zero.
> 
> On kzm9g, the smsc911x Ethernet controller is connected to the sh73a0
> Bus State Controller, which is clocked by the ZB clock. Without this
> fix, if the ZB clock is disabled during system suspend, and re-enabled
> during resume, the kernel locks up when the smsc911x driver tries to
> access the Ethernet registers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

By the way, have you noticed the issue on any platform other than sh73a0 ? 
There might be a chance to get feedback on the hardware on a new platform, but 
not on such an old one.

> ---
> Mike, I can queue up this patch in a branch, together with other clk-related
> patches for shmobile for 3.20, and ask you to pull later.
> Is that OK for you?
> 
> Thanks!
> 
> v2:
>   - Add a comment to the code
>   - Add a note about our (lack of) understanding of the hardware.
> ---
>  drivers/clk/shmobile/clk-div6.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/shmobile/clk-div6.c
> b/drivers/clk/shmobile/clk-div6.c index 639241e31e03ec24..efbaf6c81b7530b8
> 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -54,12 +54,19 @@ static int cpg_div6_clock_enable(struct clk_hw *hw)
>  static void cpg_div6_clock_disable(struct clk_hw *hw)
>  {
>  	struct div6_clock *clock = to_div6_clock(hw);
> +	u32 val;
> 
> -	/* DIV6 clocks require the divisor field to be non-zero when stopping
> -	 * the clock.
> +	val = clk_readl(clock->reg);
> +	val |= CPG_DIV6_CKSTP;
> +	/*
> +	 * DIV6 clocks require the divisor field to be non-zero when stopping
> +	 * the clock. However, some clocks (e.g. ZB on sh73a0) fail to be
> +	 * re-enabled later if the divisor field is changed when stopping the
> +	 * clock
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


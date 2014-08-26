From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Aug 2014 16:47:11 +0000
Subject: Re: [RESEND PATCH v3] clk: shmobile: div6: support selectable-input clocks
Message-Id: <1435844.NvqxA65edX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1409065878-32047-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409065878-32047-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: horms@verge.net.au, linux-sh@vger.kernel.org, mturquette@linaro.org, magnus.damm@gmail.com, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Ulrich,

Thank you for the patch.

On Tuesday 26 August 2014 17:11:18 Ulrich Hecht wrote:
> Adds support for DIV6 clocks with selectable parents as found in the
> r8a73a4, r8a7740, sh73a0, and other SoCs.

I find the commit message a bit misleading, it made me assume the patch added 
support for selecting the input at runtime, which it doesn't. How about 
something along the lines of "Add support for selecting the DIV6 parent at 
initialization time based on the current hardware configuration" ?

Please see below for a couple of minor comments.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> 
> Changes since v2:
> - add r8a73a4 to bindings
> - use u32 where appropriate
> - don't split error message
> 
> Changes since v1:
> - make sure unrelated register bits are preserved
> - use the plural for the clocks property in bindings
> 
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     | 12 +++++++-
>  drivers/clk/shmobile/clk-div6.c                    | 32 +++++++++++++++----
>  2 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt index
> 952e373..b002d2b 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -7,14 +7,24 @@ to 64.
>  Required Properties:
> 
>    - compatible: Must be one of the following
> +    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
> +    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
>      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
>      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
> +    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-MobileAG5) DIV6 clocks
>      - "renesas,cpg-div6-clock" for generic DIV6 clocks
>    - reg: Base address and length of the memory resource used by the DIV6
> clock
> -  - clocks: Reference to the parent clock
> +  - clocks: Reference to the parent clock(s)
>    - #clock-cells: Must be 0
>    - clock-output-names: The name of the clock as a free-form string
> 
> +Optional Properties:
> +
> +  - renesas,src-shift: Bit position of the input clock selector (default:
> +    fixed input clock)
> +  - renesas,src-width: Bit width of the input clock selector (default:
> fixed
> +    input clock)

Should we mention that if one of the properties is set then the other must be 
set as well ?

If I'm not mistaken those properties don't apply to the H2 and M2 CPGs. Should 
that be mentioned in the bindings ?

> +
> 
>  Example
>  -------
> diff --git a/drivers/clk/shmobile/clk-div6.c
> b/drivers/clk/shmobile/clk-div6.c index f065f69..2282bec 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -38,9 +38,12 @@ struct div6_clock {
> 
>  static int cpg_div6_clock_enable(struct clk_hw *hw)
>  {
> +	u32 val;
>  	struct div6_clock *clock = to_div6_clock(hw);

Could you please reverse the order of those two lines to match the coding 
style of the file ? I tend to sort local variables in "reverse christmas tree" 
order.

> -	clk_writel(CPG_DIV6_DIV(clock->div - 1), clock->reg);
> +	val = (clk_readl(clock->reg) & ~(CPG_DIV6_DIV_MASK | CPG_DIV6_CKSTP))
> +		| CPG_DIV6_DIV(clock->div - 1);

Could you please align the | under the = ?

> +	clk_writel(val, clock->reg);
> 
>  	return 0;
>  }
> @@ -52,8 +55,8 @@ static void cpg_div6_clock_disable(struct clk_hw *hw)
>  	/* DIV6 clocks require the divisor field to be non-zero when stopping
>  	 * the clock.
>  	 */
> -	clk_writel(CPG_DIV6_CKSTP | CPG_DIV6_DIV(CPG_DIV6_DIV_MASK),
> -		   clock->reg);
> +	clk_writel(clk_readl(clock->reg) | CPG_DIV6_CKSTP | CPG_DIV6_DIV_MASK,
> +		clock->reg);

Could you please align the clock under the clk_read ?

>  }
> 
>  static int cpg_div6_clock_is_enabled(struct clk_hw *hw)
> @@ -94,12 +97,14 @@ static int cpg_div6_clock_set_rate(struct clk_hw *hw,
> unsigned long rate, {
>  	struct div6_clock *clock = to_div6_clock(hw);
>  	unsigned int div = cpg_div6_clock_calc_div(rate, parent_rate);
> +	u32 val;
> 
>  	clock->div = div;
> 
> +	val = clk_readl(clock->reg) & ~CPG_DIV6_DIV_MASK;
>  	/* Only program the new divisor if the clock isn't stopped. */
> -	if (!(clk_readl(clock->reg) & CPG_DIV6_CKSTP))
> -		clk_writel(CPG_DIV6_DIV(clock->div - 1), clock->reg);
> +	if (!(val & CPG_DIV6_CKSTP))
> +		clk_writel(val | CPG_DIV6_DIV(clock->div - 1), clock->reg);
> 
>  	return 0;
>  }
> @@ -121,6 +126,7 @@ static void __init cpg_div6_clock_init(struct
> device_node *np) const char *name;
>  	struct clk *clk;
>  	int ret;
> +	u32 src_shift, src_width;

Same comment here, could you please split the declaration on two lines and 
move them above int ret ?

>  	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
>  	if (!clock) {
> @@ -150,7 +156,21 @@ static void __init cpg_div6_clock_init(struct
> device_node *np) goto error;
>  	}
> 
> -	parent_name = of_clk_get_parent_name(np, 0);
> +	if (!of_property_read_u32(np, "renesas,src-shift", &src_shift)) {
> +		if (!of_property_read_u32(np, "renesas,src-width",
> +					&src_width)) {
> +			unsigned int parent_idx > +				(clk_readl(clock->reg) >> src_shift) &
> +				(BIT(src_width) - 1);
> +			parent_name = of_clk_get_parent_name(np, parent_idx);
> +		} else {
> +			pr_err("%s: renesas,src-shift without renesas,src-width in %s\n",
> +			       __func__, np->name);
> +			goto error;
> +		}
> +	} else
> +		parent_name = of_clk_get_parent_name(np, 0);

Please add { } around the above line (didn't checkpatch.pl warn about that ?).

> +
>  	if (parent_name = NULL) {
>  		pr_err("%s: failed to get %s DIV6 clock parent name\n",
>  		       __func__, np->name);

-- 
Regards,

Laurent Pinchart


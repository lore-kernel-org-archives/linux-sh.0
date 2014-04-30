From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Apr 2014 23:55:08 +0000
Subject: Re: [PATCH 1/4] clk: shmobile: div6: support selectable-input clocks
Message-Id: <2460426.nj5ZX18gns@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398172752-30567-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1398172752-30567-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Tuesday 22 April 2014 15:19:09 Ulrich Hecht wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Adds support for DIV6 clocks with selectable parents as found in the r8a7740
> and other SoCs.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  .../bindings/clock/renesas,cpg-div6-clocks.txt        |  8 ++++++++
>  drivers/clk/shmobile/clk-div6.c                       | 19 +++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt index
> 952e373..f8302f5 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -7,6 +7,7 @@ to 64.
>  Required Properties:
> 
>    - compatible: Must be one of the following
> +    - "renesas,r8a7740-div6-clock" for R8A7740 DIV6 clocks
>      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
>      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
>      - "renesas,cpg-div6-clock" for generic DIV6 clocks
> @@ -15,6 +16,13 @@ Required Properties:
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

Now that the driver supports multiple input clocks, you also need to update 
the documentation of the clocks field which currently reads

"- clocks: Reference to the parent clock"

We also need to think about what to do when some values of the source field 
are reserved. For instance, if the source field is two bits large, and only 
value 00 and 10 are valid, the clocks field should probably contain something 
like

	clocks = <&clk_src_0 3>, <0>, <&clk_src_3 2>, <0>;

I'm not sure whether "NULL" clock entries are supported though. They're not 
documented in Documentation/devicetree/bindings/clock/clock-bindings.txt but 
could be supported by the code. At least the common clock bindings 
documentation should be fixed. I think a patch has been posted some time ago 
on LAKML.

One possible issue with this implementation is that large source fields with 
only a couple of valid values will require lots of NULL clock entries. Another 
option would be to use clock-names with the index number set as the name. The 
above example would become

	clocks = <&clk_src_0 3>, <&clk_src_3 2>;
	clock-names = "0", "2";

>  Example
>  -------
> diff --git a/drivers/clk/shmobile/clk-div6.c
> b/drivers/clk/shmobile/clk-div6.c index f065f69..5be8161 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -121,6 +121,7 @@ static void __init cpg_div6_clock_init(struct
> device_node *np) const char *name;
>  	struct clk *clk;
>  	int ret;
> +	u32 src_shift, src_width;
> 
>  	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
>  	if (!clock) {
> @@ -150,7 +151,23 @@ static void __init cpg_div6_clock_init(struct
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
> +		}
> +		else {
> +			pr_err("%s: renesas,src-shift without renesas,"
> +			       "src-width in %s\n", __func__, np->name);
> +			goto error;
> +		}
> +	}
> +	else
> +		parent_name = of_clk_get_parent_name(np, 0);
> +

I'd move that to a separate cpg_div6_get_parent_index() function to make the 
code cleaner. Something like

static int *cpg_div6_get_parent_index(struct div6_clock *clock,
                                      struct device_node *np)
{
	u32 shift, width;
	int ret;

	ret = of_property_read_u32(np, "renesas,src-shift", &shift);
	if (ret < 0)
		return ret;

	ret = of_property_read_u32(np, "renesas,src-width", &width);
	if (ret < 0)
		pr_err("%s: renesas,src-shift without renesas,src-width in %s\n",
		       __func__, np->name);
		return ret;
	}

	return clk_readl(clock->reg) >> shift) & 	(BIT(width) - 1);
}

This only supports reading the current source. Implementing support for 
modifying the source shouldn't be too difficult. I don't think we need to 
implement it right now, but I believe we at least need to give it a thought.

-- 
Regards,

Laurent Pinchart

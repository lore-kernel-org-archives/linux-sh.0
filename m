From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 30 Oct 2015 13:54:57 +0000
Subject: Re: [PATCH v5 3/5] clk: shmobile: div6: Extract cpg_div6_register()
Message-Id: <2017139.CLh1RkkDeg@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1446117664-6037-1-git-send-email-geert+renesas@glider.be> <1446117664-6037-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446117664-6037-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 29 October 2015 12:21:02 Geert Uytterhoeven wrote:
> Extract cpg_div6_register(), to allow registering div6 clocks from
> another clock driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v5:
>   - Document cpg_div6_register(),
>   - Free clock on clock->parents allocation failure,
>   - Add include guards to clk-div6.h,
>   - Drop RFC state,
> 
> v4:
>   - New.
> ---
>  drivers/clk/shmobile/clk-div6.c | 132 ++++++++++++++++++++++++------------
>  drivers/clk/shmobile/clk-div6.h |   7 +++
>  2 files changed, 94 insertions(+), 45 deletions(-)
>  create mode 100644 drivers/clk/shmobile/clk-div6.h
> 
> diff --git a/drivers/clk/shmobile/clk-div6.c
> b/drivers/clk/shmobile/clk-div6.c index c89566a918290246..5970d6a1506a9075
> 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -18,6 +18,8 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> 
> +#include "clk-div6.h"
> +
>  #define CPG_DIV6_CKSTP		BIT(8)
>  #define CPG_DIV6_DIV(d)		((d) & 0x3f)
>  #define CPG_DIV6_DIV_MASK	0x3f
> @@ -172,60 +174,44 @@ static const struct clk_ops cpg_div6_clock_ops = {
>  	.set_rate = cpg_div6_clock_set_rate,
>  };
> 
> -static void __init cpg_div6_clock_init(struct device_node *np)
> +
> +/**
> + * cpg_div6_register - Register a DIV6 clock
> + * @name: Name of the DIV6 clock
> + * @num_parents: Number of parent clocks of the DIV6 clock (1, 4, or 8)
> + * @parent_names: Array containing the names of the parent clocks
> + * @reg: Mapped register used to control the DIV6 clock
> + */
> +struct clk * __init cpg_div6_register(const char *name,
> +				      unsigned int num_parents,
> +				      const char **parent_names,
> +				      void __iomem *reg)
>  {
> -	unsigned int num_parents, valid_parents;
> -	const char **parent_names;
> +	unsigned int valid_parents;
>  	struct clk_init_data init;
>  	struct div6_clock *clock;
> -	const char *clk_name = np->name;
>  	struct clk *clk;
>  	unsigned int i;
> 
>  	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
>  	if (!clock)
> -		return;
> +		return ERR_PTR(-ENOMEM);
> 
> -	num_parents = of_clk_get_parent_count(np);
> -	if (num_parents < 1) {
> -		pr_err("%s: no parent found for %s DIV6 clock\n",
> -		       __func__, np->name);
> -		return;
> +	clock->parents = kmalloc_array(num_parents, sizeof(*clock->parents),
> +				       GFP_KERNEL);
> +	if (!clock->parents) {
> +		clk = ERR_PTR(-ENOMEM);
> +		goto free_clock;
>  	}
> 
> -	clock->parents = kmalloc_array(num_parents, sizeof(*clock->parents),
> -		GFP_KERNEL);
> -	parent_names = kmalloc_array(num_parents, sizeof(*parent_names),
> -				GFP_KERNEL);
> -	if (!parent_names)
> -		return;
> +	clock->reg = reg;
> 
> -	/* Remap the clock register and read the divisor. Disabling the
> -	 * clock overwrites the divisor, so we need to cache its value for the
> -	 * enable operation.
> +	/*
> +	 * Read the divisor. Disabling the clock overwrites the divisor, so we
> +	 * need to cache its value for the enable operation.
>  	 */
> -	clock->reg = of_iomap(np, 0);
> -	if (clock->reg = NULL) {
> -		pr_err("%s: failed to map %s DIV6 clock register\n",
> -		       __func__, np->name);
> -		goto error;
> -	}
> -
>  	clock->div = (clk_readl(clock->reg) & CPG_DIV6_DIV_MASK) + 1;
> 
> -	/* Parse the DT properties. */
> -	of_property_read_string(np, "clock-output-names", &clk_name);
> -
> -	for (i = 0, valid_parents = 0; i < num_parents; i++) {
> -		const char *name = of_clk_get_parent_name(np, i);
> -
> -		if (name) {
> -			parent_names[valid_parents] = name;
> -			clock->parents[valid_parents] = i;
> -			valid_parents++;
> -		}
> -	}
> -
>  	switch (num_parents) {
>  	case 1:
>  		/* fixed parent clock */
> @@ -243,12 +229,22 @@ static void __init cpg_div6_clock_init(struct
> device_node *np) break;
>  	default:
>  		pr_err("%s: invalid number of parents for DIV6 clock %s\n",
> -		       __func__, np->name);
> -		goto error;
> +		       __func__, name);
> +		clk = ERR_PTR(-EINVAL);
> +		goto free_parents;
> +	}
> +
> +	/* Filter out invalid parents */
> +	for (i = 0, valid_parents = 0; i < num_parents; i++) {
> +		if (parent_names[i]) {
> +			parent_names[valid_parents] = parent_names[i];
> +			clock->parents[valid_parents] = i;
> +			valid_parents++;
> +		}
>  	}
> 
>  	/* Register the clock. */
> -	init.name = clk_name;
> +	init.name = name;
>  	init.ops = &cpg_div6_clock_ops;
>  	init.flags = CLK_IS_BASIC;
>  	init.parent_names = parent_names;
> @@ -257,6 +253,53 @@ static void __init cpg_div6_clock_init(struct
> device_node *np) clock->hw.init = &init;
> 
>  	clk = clk_register(NULL, &clock->hw);
> +	if (IS_ERR(clk))
> +		goto free_parents;
> +
> +	return clk;
> +
> +free_parents:
> +	kfree(clock->parents);
> +free_clock:
> +	kfree(clock);
> +	return clk;
> +}
> +
> +static void __init cpg_div6_clock_init(struct device_node *np)
> +{
> +	unsigned int num_parents;
> +	const char **parent_names;
> +	const char *clk_name = np->name;
> +	void __iomem *reg;
> +	struct clk *clk;
> +	unsigned int i;
> +
> +	num_parents = of_clk_get_parent_count(np);
> +	if (num_parents < 1) {
> +		pr_err("%s: no parent found for %s DIV6 clock\n",
> +		       __func__, np->name);
> +		return;
> +	}
> +
> +	parent_names = kmalloc_array(num_parents, sizeof(*parent_names),
> +				GFP_KERNEL);
> +	if (!parent_names)
> +		return;
> +
> +	reg = of_iomap(np, 0);
> +	if (reg = NULL) {
> +		pr_err("%s: failed to map %s DIV6 clock register\n",
> +		       __func__, np->name);
> +		goto error;
> +	}
> +
> +	/* Parse the DT properties. */
> +	of_property_read_string(np, "clock-output-names", &clk_name);
> +
> +	for (i = 0; i < num_parents; i++)
> +		parent_names[i] = of_clk_get_parent_name(np, i);
> +
> +	clk = cpg_div6_register(clk_name, num_parents, parent_names, reg);
>  	if (IS_ERR(clk)) {
>  		pr_err("%s: failed to register %s DIV6 clock (%ld)\n",
>  		       __func__, np->name, PTR_ERR(clk));
> @@ -269,9 +312,8 @@ static void __init cpg_div6_clock_init(struct
> device_node *np) return;
> 
>  error:
> -	if (clock->reg)
> -		iounmap(clock->reg);
> +	if (reg)
> +		iounmap(reg);
>  	kfree(parent_names);
> -	kfree(clock);
>  }
>  CLK_OF_DECLARE(cpg_div6_clk, "renesas,cpg-div6-clock",
> cpg_div6_clock_init); diff --git a/drivers/clk/shmobile/clk-div6.h
> b/drivers/clk/shmobile/clk-div6.h new file mode 100644
> index 0000000000000000..9a85a95188daa813
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-div6.h
> @@ -0,0 +1,7 @@
> +#ifndef __SHMOBILE_CLK_DIV6_H__
> +#define __SHMOBILE_CLK_DIV6_H__
> +
> +struct clk *cpg_div6_register(const char *name, unsigned int num_parents,
> +			      const char **parent_names, void __iomem *reg);
> +
> +#endif

-- 
Regards,

Laurent Pinchart


From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 05 Jan 2015 08:53:02 +0000
Subject: Re: [PATCH v2] clk-rcar-gen2: RCAN clock support
Message-Id: <1550804.XpyQtHjy2T@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <3007073.i0ghnTEhxV@wasted.cogentembedded.com>
In-Reply-To: <3007073.i0ghnTEhxV@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: mturquette@linaro.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org, linux-sh@vger.kernel.org, vksavl@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Thursday 25 December 2014 01:17:29 Sergei Shtylyov wrote:
> Add the RCAN clock support to the R-Car generation 2 CPG driver.  This clock
> gets derived from  the USB_EXTAL clock, dividing  it by 6.  The layout of
> the RCANCKCR register is similar to those of the clocks supported by the
> 'clk-div6' driver but has no divider field, and so can't be supported by
> that driver...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'clk-next' branch of Mike Turquette's 'linux.git'
> repo.
> 
> Changes in version 2:
> - switched to using the composite clock driver with the fixed factor and
> gated clock component drivers;
> - removed *static* from 'parent_name' definition, switching from assignment
> to initializer;
> - modified the binding document;
> - modified the changelog.
> 
>  Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 
>   5 -
>  drivers/clk/shmobile/clk-rcar-gen2.c                      |   40 ++++++++++

Could you please also add a #define for the RCAN clock in include/dt-
bindings/clock/r8a779*-clock.h ? Same comment for the ADSP clock in "[PATCH] 
clk-rcar-gen2: ADSP clock support".

>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> Index:
> linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.
> txt ================================== ---
> linux.orig/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-cl
> ocks.txt +++
> linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.
> txt @@ -16,7 +16,7 @@ Required Properties:
>    - clocks: Reference to the parent clock
>    - #clock-cells: Must be 1
>    - clock-output-names: The names of the clocks. Supported clocks are
> "main",
> -    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1" and
> "z"
> +    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z",
> and "rcan"
> 
> 
>  Example
> @@ -29,5 +29,6 @@ Example
>  		clocks = <&extal_clk>;
>  		#clock-cells = <1>;
>  		clock-output-names = "main", "pll0, "pll1", "pll3",
> -				     "lb", "qspi", "sdh", "sd0", "sd1", "z";
> +				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
> +				     "rcan";
>  	};
> Index: linux/drivers/clk/shmobile/clk-rcar-gen2.c
> =================================> --- linux.orig/drivers/clk/shmobile/clk-rcar-gen2.c
> +++ linux/drivers/clk/shmobile/clk-rcar-gen2.c
> @@ -33,6 +33,7 @@ struct rcar_gen2_cpg {
>  #define CPG_FRQCRC			0x000000e0
>  #define CPG_FRQCRC_ZFC_MASK		(0x1f << 8)
>  #define CPG_FRQCRC_ZFC_SHIFT		8
> +#define CPG_RCANCKCR			0x00000270
> 
>  /*
> ---------------------------------------------------------------------------
> -- * Z Clock
> @@ -161,6 +162,43 @@ static struct clk * __init cpg_z_clk_reg
>  	return clk;
>  }
> 
> +static struct clk * __init cpg_rcan_clk_register(struct rcar_gen2_cpg *cpg,
> +						 struct device_node *np)
> +{
> +	const char *parent_name = of_clk_get_parent_name(np, 1);
> +	struct clk_fixed_factor *fixed;
> +	struct clk_gate *gate;
> +	struct clk *clk;
> +
> +	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
> +	if (!fixed)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fixed->mult = 1;
> +	fixed->div = 6;
> +
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate) {
> +		kfree(fixed);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	gate->reg = cpg->reg + CPG_RCANCKCR;
> +	gate->bit_idx = 8;
> +	gate->flags = CLK_GATE_SET_TO_DISABLE;
> +	gate->lock = &cpg->lock;
> +
> +	clk = clk_register_composite(NULL, "rcan", &parent_name, 1, NULL, NULL,
> +				     &fixed->hw, &clk_fixed_factor_ops,
> +				     &gate->hw, &clk_gate_ops, 0);
> +	if (IS_ERR(clk)) {
> +		kfree(gate);
> +		kfree(fixed);
> +	}
> +
> +	return clk;
> +}
> +
>  /*
> ---------------------------------------------------------------------------
> -- * CPG Clock Data
>   */
> @@ -263,6 +301,8 @@ rcar_gen2_cpg_register_clock(struct devi
>  		shift = 0;
>  	} else if (!strcmp(name, "z")) {
>  		return cpg_z_clk_register(cpg);
> +	} else if (!strcmp(name, "rcan")) {
> +		return cpg_rcan_clk_register(cpg, np);
>  	} else {
>  		return ERR_PTR(-EINVAL);
>  	}

-- 
Regards,

Laurent Pinchart


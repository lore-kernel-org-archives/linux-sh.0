From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 25 Aug 2015 22:46:38 +0000
Subject: Re: [PATCH 1/2] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <20150825224638.GL19120@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhcz7u2i.wl%kuninori.morimoto.gx@renesas.com>
 <87k2sj7tzs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k2sj7tzs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org

On 08/25, Kuninori Morimoto wrote:
> diff --git a/drivers/clk/shmobile/clk-rcar-gen3.c b/drivers/clk/shmobile/clk-rcar-gen3.c
> new file mode 100644
> index 0000000..098caac
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-rcar-gen3.c
> @@ -0,0 +1,232 @@
> +/*
> + * rcar_gen3 Core CPG Clocks
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * Based on rcar_gen2 Core CPG Clocks driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used?

> +#include <linux/clk/shmobile.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>

Is this include used?

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/spinlock.h>
> +
> +struct rcar_gen3_cpg {
> +	struct clk_onecell_data data;
> +	spinlock_t lock;
> +	void __iomem *reg;
> +};
> +
> +#define CPG_PLL0CR	0x00d8
> +#define CPG_PLL2CR	0x002c
> +
> +/*
> + * common function
> + */
> +#define rcar_clk_readl(cpg, _reg) clk_readl(cpg->reg + _reg)

Please just use readl instead of clk_readl.

> +
> +/*
> + * Reset register definitions.
> + */
> +#define MODEMR 0xe6160060
> +
> +static u32 rcar_gen3_read_mode_pins(void)
> +{
> +	static u32 mode;
> +	static bool mode_valid;
> +
> +	if (!mode_valid) {
> +		void __iomem *modemr = ioremap_nocache(MODEMR, 4);
> +
> +		BUG_ON(!modemr);
> +		mode = ioread32(modemr);
> +		iounmap(modemr);
> +		mode_valid = true;
> +	}
> +
> +	return mode;
> +}

Perhaps this should be read using a syscon?

> +struct cpg_pll_config {
> +	unsigned int extal_div;
> +	unsigned int pll1_mult;
> +	unsigned int pll3_mult;
> +	unsigned int pll4_mult;
> +};
> +
> +static const struct cpg_pll_config cpg_pll_configs[16] __initconst = {

We don't actually need the 16, but ok.

> +/* EXTAL div	PLL1	PLL3	PLL4 */
> +	{ 1,	192,	192,	144, },
> +	{ 1,	192,	128,	144, },
> +	{ 0,	0,	0,	0,   }, /* Prohibited setting */
> +	{ 1,	192,	192,	144, },
> +	{ 1,	156,	156,	120, },
> +	{ 1,	156,	106,	120, },
> +	{ 0,	0,	0,	0,   }, /* Prohibited setting */
> +	{ 1,	156,	156,	120, },
> +	{ 1,	128,	128,	96,  },
> +	{ 1,	128,	84,	96,  },
> +	{ 0,	0,	0,	0,   }, /* Prohibited setting */
> +	{ 1,	128,	128,	96,  },
> +	{ 2,	192,	192,	144, },
> +	{ 2,	192,	128,	144, },
> +	{ 0,	0,	0,	0,   }, /* Prohibited setting */
> +	{ 2,	192,	192,	144, },
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Initialization
> + */
> +
> +static u32 cpg_mode __initdata;

Why isn't this local to the only function that uses it?

> +
> +static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
> +{
> +	const struct cpg_pll_config *config;
> +	struct rcar_gen3_cpg *cpg;
> +	struct clk **clks;
> +	unsigned int i;
> +	int num_clks;
> +
> +	cpg_mode = rcar_gen3_read_mode_pins();
> +
> +	num_clks = of_property_count_strings(np, "clock-output-names");
> +	if (num_clks < 0) {
> +		pr_err("%s: failed to count clocks\n", __func__);
> +		return;
> +	}
> +
> +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> +	clks = kzalloc((num_clks * sizeof(*clks)), GFP_KERNEL);

kcalloc()

> +	if (cpg = NULL || clks = NULL) {
> +		/* We're leaking memory on purpose, there's no point in cleaning
> +		 * up as the system won't boot anyway.
> +		 */

kfree() does nothing on NULL, so it should be easy enough to
delete this comment and replace it with two calls to kfree().

> +		pr_err("%s: failed to allocate cpg\n", __func__);
> +		return;
> +	}
> +
> +	spin_lock_init(&cpg->lock);
> +
> +	cpg->data.clks = clks;
> +	cpg->data.clk_num = num_clks;
> +
> +	cpg->reg = of_iomap(np, 0);
> +	if (WARN_ON(cpg->reg = NULL))
> +		return;
> +
> +	config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
> +	if (!config->extal_div) {
> +		pr_err("%s: Prohibited setting (cpg_mode=0x%x)\n",
> +		       __func__, cpg_mode);
> +		return;
> +	}
> +
> +	for (i = 0; i < num_clks; ++i) {
> +		const char *name;
> +		struct clk *clk;
> +
> +		of_property_read_string_index(np, "clock-output-names", i,
> +					      &name);
> +
> +		clk = rcar_gen3_cpg_register_clock(np, cpg, config, name);

Is there any reason why we need to register clocks based on
what's in DT? I would prefer to see a method where we register
clocks based on the compatible string in DT. This would get rid
of all the string comparisons in rcar_gen3_cpg_register_clock()
and make for cleaner code.

Furthermore, we could make this into a platform driver so that we
can benefit from the device model.

> +		if (IS_ERR(clk))
> +			pr_err("%s: failed to register %s %s clock (%ld)\n",
> +			       __func__, np->name, name, PTR_ERR(clk));
> +		else
> +			cpg->data.clks[i] = clk;
> +	}
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> +}
> +CLK_OF_DECLARE(rcar_gen3_cpg_clks, "renesas,rcar-gen3-cpg-clocks",
> +	       rcar_gen3_cpg_clocks_init);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

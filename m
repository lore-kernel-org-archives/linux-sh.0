From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Jan 2015 23:37:32 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: r8a7778: common clock framework CPG driver
Message-Id: <1601524.NSiUA0E7iq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Wednesday 21 January 2015 17:20:55 Ulrich Hecht wrote:
> Driver for the r8a7778's clocks that depend on the mode bits.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  24 ++++
>  arch/arm/mach-shmobile/board-bockw-reference.c     |   2 +
>  arch/arm/mach-shmobile/setup-r8a7778.c             |  19 +++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-r8a7778.c                 | 146 ++++++++++++++++++
>  include/linux/clk/shmobile.h                       |   1 +
>  6 files changed, 193 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
> create mode 100644 drivers/clk/shmobile/clk-r8a7778.c

[snip]

> diff --git a/drivers/clk/shmobile/clk-r8a7778.c
> b/drivers/clk/shmobile/clk-r8a7778.c new file mode 100644
> index 0000000..30c5c14
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-r8a7778.c
> @@ -0,0 +1,146 @@
> +/*
> + * r8a7778 Core CPG Clocks
> + *
> + * Copyright (C) 2014  Ulrich Hecht
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/shmobile.h>
> +#include <linux/of_address.h>
> +
> +struct r8a7778_cpg {
> +	struct clk_onecell_data data;
> +	spinlock_t lock;
> +	void __iomem *reg;
> +};
> +
> +/* EXTAL rate and PLL multipliers per bits 11, 12, and 18 of MODEMR */
> +struct {
> +	unsigned long extal_rate;
> +	unsigned long plla_mult;
> +	unsigned long pllb_mult;
> +} r8a7778_rates[] __initdata = {
> +	[0] = { 38000000, 21, 21},
> +	[1] = { 33333333, 24, 24},
> +	[2] = { 28500000, 28, 28},
> +	[3] = { 25000000, 32, 32},
> +	[5] = { 33333333, 24, 21},
> +	[6] = { 28500000, 28, 21},
> +	[7] = { 25000000, 32, 24},
> +};
> +
> +/* Clock dividers per bits 1 and 2 of MODEMR */
> +struct {
> +	const char *name;
> +	unsigned int div[4];
> +} r8a7778_divs[6] __initdata = {
> +	{ "b",   { 12, 12, 16, 18 } },
> +	{ "out", { 12, 12, 16, 18 } },
> +	{ "p",   { 16, 12, 16, 12 } },
> +	{ "s",   { 4,  3,  4,  3  } },
> +	{ "s1",  { 8,  6,  8,  6  } },
> +	{ NULL },
> +};
> +
> +static u32 cpg_mode_rates __initdata;
> +static u32 cpg_mode_divs __initdata;
> +
> +static struct clk * __init
> +r8a7778_cpg_register_clock(struct device_node *np, struct r8a7778_cpg *cpg,
> +			     const char *name)
> +{
> +	if (!strcmp(name, "extal")) {
> +		return clk_register_fixed_rate(NULL, "extal", NULL,
> +			CLK_IS_ROOT, r8a7778_rates[cpg_mode_rates].extal_rate);

As the external clock is an input to the CPG, shouldn't it be specified by a 
separate fixed-frequency clock DT node, and referenced by the CPG using the 
clocks attributes ? You could then remove the extal_rate field from the 
r8a7778_rates array above, and possibly rename the array to r8a7778_pll_mults 
or similar.

> +	} else if (!strcmp(name, "plla")) {
> +		return clk_register_fixed_factor(NULL, "plla", "extal", 0,
> +			r8a7778_rates[cpg_mode_rates].plla_mult, 1);
> +	} else if (!strcmp(name, "pllb")) {
> +		return clk_register_fixed_factor(NULL, "pllb", "extal", 0,
> +			r8a7778_rates[cpg_mode_rates].pllb_mult, 1);
> +	} else {
> +		unsigned int i;
> +
> +		for (i = 0; r8a7778_divs[i].name; i++) {

You could use i < ARRAY_SIZE(r8a7778_divs) here and avoid the NULL entry at 
the end of the array.

> +			if (!strcmp(name, r8a7778_divs[i].name)) {
> +				return clk_register_fixed_factor(NULL,
> +					r8a7778_divs[i].name,
> +					"plla", 0, 1,
> +					r8a7778_divs[i].div[cpg_mode_divs]);
> +			}
> +		}
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +
> +static void __init r8a7778_cpg_clocks_init(struct device_node *np)
> +{
> +	struct r8a7778_cpg *cpg;
> +	struct clk **clks;
> +	unsigned int i;
> +	int num_clks;
> +
> +	num_clks = of_property_count_strings(np, "clock-output-names");
> +	if (num_clks < 0) {
> +		pr_err("%s: failed to count clocks\n", __func__);
> +		return;
> +	}
> +
> +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> +	clks = kcalloc(num_clks, sizeof(*clks), GFP_KERNEL);
> +	if (cpg = NULL || clks = NULL) {
> +		/* We're leaking memory on purpose, there's no point in cleaning
> +		 * up as the system won't boot anyway.
> +		 */
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
> +	for (i = 0; i < num_clks; ++i) {
> +		const char *name;
> +		struct clk *clk;
> +
> +		of_property_read_string_index(np, "clock-output-names", i,
> +					      &name);
> +
> +		clk = r8a7778_cpg_register_clock(np, cpg, name);
> +		if (IS_ERR(clk))
> +			pr_err("%s: failed to register %s %s clock (%ld)\n",
> +			       __func__, np->name, name, PTR_ERR(clk));
> +		else
> +			cpg->data.clks[i] = clk;
> +	}
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> +}
> +
> +CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
> +	       r8a7778_cpg_clocks_init);
> +
> +void __init r8a7778_clocks_init(u32 mode)
> +{
> +	if (!(mode & BIT(19)))
> +		BUG();

Nitpicking here, you could use BUG_ON().

> +	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
> +			 (!!(mode & BIT(12)) << 1) |
> +			 (!!(mode & BIT(11)));
> +	cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
> +			(!!(mode & BIT(1)));
> +
> +	of_clk_init(NULL);
> +}

-- 
Regards,

Laurent Pinchart


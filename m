From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Sep 2015 10:59:01 +0000
Subject: Re: [PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CANqRtoSw92UoVBvTJfzGvxmYwefNndqqnj2_8iqi5O=FUeLMGA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple>
	<20150831124904.31057.19757.sendpatchset@little-apple>
	<1692617.kRMz5BT8ct@avalon>
In-Reply-To: <1692617.kRMz5BT8ct@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Laurent,

On Tue, Sep 1, 2015 at 3:00 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Monday 31 August 2015 21:49:04 Magnus Damm wrote:
>> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>
>> This V5 patch adds initial CPG support for R-Car Generation 3 and in
>> particular the R8A7795 SoC.
>>
>> The R-Car Gen3 clock hardware has a register write protection feature that
>> needs to be shared between the CPG function needs to be shared between
>> the CPG and MSTP hardware somehow. So far this feature is simply ignored.
>>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
>>  - Simplified clks array handling - thanks Geert!
>>  - Updated th DT binding documentation to reflect latest state
>>  - of_property_count_strings() -> of_property_count_u32_elems() fix
>>
>>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
>>  - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
>>  - Major things like syscon and driver model require more discussion.
>>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
>>
>>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
>>  - Reworked driver to rely on clock index instead of strings.
>>  - Dropped use of "clock-output-names".
>>
>>  Earlier versions: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>  Initial version: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>
>>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |
>>  32 +
>>  drivers/clk/Makefile                                     |    1
>>  drivers/clk/shmobile/Makefile                            |    1
>>  drivers/clk/shmobile/clk-rcar-gen3.c                     |  245 ++++++++++
>>  4 files changed, 279 insertions(+)
>>
>> --- /dev/null
>> +++
>> work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.t
>> xt    2015-08-31 15:49:10.000000000 +0900 @@ -0,0 +1,32 @@
>> +* Renesas R-Car Gen3 Clock Pulse Generator (CPG)
>> +
>> +The CPG generates core clocks for the R-Car Gen3 SoCs. It includes three
>> PLLs
>> +and several fixed ratio dividers.
>> +
>> +Required Properties:
>> +
>> +  - compatible: Must be one of
>> +    - "renesas,r8a7795-cpg-clocks" for the r8a7795 CPG
>> +    - "renesas,rcar-gen3-cpg-clocks" for the generic R-Car Gen3 CPG
>> +
>> +  - reg: Base address and length of the memory resource used by the CPG
>> +
>> +  - clocks: References to the parent clocks: first to the EXTAL clock
>> +  - #clock-cells: Must be 1
>> +  - clock-indices: Indices of the exported clocks
>
> Do we actually need the clock-indices property, as CPG clocks are numbered
> sequentially ? It seems to me like we could drop the property, especially
> given that the number of clocks is hardcoded in the driver anyway.

There are two reasons why they are there:
1) I like to be able to search DT files to see which node that is
providing what clock.
2) When adding support for additional SoCs we may add new index to the
driver. New SoC may get sparsely populated index lists and old ones
will omit the recently added index.

>> +/*
>> + *   MD              EXTAL           PLL0    PLL1    PLL2    PLL3    PLL4
>> + * 14 13 19 17       (MHz)           *1      *1      *1
>> + *-------------------------------------------------------------------
>> + * 0  0  0  0        16.66 x 1       x180/2  x192/2  x144/2  x192    x144
>> + * 0  0  0  1        16.66 x 1       x180/2  x192/2  x144/2  x128    x144
>> + * 0  0  1  0        Prohibited setting
>> + * 0  0  1  1        16.66 x 1       x180/2  x192/2  x144/2  x192    x144
>> + * 0  1  0  0        20    x 1       x150/2  x156/2  x120/2  x156    x120
>> + * 0  1  0  1        20    x 1       x150/2  x156/2  x120/2  x106    x120
>> + * 0  1  1  0        Prohibited setting
>> + * 0  1  1  1        20    x 1       x150/2  x156/2  x120/2  x156    x120
>> + * 1  0  0  0        25    x 1       x120/2  x128/2  x96/2   x128    x96
>> + * 1  0  0  1        25    x 1       x120/2  x128/2  x96/2   x84     x96
>> + * 1  0  1  0        Prohibited setting
>> + * 1  0  1  1        25    x 1       x120/2  x128/2  x96/2   x128    x96
>> + * 1  1  0  0        33.33 / 2       x180/2  x192/2  x144/2  x192    x144
>> + * 1  1  0  1        33.33 / 2       x180/2  x192/2  x144/2  x128    x144
>> + * 1  1  1  0        Prohibited setting
>> + * 1  1  1  1        33.33 / 2       x180/2  x192/2  x144/2  x192    x144
>> + *
>> + * *1 : datasheet indicates VCO output (PLLx = VCO/2)
>
> As explained in a separate e-mail there's a few clocks on R8A7795 that derive
> directly from PLL1 VCO. I thus wonder whether we shouldn't expose the PLL1
> clock as the VCO output and create VCO/2 using a fixed factor clock in DT.

Do you think that would reduce complexity or simplify the code? If so
I think we should do it. Otherwise I think it makes sense to simply
follow the data sheet.

>> + */
>> +#define CPG_PLL_CONFIG_INDEX(md)     ((((md) & BIT(14)) >> 11) | \
>> +                                      (((md) & BIT(13)) >> 11) | \
>> +                                      (((md) & BIT(19)) >> 18) | \
>> +                                      (((md) & BIT(17)) >> 17))
>> +struct cpg_pll_config {
>> +     unsigned int extal_div;
>> +     unsigned int pll1_mult;
>> +     unsigned int pll3_mult;
>> +     unsigned int pll4_mult;
>> +};
>> +
>> +static const struct cpg_pll_config cpg_pll_configs[16] __initconst = {
>> +/* EXTAL div PLL1    PLL3    PLL4 */
>> +     { 1,    192,    192,    144, },
>> +     { 1,    192,    128,    144, },
>> +     { 0,    0,      0,      0,   }, /* Prohibited setting */
>> +     { 1,    192,    192,    144, },
>> +     { 1,    156,    156,    120, },
>> +     { 1,    156,    106,    120, },
>> +     { 0,    0,      0,      0,   }, /* Prohibited setting */
>> +     { 1,    156,    156,    120, },
>> +     { 1,    128,    128,    96,  },
>> +     { 1,    128,    84,     96,  },
>> +     { 0,    0,      0,      0,   }, /* Prohibited setting */
>> +     { 1,    128,    128,    96,  },
>> +     { 2,    192,    192,    144, },
>> +     { 2,    192,    128,    144, },
>> +     { 0,    0,      0,      0,   }, /* Prohibited setting */
>> +     { 2,    192,    192,    144, },
>> +};
>> +
>> +/* ------------------------------------------------------------------------
>> + * Initialization
>> + */
>> +
>> +static struct clk * __init
>> +rcar_gen3_cpg_register_clock(struct device_node *np, struct rcar_gen3_cpg
>> *cpg,
>> +                          const struct cpg_pll_config *config,
>> +                          unsigned int gen3_clk)
>> +{
>> +     const char *parent_name = rcar_gen3_clk_names[RCAR_GEN3_CLK_MAIN];
>> +     unsigned int mult = 1;
>> +     unsigned int div = 1;
>> +     u32 value;
>> +
>> +     switch (gen3_clk) {
>> +     case RCAR_GEN3_CLK_MAIN:
>> +             parent_name = of_clk_get_parent_name(np, 0);
>> +             div = config->extal_div;
>> +             break;
>> +     case RCAR_GEN3_CLK_PLL0:
>> +             /* PLL0 is a configurable multiplier clock. Register it as a
>> +              * fixed factor clock for now as there's no generic multiplier
>> +              * clock implementation and we currently have no need to change
>> +              * the multiplier value.
>> +              */
>> +             value = rcar_clk_readl(cpg, CPG_PLL0CR);
>> +             mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
>
> I'd find 0x3f more readable than (1 << 7) - 1 but that might just be me. Same
> comment for PLL2.

I agree.

>> +             break;
>> +     case RCAR_GEN3_CLK_PLL1:
>> +             mult = config->pll1_mult / 2;
>> +             break;
>> +     case RCAR_GEN3_CLK_PLL2:
>> +             /* PLL2 is a configurable multiplier clock. Register it as a
>> +              * fixed factor clock for now as there's no generic multiplier
>> +              * clock implementation and we currently have no need to change
>> +              * the multiplier value.
>> +              */
>> +             value = rcar_clk_readl(cpg, CPG_PLL2CR);
>> +             mult = ((value >> 24) & ((1 << 7) - 1)) + 1;
>> +             break;
>> +     case RCAR_GEN3_CLK_PLL3:
>> +             mult = config->pll3_mult;
>> +             break;
>> +     case RCAR_GEN3_CLK_PLL4:
>> +             mult = config->pll4_mult;
>> +             break;
>> +     default:
>> +             return ERR_PTR(-EINVAL);
>> +     }
>> +
>> +     return clk_register_fixed_factor(NULL, rcar_gen3_clk_names[gen3_clk],
>> +                                      parent_name, 0, mult, div);
>> +}
>> +
>> +static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
>> +{
>> +     const struct cpg_pll_config *config;
>> +     struct rcar_gen3_cpg *cpg;
>> +     u32 cpg_mode;
>> +     unsigned int i;
>> +     int num_clks;
>> +
>> +     cpg_mode = rcar_gen3_read_mode_pins();
>> +
>> +     num_clks = of_property_count_u32_elems(np, "clock-indices");
>> +     if (num_clks < 0) {
>> +             pr_err("%s: failed to count clocks\n", __func__);
>> +             return;
>> +     }
>> +
>> +     cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
>> +     if (!cpg)
>> +             return;
>> +
>> +     spin_lock_init(&cpg->lock);
>
> The spin lock is never used. I'd drop it for now, and add it back later
> when/if needed.

Good point!

>> +     cpg->data.clks = cpg->clks;
>> +     cpg->data.clk_num = num_clks;
>> +
>> +     cpg->reg = of_iomap(np, 0);
>> +     if (WARN_ON(cpg->reg = NULL))
>> +             return;
>> +
>> +     config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
>> +     if (!config->extal_div) {
>> +             pr_err("%s: Prohibited setting (cpg_mode=0x%x)\n",
>> +                    __func__, cpg_mode);
>> +             return;
>> +     }
>> +
>> +     for (i = 0; i < num_clks; ++i) {
>> +             struct clk *clk;
>> +             u32 idx;
>> +             int ret;
>> +
>> +             ret = of_property_read_u32_index(np, "clock-indices", i, &idx);
>> +             if (ret < 0)
>> +                     break;
>> +
>> +             clk = rcar_gen3_cpg_register_clock(np, cpg, config, idx);
>> +             if (IS_ERR(clk))
>> +                     pr_err("%s: failed to register %s %u clock (%ld)\n",
>> +                            __func__, np->name, idx, PTR_ERR(clk));
>> +             else
>> +                     cpg->data.clks[idx] = clk;
>> +     }
>> +
>> +     of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
>> +}
>> +CLK_OF_DECLARE(rcar_gen3_cpg_clks, "renesas,rcar-gen3-cpg-clocks",
>> +            rcar_gen3_cpg_clocks_init);

Thanks for your comments!!

/ magnus

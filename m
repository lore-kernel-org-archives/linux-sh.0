From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 08:45:30 +0000
Subject: Re: [PATCH v4 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CAMuHMdUR7gYXoJMRGXdcReZ4fX+2SQDvTsK8Jny67GcW995_9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150829091323.28546.28287.sendpatchset@little-apple>
	<20150829091346.28546.42552.sendpatchset@little-apple>
In-Reply-To: <20150829091346.28546.42552.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Sat, Aug 29, 2015 at 11:13 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> This patch adds initial CPG support for R-Car Generation 3 and in
> particular the R8A7795 SoC.
>
> The R-Car Gen3 clock hardware has a register write protection feature that
> needs to be shared between the CPG function needs to be shared between
> the CPG and MSTP hardware somehow. So far this feature is simply ignored.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
>  - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
>  - Major things like syscon and driver model require more discussion.
>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.

Thanks for the updates!

>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
>  - Reworked driver to rely on clock index instead of strings.

I had completely missed this part in the previous version...

>  - Dropped use of "clock-output-names".


> --- /dev/null
> +++ work/drivers/clk/shmobile/clk-rcar-gen3.c   2015-08-29 16:30:59.032366518 +0900
> @@ -0,0 +1,249 @@

> +#define RCAR_GEN3_CLK_MAIN     0
> +#define RCAR_GEN3_CLK_PLL0     1
> +#define RCAR_GEN3_CLK_PLL1     2
> +#define RCAR_GEN3_CLK_PLL2     3
> +#define RCAR_GEN3_CLK_PLL3     4
> +#define RCAR_GEN3_CLK_PLL4     5

These values are intimately tied to R8A7795_CLK_* in
include/dt-bindings/clock/r8a7795-clock.h.
Perhaps we can use these instead?

If we ever have a Gen3 SoC with more clocks, we have to update
this anyway.

> +struct rcar_gen3_cpg {
> +       struct clk_onecell_data data;
> +       spinlock_t lock;
> +       void __iomem *reg;

If you add the clocks here, you don't have to allocate them separately
later:

        struct clk clocks[...];

> +static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
> +{
> +       const struct cpg_pll_config *config;
> +       struct rcar_gen3_cpg *cpg;
> +       struct clk **clks;
> +       u32 cpg_mode;
> +       unsigned int i;
> +       int num_clks;
> +
> +       cpg_mode = rcar_gen3_read_mode_pins();
> +
> +       num_clks = of_property_count_strings(np, "clock-indices");
> +       if (num_clks < 0) {
> +               pr_err("%s: failed to count clocks\n", __func__);
> +               return;
> +       }
> +
> +       cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> +       clks = kcalloc(num_clks, sizeof(*clks), GFP_KERNEL);

I.e. these 2 allocation can be combined by embedding the struct clks in
struct rcar_gen3_cpg...

> +       if (cpg = NULL || clks = NULL) {
> +               kfree(cpg);
> +               kfree(clks);

... and there's no longer a need to kfree() anything.

> +               pr_err("%s: failed to allocate cpg\n", __func__);

There's no need to print an error on allocation failures. The system
will scream anyway (if there's already a console ;-).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

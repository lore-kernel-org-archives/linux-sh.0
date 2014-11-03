From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Nov 2014 10:07:27 +0000
Subject: Re: [PATCH 1/2] clk: shmobile: div6: support selectable-input clocks
Message-Id: <CAMuHMdU6+v+R83KMP4MA1PQwZnoU+yHyQPBc4vNXO1Uff2+beQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1414767696-23211-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414767696-23211-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Mike Turquette <mturquette@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulrich,

On Fri, Oct 31, 2014 at 4:01 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Support for setting the parent at initialization time based on the current
> hardware configuration in DIV6 clocks with selectable parents as found in
> the r8a73a4, r8a7740, sh73a0, and other SoCs.

Thanks for your patch!

> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -32,6 +32,9 @@ struct div6_clock {
>         struct clk_hw hw;
>         void __iomem *reg;
>         unsigned int div;
> +       int src_shift;
> +       int src_width;

unsigned int or u32 (both)

> +       u8 *parents;
>  };
>
>  #define to_div6_clock(_hw) container_of(_hw, struct div6_clock, hw)

> +static unsigned char cpg_div6_clock_get_parent(struct clk_hw *hw)

Please return u8, cfr. clk_ops.get_parent()

> +{
> +       struct div6_clock *clock = to_div6_clock(hw);
> +       u8 hw_index;
> +       int i;

unsigned int

> +       if (clock->src_width = 0)
> +               return 0;
> +
> +       hw_index = (clk_readl(clock->reg) >> clock->src_shift) &
> +                  (BIT(clock->src_width) - 1);
> +       for (i = 0; i < hw->init->num_parents; i++) {

Is hw->init still valid here?
I believe it's a pointer to local stack variable "struct clk_init_data init"
in cpg_div6_clock_init(), which was never copied?

Use __clk_get_num_parents(hw->clk) instead, cfr. clk-mux?

> +               if (clock->parents[i] = hw_index)
> +                       return i;
> +       }
> +
> +       pr_err("%s: %s DIV6 clock set to invalid parent %d\n",

%u for u8

> +              __func__, hw->init->name, hw_index);
> +       return 0;
> +}

It's a bit unfortunate that clk_ops.get_parent() cannot return an error code,
as u8 is positive. Perhaps it should return int instead?

However, as clk_mux_get_parent() does return -EINVAL if the clock
can't be found, perhaps it's best to mimic that behavior?

__clk_init_parent() calls clk_get_parent_by_index(), which does check
if the index fits within the allowed range.

__clk_init() uses the returned value to index parent_names[] without any
checking. Oops...

Mike?

> +static int cpg_div6_clock_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct div6_clock *clock = to_div6_clock(hw);
> +       u8 hw_index;
> +       u32 mask;
> +
> +       if (index >= hw->init->num_parents)

Is hw->init still valid here?
Use __clk_get_num_parents(hw->clk) instead, cfr. clk-mux?

> +               return -EINVAL;
> +
> +       mask = ~((BIT(clock->src_width) - 1) << clock->src_shift);
> +       hw_index = clock->parents[index];
> +
> +       clk_writel((clk_readl(clock->reg) & mask) |
> +               (hw_index << clock->src_shift), clock->reg);
>
>         return 0;
>  }

> @@ -115,12 +164,17 @@ static const struct clk_ops cpg_div6_clock_ops = {
>
>  static void __init cpg_div6_clock_init(struct device_node *np)
>  {
> +       const char **parent_names;
>         struct clk_init_data init;
>         struct div6_clock *clock;
> -       const char *parent_name;
>         const char *name;
>         struct clk *clk;
> +       int valid_parents;
> +       int num_parents;

unsigned int (both)

> +       u32 src_shift;
> +       u32 src_width;
>         int ret;
> +       int i;

unsigned int

> @@ -129,6 +183,24 @@ static void __init cpg_div6_clock_init(struct device_node *np)
>                 return;
>         }
>
> +       num_parents = of_clk_get_parent_count(np);
> +       if (num_parents < 1) {
> +               pr_err("%s: no parent found for %s DIV6 clock\n",
> +                      __func__, np->name);
> +               return;
> +       }
> +
> +       clock->parents = kmalloc_array(num_parents, sizeof(*clock->parents),
> +               GFP_KERNEL);
> +       parent_names = kmalloc_array(num_parents, sizeof(*parent_names),
> +                               GFP_KERNEL);
> +

Please drop the blank line above.

> +       if (!parent_names) {
> +               pr_err("%s: failed to allocate %s parent name list\n",
> +                      __func__, np->name);

There's no need to print an error in case of allocation failures.

> +               return;
> +       }
> +
>         /* Remap the clock register and read the divisor. Disabling the
>          * clock overwrites the divisor, so we need to cache its value for the
>          * enable operation.
> @@ -150,19 +222,38 @@ static void __init cpg_div6_clock_init(struct device_node *np)
>                 goto error;
>         }
>
> -       parent_name = of_clk_get_parent_name(np, 0);
> -       if (parent_name = NULL) {
> -               pr_err("%s: failed to get %s DIV6 clock parent name\n",
> -                      __func__, np->name);
> -               goto error;
> +
> +       for (i = 0, valid_parents = 0; i < num_parents; i++) {
> +               const char *name = of_clk_get_parent_name(np, i);
> +
> +               if (name) {
> +                       parent_names[valid_parents] = name;
> +                       clock->parents[valid_parents] = i;
> +                       valid_parents++;
> +               }
> +       }
> +
> +       if (!of_property_read_u32(np, "renesas,src-shift", &src_shift)) {
> +               if (!of_property_read_u32(np, "renesas,src-width",
> +                                       &src_width)) {
> +                       clock->src_shift = src_shift;
> +                       clock->src_width = src_width;
> +               } else {
> +                       pr_err("%s: renesas,src-shift without renesas,src-width in %s\n",
> +                              __func__, np->name);
> +                       goto error;
> +               }
> +       } else {
> +               clock->src_shift = clock->src_width = 0;
>         }

The above construct does allow renesas,src-width without renesas,src-shift.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

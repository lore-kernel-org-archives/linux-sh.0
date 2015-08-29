From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 29 Aug 2015 10:44:11 +0000
Subject: Re: [PATCH v4 05/05] clk: shmobile: Make MSTP clock-output-names optional
Message-Id: <CAMuHMdU0SRV_F4Tk76AkEnVi=JHhxJReCQ_FVQkw2g_xiBtQPA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150829091323.28546.28287.sendpatchset@little-apple>
	<20150829091418.28546.8569.sendpatchset@little-apple>
In-Reply-To: <20150829091418.28546.8569.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Sat, Aug 29, 2015 at 11:14 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/drivers/clk/shmobile/clk-mstp.c
> +++ work/drivers/clk/shmobile/clk-mstp.c        2015-08-29 18:01:00.662366518 +0900
> @@ -199,26 +199,29 @@ static void __init cpg_mstp_clocks_init(
>         for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
>                 const char *parent_name;
>                 const char *name;
> +               bool allocated_name;

If you make it "const char *allocated_name = NULL;" ...

>                 u32 clkidx;
>                 int ret;
>
> -               /* Skip clocks with no name. */
> -               ret = of_property_read_string_index(np, "clock-output-names",
> -                                                   i, &name);
> -               if (ret < 0 || strlen(name) = 0)
> -                       continue;
> -
>                 parent_name = of_clk_get_parent_name(np, i);
>                 ret = of_property_read_u32_index(np, idxname, i, &clkidx);
>                 if (parent_name = NULL || ret < 0)
>                         break;
>
>                 if (clkidx >= MSTP_MAX_CLOCKS) {
> -                       pr_err("%s: invalid clock %s %s index %u)\n",
> -                              __func__, np->name, name, clkidx);
> +                       pr_err("%s: invalid clock %s index %u)\n",
> +                              __func__, np->name, clkidx);
>                         continue;
>                 }
>
> +               if (of_property_read_string_index(np, "clock-output-names",
> +                                                 i, &name) = 0) {
> +                       allocated_name = false;

... you can drop this branch...

> +               } else {
> +                       name = kasprintf(GFP_KERNEL, "%s.%u", np->name, clkidx);
> +                       allocated_name = true;

... and use "allocated_name = name = kasprintf(...);"

> +               }
> +
>                 clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
>                                                        clkidx, group);
>                 if (!IS_ERR(clks[clkidx])) {
> @@ -231,12 +234,19 @@ static void __init cpg_mstp_clocks_init(
>                          *
>                          * FIXME: Remove this when all devices that require a
>                          * clock will be instantiated from DT.
> +                        *
> +                        * We currently register clkdev only when the DT
> +                        * property clock-output-names is present.
>                          */
> -                       clk_register_clkdev(clks[clkidx], name, NULL);
> +                       if (!allocated_name)
> +                               clk_register_clkdev(clks[clkidx], name, NULL);
>                 } else {
>                         pr_err("%s: failed to register %s %s clock (%ld)\n",
>                                __func__, np->name, name, PTR_ERR(clks[clkidx]));
>                 }
> +
> +               if (allocated_name)
> +                       kfree(name);

... and kfree(allocated_name) unconditionally.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

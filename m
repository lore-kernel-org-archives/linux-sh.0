From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 15 Feb 2014 13:28:10 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: koelsch-reference: Add DU device
Message-Id: <CAMuHMdWDUj23J8cKpQ7o3H30MBaMmA+7ogBEveL0j=RSXMwhUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392398441-9560-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392398441-9560-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 14, 2014 at 6:20 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> static void __init koelsch_add_standard_devices(void)
>  {
>  #ifdef CONFIG_COMMON_CLK
>         /*
> -        * This is a really crude hack to provide clkdev support to the SCIF
> -        * and CMT devices until they get moved to DT.
> +        * This is a really crude hack to provide clkdev support to the CMT and
> +        * DU devices until they get moved to DT.
>          */
> -       static const char * const scif_names[] = {
> -               "scifa0", "scifa1", "scifb0", "scifb1", "scifb2", "scifa2",
> -               "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scifa3",
> -               "scifa4", "scifa5",
> +       static const struct clk_name {
> +               const char *clk;
> +               const char *con_id;
> +               const char *dev_id;
> +       } clk_names[] = {
> +               { "cmt0", NULL, "sh_cmt.0" },
> +               { "scifa0", NULL, "sh-sci.0" },
> +               { "scifa1", NULL, "sh-sci.1" },
> +               { "scifb0", NULL, "sh-sci.2" },
> +               { "scifb1", NULL, "sh-sci.3" },
> +               { "scifb2", NULL, "sh-sci.4" },
> +               { "scifa2", NULL, "sh-sci.5" },
> +               { "scif0", NULL, "sh-sci.6" },
> +               { "scif1", NULL, "sh-sci.7" },
> +               { "scif2", NULL, "sh-sci.8" },
> +               { "scif3", NULL, "sh-sci.9" },
> +               { "scif4", NULL, "sh-sci.10" },
> +               { "scif5", NULL, "sh-sci.11" },
> +               { "scifa3", NULL, "sh-sci.12" },
> +               { "scifa4", NULL, "sh-sci.13" },
> +               { "scifa5", NULL, "sh-sci.14" },
> +               { "du0", "du.0", "rcar-du-r8a7791" },
> +               { "du1", "du.1", "rcar-du-r8a7791" },
> +               { "lvds0", "lvds.0", "rcar-du-r8a7791" },
>         };
>         struct clk *clk;
>         unsigned int i;
>
> -       for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
> -               clk = clk_get(NULL, scif_names[i]);
> +       for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
> +               clk = clk_get(NULL, clk_names[i].clk);
>                 if (!IS_ERR(clk)) {
> -                       clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
> +                       clk_register_clkdev(clk, clk_names[i].con_id,
> +                                           clk_names[i].dev_id);
>                         clk_put(clk);
>                 }
>         }
> -
> -       clk = clk_get(NULL, "cmt0");
> -       if (!IS_ERR(clk)) {
> -               clk_register_clkdev(clk, NULL, "sh_cmt.0");
> -               clk_put(clk);
> -       }

You may want to split off the refactoring of the clock registration,
so it's more
obvious that you're just adding the few du* entries here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 01 Apr 2015 08:48:58 +0000
Subject: Re: [PATCH] clk: shmobile: r8a7779: check return of of_property_read_string_index()
Message-Id: <CAMuHMdWV3oNTPTq0RwMugLGoz62T=1Acn1LWbJb4WobfiCcG+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pp7o2xqg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pp7o2xqg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>

Hi Morimoto-san,

On Wed, Apr 1, 2015 at 8:02 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch indicates error message if return value of
> of_property_read_string_index() was not zero.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/clk/shmobile/clk-r8a7779.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
> index 652ecac..af439b2 100644
> --- a/drivers/clk/shmobile/clk-r8a7779.c
> +++ b/drivers/clk/shmobile/clk-r8a7779.c
> @@ -155,8 +155,10 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
>                 const char *name;
>                 struct clk *clk;
>
> -               of_property_read_string_index(np, "clock-output-names", i,
> -                                             &name);
> +               if (of_property_read_string_index(np, "clock-output-names", i,
> +                                                 &name))
> +                       pr_err("%s: can't get clock-output-names (%d)\n",
> +                              __func__, i);

Shouldn't you add a "continue;" here, too?

Anyway, I don't think this can fail, as
i < of_property_count_strings(np, "clock-output-names");

>                 clk = r8a7779_cpg_register_clock(np, cpg, config,
>                                                  plla_mult, name);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

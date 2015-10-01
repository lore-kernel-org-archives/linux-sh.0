From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 01 Oct 2015 15:28:29 +0000
Subject: Re: [PATCH v8 03/05] clk: shmobile: Add Renesas Module Standby and Reset driver
Message-Id: <CAMuHMdV=kKS+R4SFHrmZL5pntpdAP1tR1kRyKKsW0fD1nVrj1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151001143717.20618.26365.sendpatchset@little-apple>
	<20151001143748.20618.7279.sendpatchset@little-apple>
In-Reply-To: <20151001143748.20618.7279.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Thu, Oct 1, 2015 at 4:37 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Add a driver for the Renesas Module Standby and Software Reset module
> found in several Renesas SoCs.
>
> This driver is based on the existing R-Car MSTP driver, and is intended
> to replace it.
> The existing driver is limited to Module Standby, and has bindings that
> are difficult to extend to more register sets for e.g. reset control.
>
> TODO:
>   - Implement module reset handling,
>   - Write binding documentation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I'm happy you like it!

> ---
>
>  Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
>  - New patch, took local v3 patch from Geert and removed r8a7791 references.

You forgot one reference indicated below.

>  drivers/clk/shmobile/clk-mssr.c |  392 +++++++++++++++++++++++++++++++++++++++
>  include/linux/clk/shmobile.h    |    2
>  2 files changed, 394 insertions(+)
>
> --- /dev/null
> +++ work/drivers/clk/shmobile/clk-mssr.c        2015-10-01 18:38:50.320513000 +0900
> @@ -0,0 +1,392 @@

> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +static int cpg_mssr_attach_dev(struct generic_pm_domain *domain,
> +                              struct device *dev)
> +{
> +       struct device_node *np = dev->of_node;
> +       struct of_phandle_args clkspec;
> +       struct clk *clk;
> +       int i = 0;
> +       int error;
> +
> +       while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
> +                                          &clkspec)) {
> +               if (of_device_is_compatible(clkspec.np,
> +                                           "renesas,r8a7791-cpg-mssr"))

renesas,r8a7795-cpg-mssr

Else it won't manage the module clocks, and things may fail miserably.

> +                       goto found;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Sep 2015 14:23:26 +0000
Subject: Re: [PATCH v5 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CAMuHMdWPryV6OowY=fcB4uwyCZE50ZJOScC=-iP_6K029vBbCw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831124842.31057.54534.sendpatchset@little-apple>
	<20150831124904.31057.19757.sendpatchset@little-apple>
In-Reply-To: <20150831124904.31057.19757.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Mon, Aug 31, 2015 at 2:49 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- /dev/null
> +++ work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt       2015-08-31 15:49:10.000000000 +0900
> @@ -0,0 +1,32 @@

> +       cpg_clocks: cpg_clocks@e6150000 {
> +               compatible = "renesas,r8a7795-cpg-clocks",
> +                            "renesas,rcar-gen3-cpg-clocks";
> +               reg = <0 0xe6150000 0 0x1000>;
> +               clocks = <&extal_clk>;
> +               #clock-cells = <1>;
> +                clock-indices = <
> +                             R8A7795_CLK_MAIN R8A7795_CLK_PLL0
> +                             R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
> +                             R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
> +                >;

The new "clock-indices" hunk uses spaces insteads of TABs for indentation.

> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

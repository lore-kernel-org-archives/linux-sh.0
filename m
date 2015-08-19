From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2015 16:53:55 +0000
Subject: Re: [PATCH 05/16 v5][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <CAMuHMdWytgom7OBRAU+Ngo1JpzjZitE=9AskYwQ96HULW7Tokw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871tffeqps.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871tffeqps.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Aug 7, 2015 at 5:16 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -0,0 +1,93 @@

> +                       p_clk: p_clk {
> +                               compatible = "fixed-factor-clock";
> +                               clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
> +                               #clock-cells = <0>;
> +                               clock-div = <24>;
> +                               clock-mult = <1>;
> +                               clock-output-names = "p";
> +                       };

I can't find a "p" clock. Shouldn't that be one of the "sXdY" clocks?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

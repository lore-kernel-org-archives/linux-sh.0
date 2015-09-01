From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Sep 2015 07:29:05 +0000
Subject: Re: [PATCH 1/3] arm64: dts: r8a7795: add GPIO clocks
Message-Id: <CAMuHMdVR01+kF3DZj3Fd15oYzL++=0zWXkVjWaYB1nFF3Neokg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Uli,

On Mon, Aug 31, 2015 at 5:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -70,6 +70,14 @@
>                         #clock-cells = <1>;
>                         ranges;
>
> +                       cp_clk: cp_clk {

In the absence of "clock-output-names", the node should be called "cp",
to avoid the clock name having a "_clk" suffix.

> +                               compatible = "fixed-factor-clock";
> +                               clocks = <&extal_clk>;
> +                               #clock-cells = <0>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
>                         zt_clk: zt {
>                                 compatible = "fixed-factor-clock";
>                                 clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
> @@ -274,6 +282,22 @@
>                                         #clock-cells = <1>;
>                                         clock-indices = <R8A7795_CLK_SCIF2>;
>                                 };
> +
> +                               mstp9_clks: mstp9_clks@e6150994 {

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

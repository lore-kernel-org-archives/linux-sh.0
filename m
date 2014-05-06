From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 May 2014 19:30:59 +0000
Subject: Re: [PATCH 1/6] ARM: shmobile: sh73a0: Common clock framework DT description
Message-Id: <CAMuHMdUf0xLN7CNyKHbp-dvQEncw4Faf+dhwgKDWPVrNbAyy6A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399386233-11928-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1399386233-11928-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, May 6, 2014 at 4:23 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> +               extal2_clk: extal2_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       /* This value must be overriden in the board dts. */
> +                       clock-frequency = <0>;

I know we have this dummy value for R-Car Gen2 too, but shouldn't it just
be left out of the .dtsi?

> +                       clock-output-names = "extal2";
> +               };
> +               extcki_clk: extcki_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       /* This value must be overriden in the board dts. */
> +                       clock-frequency = <0>;

Same here.

> +                       clock-output-names = "extcki";
> +               };

> +               zb1_clk: zb1_clk@e6150010 {
> +                       compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
> +                       reg = <0xe6150010 4>;
> +                       clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>;
> +                       renesas,src-shift = <7>;
> +                       renesas,src-width = <1>;
> +                       renesas,clock_enable_on_init;   /* ? */

"/* ? */"?

> +                       #clock-cells = <0>;
> +                       clock-output-names = "zb1";
> +               };

> +               mstp3_clks: mstp3_clks@e615013c {
> +                       compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0xe615013c 4>, <0xe6150048 4>;
> +                       clocks = <&sub_clk>, <&extalr_clk>,
> +                                <&cpg_clocks SH73A0_CLK_HP>, <&sub_clk>,
> +                                <&cpg_clocks SH73A0_CLK_HP>,
> +                                <&cpg_clocks SH73A0_CLK_HP>, <&flctl_clk>,
> +                                <&sdhi0_clk>, <&sdhi1_clk>,
> +                                <&cpg_clocks SH73A0_CLK_HP>, <&sdhi2_clk>,
> +                                <&main_div2_clk>, <&main_div2_clk>,
> +                                <&main_div2_clk>, <&main_div2_clk>,
> +                                <&main_div2_clk>;
> +                       #clock-cells = <1>;
> +                       renesas,clock-indices = <
> +                               SH73A0_CLK_SCIFA6 SH73A0_CLK_CMT1
> +                               SH73A0_CLK_FSI SH73A0_CLK_IRDA
> +                               SH73A0_CLK_IIC1 SH73A0_CLK_USB SH73A0_CLK_FLCTL
> +                               SH73A0_CLK_SDHI0 SH73A0_CLK_SDHI1
> +                               SH73A0_CLK_MMCIF0 SH73A0_CLK_SDHI2
> +                               SH73A0_CLK_TPU0 SH73A0_CLK_TPU1
> +                               SH73A0_CLK_TPU2 SH73A0_CLK_TPU3
> +                               SH73A0_CLK_TPU4
> +                       >;
> +                       clock-output-names > +                               "scifa6", "cmt1", "fsi", "irda", "iic1",
> +                               "usb", "flctl", "sdhi0", "sdhi1", "mmcif0", "sdhi2",
> +                               "tpu0", "tpu1", "tpu2", "tpu3";
> +               };

"tpu4" is missing at the end.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvald

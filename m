From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 10:58:32 +0000
Subject: Re: [PATCH 03/11] ARM: shmobile: r8a7778: Common clock framework DT description
Message-Id: <CAMuHMdXv-+PP1iZNA316MYxpFv1rJR-m9zDgtYKK+HcZG8DXHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wed, Jan 21, 2015 at 5:20 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Declares all r8a7778 clocks supported by the legacy clock framework,
> plus tmu2.

Thanks!

> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi

> +               mstp0_clks: mstp0_clks@ffc80030 {
> +                       compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0xffc80030 4>;
> +                       clocks = <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_S>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7778_CLK_I2C0 R8A7778_CLK_I2C1
> +                               R8A7778_CLK_I2C2 R8A7778_CLK_I2C3
> +                               R8A7778_CLK_SCIF0 R8A7778_CLK_SCIF1
> +                               R8A7778_CLK_SCIF2 R8A7778_CLK_SCIF3
> +                               R8A7778_CLK_SCIF4 R8A7778_CLK_SCIF5
> +                               R8A7778_CLK_TMU0 R8A7778_CLK_TMU1
> +                               R8A7778_CLK_TMU2 R8A7778_CLK_SSI0
> +                               R8A7778_CLK_SSI1 R8A7778_CLK_SSI2
> +                               R8A7778_CLK_SSI3 R8A7778_CLK_SRU
> +                               R8A7778_CLK_HSPI
> +                       >;
> +                       clock-output-names > +                               "i2c0", "i2c1", "i2c2", "i2c3", "scif0",
> +                               "scif1", "scif2", "scif3", "scif4", "scif5",
> +                               "tmu0", "tmu1", "tmu2", "ssi0", "ssi1",
> +                               "ssi2", "ssi3", "sru", "hspi";

On r8a7790, we use "ssi%u", on r8a7791, we use "ssi.%u"?

> +               mstp3_clks: mstp3_clks@ffc8003c {
> +                       compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0xffc8003c 4>;
> +                       clocks = <&s4_clk>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7778_CLK_MMC R8A7778_CLK_SDHI0
> +                               R8A7778_CLK_SDHI1 R8A7778_CLK_SDHI2
> +                               R8A7778_CLK_SSI4 R8A7778_CLK_SSI5
> +                               R8A7778_CLK_SSI6 R8A7778_CLK_SSI7
> +                               R8A7778_CLK_SSI8
> +                       >;
> +                       clock-output-names > +                               "mmc", "sdhi0", "sdhi1", "sdhi2", "ssi4",
> +                               "ssi5", "ssi6", "ssi7", "ssi8";

On r8a7790, we use "ssi%u", on r8a7791, we use "ssi.%u"?

> +               mstp5_clks: mstp5_clks@ffc80054 {
> +                       compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0xffc80054 4>;
> +                       clocks = <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>,
> +                                <&cpg_clocks R8A7778_CLK_P>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7778_CLK_SCU0 R8A7778_CLK_SCU1
> +                               R8A7778_CLK_SCU2 R8A7778_CLK_SCU3
> +                               R8A7778_CLK_SCU4 R8A7778_CLK_SCU5
> +                               R8A7778_CLK_SCU6 R8A7778_CLK_SCU7
> +                               R8A7778_CLK_SCU8

R8A7778_CLK_SRU_SRCx

> +                       >;
> +                       clock-output-names > +                               "scu0", "scu1", "scu2", "scu3", "scu4",
> +                               "scu5", "scu6", "scu7", "scu8";

On r8a7790, we use "scu-src%u", on r8a7791, we use "src.%u"?

Shall we use "sru-src%u" or "src.%u" here?


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

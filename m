From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Sep 2015 12:19:34 +0000
Subject: Re: ARM64: renesas: r8a7795: Add graphics-related MSTP clocks
Message-Id: <CAMuHMdUReY_-UgL4QkTErF9byaEy-sTAtH_zqTbZRVk+n5vPBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

http://git.linuxtv.org/cgit.cgi/pinchartl/media.git/commit/?h=vsp1-kms-gen3-20150929&id12906b34fe88e4eceface078af9cd6b2fa0955e:
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index ed192d480e355e11..bcba6b4b86f8e24f 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -413,6 +413,41 @@
>                                       clock-indices = <R8A7795_CLK_SCIF2>;
>                               };
>
> +                             mstp6_clks: mstp6@e61501c0 {
> +                                     compatible = "renesas,r8a7795-mstp-clocks",
> +                                                  "renesas,cpg-mstp-clocks";
> +                                     reg = <0 0xe6150148 0 4>, <0 0xe61501c0 0 4>;
> +                                     clocks =  <
> +                                             &s2d1_clk &s2d1_clk &s2d1_clk &s2d1_clk
> +                                             &s2d1_clk &s2d1_clk &s2d1_clk &s2d1_clk
> +                                             &s2d1_clk
> +                                     >;
> +                                     #clock-cells = <1>;
> +                                     clock-indices = <
> +                                             R8A7795_CLK_VSPD3 R8A7795_CLK_VSPD2
> +                                             R8A7795_CLK_VSPD1 R8A7795_CLK_VSPD0
> +                                             R8A7795_CLK_VSPBC R8A7795_CLK_VSPBD
> +                                             R8A7795_CLK_VSPI2 R8A7795_CLK_VSPI1
> +                                             R8A7795_CLK_VSPI0
> +                                     >;
> +                             };
> +
> +                             mstp7_clks: mstp7@e615014c {
> +                                     compatible = "renesas,r8a7795-mstp-clocks",
> +                                                  "renesas,cpg-mstp-clocks";
> +                                     reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> +                                     clocks =  <&s2d1_clk>, <&s2d1_clk>, <&s2d1_clk>,
> +                                               <&s2d1_clk>, <&s2d1_clk>, <&s2d1_clk>,
> +                                               <&lvds_clk>, <&hdmi_clk>, <&hdmi_clk>;

This property counts 9 parent clocks...

> +                                     #clock-cells = <1>;
> +                                     clock-indices = <
> +                                             R8A7795_CLK_DU3 R8A7795_CLK_DU2
> +                                             R8A7795_CLK_DU1 R8A7795_CLK_DU0
> +                                             R8A7795_CLK_LVDS R8A7795_CLK_HDMI1
> +                                             R8A7795_CLK_HDMI0

... while this property counts only 7 indices.

I guess the first two parent clocks should be removed?

> +                                     >;
> +                             };

-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

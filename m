From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Sep 2015 08:57:50 +0000
Subject: Re: [PATCH 03/14][RFC] arm64: renesas: r8a7795: add MSTP10 support
Message-Id: <CAMuHMdVaLOg_Y+ipVanyz-U7KbfkxGuPJMbZXQvXv5ni5yd-Fg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvwun3zh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mvwun3zh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Sep 10, 2015 at 9:15 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> It is including SSI/SRC/CTU/MIX/DVC
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I could not verify the parents (s3d4) of the SSI_ALL and SCU_ALL clocks.
Do you have a pointer?

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 39 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h | 26 +++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 969116d..f27b8d2 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -429,6 +429,45 @@
>                                                 R8A7795_CLK_I2C0
>                                         >;
>                                 };
> +
> +                               mstp10_clks: mstp10_clks@e6150998 {
> +                                       compatible = "renesas,r8a7795-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                                       reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> +                                       #clock-cells = <1>;
> +                                       clocks = <&s3d4_clk>,
> +                                               <&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
> +                                               <&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
> +                                               <&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
> +                                               <&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
> +                                               <&mstp10_clks R8A7795_CLK_SSI_ALL>, <&mstp10_clks R8A7795_CLK_SSI_ALL>,
> +                                               <&s3d4_clk>,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

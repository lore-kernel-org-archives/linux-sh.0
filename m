From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Jun 2014 10:28:14 +0000
Subject: Re: [PATCH 01/10] ARM: shmobile: r8a7790: add DVC support on DTSI
Message-Id: <CAMuHMdVMzOtcG3dp57jEuCFD2F9uBdEhi+WmMjErNx54iU9z0w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uouy3zl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uouy3zl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Jun 18, 2014 at 11:13 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index df59707..493762d 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1114,16 +1114,23 @@

You forgot to add 2 entries to "clocks" above.

>                         <&mstp10_clks R8A7790_CLK_SCU_SRC5>, <&mstp10_clks R8A7790_CLK_SCU_SRC4>,
>                         <&mstp10_clks R8A7790_CLK_SCU_SRC3>, <&mstp10_clks R8A7790_CLK_SCU_SRC2>,
>                         <&mstp10_clks R8A7790_CLK_SCU_SRC1>, <&mstp10_clks R8A7790_CLK_SCU_SRC0>,
> +                       <&mstp10_clks R8A7790_CLK_SCU_DVC0>, <&mstp10_clks R8A7790_CLK_SCU_DVC1>,
>                         <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
>                 clock-names = "ssi-all",
>                                 "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
>                                 "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
>                                 "src.9", "src.8", "src.7", "src.6", "src.5",
>                                 "src.4", "src.3", "src.2", "src.1", "src.0",

The above don't match with the version in renesas-devel-v3.15-20140616,
which has "scu-all", and "scu-src.*".

> +                               "dvc.0", "dvc.1",

Oh, they're already there, as "scu-dvc*", since

commit 78a29b8be588ecf7b2a7ee8d2b7e12f325730caa
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Tue Jun 10 23:53:27 2014 -0700

    ARM: shmobile: r8a7790: add MSTP10 support on DTSI

    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>


>                                 "clk_a", "clk_b", "clk_c", "clk_i";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

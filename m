From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Sep 2015 07:01:47 +0000
Subject: Re: [PATCH 2/3] arm64: dts: r8a7795: add GPIO nodes
Message-Id: <CAMuHMdUVZeqXZHOhKu4P8ZuXTr7sCASoqr0VhaqeE5qnJFeZvA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441035401-5843-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1441035401-5843-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Uli,

On Mon, Aug 31, 2015 at 5:36 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index ca1970d..4bbf626 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -52,6 +52,110 @@
>                                         (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
>
> +               gpio0: gpio@e6050000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6050000 0 0x50>;
> +                       interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 0 32>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&mstp9_clks R8A7795_CLK_GPIO0>;

Missing (in all nodes) "power-domains = <&cpg_clocks>;"
With gen3-cpg-v5 it still works without accidentally, because
drivers/sh/pm_runtime.c falls back to the legacy clock domain if
CONFIG_ARCH_SHMOBILE_MULTI is not set.

> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

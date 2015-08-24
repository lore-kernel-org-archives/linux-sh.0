From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 12:48:46 +0000
Subject: Re: [PATCH 09/25 v7][RFC] arm64: renesas: r8a7795: Add SCIF2 support
Message-Id: <CAMuHMdW8E_qK8SuQG9Pmx+Ep9==wyNS+peNt-CF=xGgZ0kiFtg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv3977aa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv3977aa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 24, 2015 at 4:28 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi

> +               scif2: serial@e6e88000 {
> +                       compatible = "renesas,scif-r8a7795", "renesas,scif";
> +                       reg = <0 0xe6e88000 0 64>;
> +                       interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
> +                       clock-names = "sci_ick";

status = "disabled;"

Sorry for not noticing before.

> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

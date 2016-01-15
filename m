From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Jan 2016 10:40:45 +0000
Subject: Re: [PATCH 3/4] ARM64: renesas: r8a7795: Add DU device to DT
Message-Id: <CAMuHMdWB5iuH5P6H71tE-S2CRAFuxTp=VMfnVp696OD=DThq4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 17, 2015 at 8:21 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -889,5 +889,51 @@
>                         renesas,#rpf = <5>;
>                         renesas,#wpf = <2>;
>                 };
> +
> +               du: display@feb00000 {
> +                       compatible = "renesas,du-r8a7795";
> +                       reg = <0 0xfeb00000 0 0x80000>,
> +                             <0 0xfeb90000 0 0x14>;
> +                       reg-names = "du", "lvds.0";
> +                       interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 268 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 269 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <0 270 IRQ_TYPE_LEVEL_HIGH>;

<GIC_SPI ...> (x4)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

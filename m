From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 09:39:33 +0000
Subject: Re: [PATCH 16/25 v7][RFC] arm64: renesas: salvator-x: add pfc node and subnodes for usb 2.0
Message-Id: <CAMuHMdXDCXUOmEUR6nJUTA_O2trm747xqba-ODxooA-NLtw1Aw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Shimoda-san,

On Mon, Aug 24, 2015 at 4:30 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index cdfc4c9..2742fc2 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -38,6 +38,23 @@
>         };
>  };
>
> +&pfc {

Please merge this with the "&pfc" section above.

> +       usb0_pins: usb0 {
> +               renesas,groups = "usb0";
> +               renesas,function = "usb0";
> +       };
> +
> +       usb1_pins: usb1 {
> +               renesas,groups = "usb1";
> +               renesas,function = "usb1";
> +       };
> +
> +       usb2_pins: usb2 {
> +               renesas,groups = "usb2";
> +               renesas,function = "usb2";
> +       };
> +};
> +
>  &scif2 {
>         pinctrl-0 = <&scif2_pins>;
>         pinctrl-names = "default";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

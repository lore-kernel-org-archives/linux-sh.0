From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Aug 2015 14:26:12 +0000
Subject: Re: [PATCH 16/25 v7][RFC] arm64: renesas: salvator-x: add pfc node and subnodes for usb 2.0
Message-Id: <CAMuHMdX221P5n_BLrP2OUXtpROqbS_QWGAj8MQhfo_FqzgT9Uw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san, Morimoto-san, Kihara-san,

On Mon, Aug 24, 2015 at 4:30 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -38,6 +38,23 @@
>         };
>  };
>
> +&pfc {
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

If CONFIG_PINCTRL=y:

| sh-pfc e6060000.pfc: cannot locate data/mark enum_id for mark 2253
| phy_rcar_gen3_usb2 ee080200.usb-phy: Error applying setting, reverse
things back

mark 2253 = USB0_PWEN_MARK

I believe this is due to the IPSR16 section in the pinmux_data[] array in
drivers/pinctrl/sh-pfc/pfc-r8a7795.c lacking data for IP16_11_8.
Data for usb1 (IP16_19_16) and usb2 (IP15_3_0) is present.

Unfortunately my pinctrl foo is not strong enough to fill in the missing
pieces...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2015 08:35:56 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <CAMuHMdXtNPuiPPu07dUazrPmFr=hamRwY+=e7BM3ujEQfJg-kA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

Thanks for the update!

On Fri, Aug 28, 2015 at 10:27 AM, Simon Horman <horms@verge.net.au> wrote:
> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> @@ -6,8 +6,12 @@ interface contains.
>  Required properties:
>  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
>               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
>  - reg: offset and length of (1) the register block and (2) the stream buffer.
> -- interrupts: interrupt specifier for the sole interrupt.
> +- interrupts: interrupt specifiers.
> +             One data and one emac interrupt for the R8A7795 SoC;
> +             these interrupts must be named.
> +              One named or unnamed data interrupt otherwise.
>  - phy-mode: see ethernet.txt file in the same directory.
>  - phy-handle: see ethernet.txt file in the same directory.
>  - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
> @@ -18,6 +22,12 @@ Required properties:
>  Optional properties:
>  - interrupt-parent: the phandle for the interrupt controller that services
>                     interrupts for this device.
> +- interrupt-names: Names of named interrupts.
> +                   If the property is present "data" is required.
> +                   "emac" is also required for the R8A7795 SoC;
> +                  it is prohibited otherwise.
> +                  This property is mandatory for the R8A7795 SoC;
> +                  optional otherwise.
>  - pinctrl-names: pin configuration state name ("default").
>  - renesas,no-ether-link: boolean, specify when a board does not provide a proper
>                          AVB_LINK signal.

What about the 25 channel interrupts?
"data" and "emac" seem to use ch22 resp. ch 24 on Gen3.

I'm afraid this will bite us one day.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Jan 2016 08:29:54 +0000
Subject: Re: [PATCH] usb: host: xhci-plat: add R-Car Gen2 and Gen3 fallback compatibility strings
Message-Id: <CAMuHMdUaiD1=nUumrcgt0dEVE9RSh6trpt6EO11mrM8167tWTg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452220639-31008-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1452220639-31008-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Jan 8, 2016 at 3:37 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Add fallback compatibility strings for R-Car Gen2 and Gen3.
>
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -1,10 +1,23 @@
>  USB xHCI controllers
>
>  Required properties:
> -  - compatible: should be one of "generic-xhci",
> -    "marvell,armada-375-xhci", "marvell,armada-380-xhci",
> -    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791", "renesas,xhci-r8a7793",
> -    "renesas,xhci-r8a7795" (deprecated: "xhci-platform").
> +  - compatible: should be one or more of
> +
> +    - "generic-xhci" for generic XHCI device,
> +    - "marvell,armada-375-xhci" for Armada 375 SoCs,
> +    - "marvell,armada-380-xhci" for Armada 380 SoCs,
> +    - "renesas,xhci-r8a7790" for r8a7790 SoC,
> +    - "renesas,xhci-r8a7791" for r8a7791 SoC
> +    - "renesas,xhci-r8a7793" for r8a7793 SoC
> +    - "renesas,xhci-r8a7795" for r8a7795 SoC
> +    - "renesas,rcar-gen2-xhci" for a generic R-Car Gen2 compatible device.
> +    - "renesas,rcar-gen3-xhci" for a generic R-Car Gen3 compatible device.
> +    - "xhci-platform" (deprecated)

Inconsistent line ending (comma, period, or nothing).

> +    When compatible with the generic version, nodes must list the
> +    SoC-specific version corresponding to the platform first
> +    followed by the generic version.
> +
>    - reg: should contain address and length of the standard XHCI
>      register set for the device.
>    - interrupts: one XHCI interrupt should be described here.
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 770b6b088797..63fb0c9c6612 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -104,12 +104,17 @@ static const struct of_device_id usb_xhci_of_match[] = {
>                 .compatible = "renesas,xhci-r8a7791",
>                 .data = &xhci_plat_renesas_rcar_gen2,
>         }, {
> +               .compatible = "renesas,rcar-gen2-xhci",
> +               .data = &xhci_plat_renesas_rcar_gen2,
> +       }, {

Shouldn't this be inserted below "renesas,xhci-r8a7793"?
Or better, group all generic ones at the bottom?

>                 .compatible = "renesas,xhci-r8a7793",
>                 .data = &xhci_plat_renesas_rcar_gen2,
>         }, {
>                 .compatible = "renesas,xhci-r8a7795",
>                 .data = &xhci_plat_renesas_rcar_gen3,
>         }, {
> +               .compatible = "renesas,rcar-gen3-xhci",
> +               .data = &xhci_plat_renesas_rcar_gen3,
>         },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

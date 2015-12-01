From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Dec 2015 08:41:49 +0000
Subject: Re: [PATCH 1/4] PCI: rcar-gen2: Add generic compatibility string
Message-Id: <CAMuHMdVJvChiFTkeeJNBcPG2CsC3PxoEC4Lx0fHOeMMMPLew0g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448954672-27236-1-git-send-email-horms+renesas@verge.net.au>
	<1448954672-27236-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448954672-27236-2-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Dec 1, 2015 at 8:24 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Add fallback compatibility string for R-Car Gen 2 Family.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 11 +++++++++--
>  drivers/pci/host/pci-rcar-gen2.c                        |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index 891463cb09c2..b19be08a8113 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -8,7 +8,14 @@ OHCI and EHCI controllers.
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
>               "renesas,pci-r8a7791" for the R8A7791 SoC;
> -             "renesas,pci-r8a7794" for the R8A7794 SoC.
> +             "renesas,pci-r8a7794" for the R8A7794 SoC;
> +             "renesas,pci-gen2" for a generic R-Car Gen2 compatible device.

Shouldn't that be "renesas,pci-rcar-gen" or "renesas,pci-rcar2"?

Else you'll be in trouble when Renesas starts focussing on airplanes
(R-Plane Gen2), rockets (R-Rocket Gen2), or IoT (R-IoT Gen2).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

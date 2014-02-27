From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 27 Feb 2014 15:56:58 +0000
Subject: Re: [PATCH] phy-rcar-gen2-usb: add device tree support
Message-Id: <20140227155657.GD8647@e106331-lin.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402270312.51588.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402270312.51588.sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "valentine.barshak-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <valentine.barshak-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Feb 27, 2014 at 12:12:50AM +0000, Sergei Shtylyov wrote:
> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
> documenting the device tree binding as necessary.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.
> 
>  Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++
>  drivers/usb/phy/phy-rcar-gen2-usb.c                     |   64 ++++++++++++++--
>  2 files changed, 85 insertions(+), 8 deletions(-)
> 
> Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
> =================================> --- /dev/null
> +++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
> @@ -0,0 +1,29 @@
> +* Renesas R-Car generation 2 USB PHY
> +
> +This file provides information on what the device node for the R-Car generation
> +2 USB PHY contains.
> +
> +Required properties:
> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
> +	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.

Is the r8a7791's USB PHY known to be different to that of the r8a7790?

If this is just to possibly handle the two differently in future, why
not have "renesas,usb-phy-r8a7790" as a fallback in the compatible list?
That was you only need it in the driver for now.

> +- reg: offset and length of the register block.
> +- clocks: clock phandle and specifier pair.
> +- clock-names: string, clock input name, must be "usbhs".
> +
> +Optional properties:
> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be connected
> +			to PCI EHCI/OHCI; otherwise, it will be connected to the
> +			USBHS controller.
> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be connected
> +			to PCI EHCI/OHCI; otherwise, it will be connected to the
> +			USBSS controller (xHCI).

When would you want this to connect to PCI, and when would you not? Why
is this not a run-time decision?

> +
> +Example (Lager board):
> +
> +	usb-phy@e6590100 {
> +		compatible = "renesas,usb-phy-r8a7790";
> +		reg = <0 0xe6590100 0 0x100>;
> +		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> +		clock-names = "usbhs";
> +		renesas,channel2-pci;
> +	};

We're not using the generic phy bindings? How is the linkage to the host
controller expressed?

[...]

> -	clk = devm_clk_get(dev, "usbhs");
> +	if (np)
> +		clk = of_clk_get_by_name(np, "usbhs");
> +	else
> +		clk = clk_get(dev, "usbhs");

Doesn't clk_get (and hence devm_clk_get) call of_clk_get_by_name?

Cheers,
Mark.

From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Mar 2014 05:46:05 +0000
Subject: Re: [PATCH v2] phy-rcar-gen2-usb: add device tree support
Message-Id: <CANqRtoRTtsF64jZ-n_VbmzkRehUoBWQLEd5jfAL86wyLrvAUPQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403010407.54639.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403010407.54639.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux-USB <linux-usb@vger.kernel.org>, robh+dt@kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, SH-Linux <linux-sh@vger.kernel.org>, Valentine Barshak <valentine.barshak@cogentembedded.com>, rob@landley.net, linux-doc@vger.kernel.org

On Sat, Mar 1, 2014 at 10:07 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
> documenting the device tree binding as necessary.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.
>
> Changes in version 2:
> - restored devm_clk_get() call and the error handling logic in the probe()
>   method, removed clk_put() call in the remove() method.
>
>  Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++++++
>  drivers/usb/phy/phy-rcar-gen2-usb.c                     |   42 ++++++++++++++--
>  2 files changed, 68 insertions(+), 3 deletions(-)
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
> +             "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
> +- reg: offset and length of the register block.
> +- clocks: clock phandle and specifier pair.
> +- clock-names: string, clock input name, must be "usbhs".
> +
> +Optional properties:
> +- renesas,channel0-pci: boolean, specify when USB channel 0 should be connected
> +                       to PCI EHCI/OHCI; otherwise, it will be connected to the
> +                       USBHS controller.
> +- renesas,channel2-pci: boolean, specify when USB channel 2 should be connected
> +                       to PCI EHCI/OHCI; otherwise, it will be connected to the
> +                       USBSS controller (xHCI).

Thanks for your efforts here, but this DT binding looks like a mix of
software configuration and hardware description. I would like to omit
the software configuration portion if possible and only describe the
hardware.

> +Example (Lager board):
> +
> +       usb-phy@e6590100 {
> +               compatible = "renesas,usb-phy-r8a7790";
> +               reg = <0 0xe6590100 0 0x100>;
> +               clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> +               clock-names = "usbhs";
> +               renesas,channel2-pci;
> +       };

As an example, instead of relying on "renesas,channel0-pci" or
"renesas,channel2-pci" to specify which hard coded software
configuration you want please rework this to expose 3 separate
channels and use DT to point each host controller to the right
channel.

That will give us the opportunity to perform any kind of run time
selection and not be limited by software policy set by DT.

So this is a NAK on my side. I expect better.

Thanks,

/ magnus

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 06 Mar 2014 18:16:04 +0000
Subject: Re: [PATCH 3/9] phy-rcar-usb-gen2: add device tree support
Message-Id: <5318C973.70501@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-4-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se, horms@verge.net.au, Felipe Balbi <balbi@ti.com>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Hello.

On 03/06/2014 09:01 PM, Ben Dooks wrote:

> Add support for the phy-rcar-gen2-usb driver to be probed from device tree.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
> Fixes from v2:
> 	- fix missed of_match_ptr()
> 	- fix names of channel selection booleans
> 	- updated and merged documentation for dt entries
>
> Fixes from v2:
> 	- fix missing of_if patch
>
> Fixes from v1:
> 	- use of_property_reasd-bool()
> 	- remove unused of_id variable
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: devicetree@vger.kernel.org

> Conflicts:
> 	drivers/usb/phy/phy-rcar-gen2-usb.c
> ---
>   .../bindings/usb/renesas,rcar-gen2-usb-phy.txt     | 36 ++++++++++++++++++++++
>   drivers/pci/host/pci-rcar-gen2.c                   |  1 +

    Eh? What does this file have to do with USB PHY?

>   drivers/usb/phy/phy-rcar-gen2-usb.c                | 34 +++++++++++++++++---
>   3 files changed, 66 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt

> diff --git a/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
> new file mode 100644
> index 0000000..5351a30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
> @@ -0,0 +1,36 @@
> +Renesas RCar gen2 USB PHY bindings
> +----------------------------------
> +
> +Bindings for the USB PHY block used in some Renesas SoCs.
> +
> +Required properties:
> + - compatible:  "renesas,usb-phy-r8a7790" for the R8A7790 SoC
> +		"renesas,usb-phy-r8a7791" for the R8A7791 SoC
> + - reg : A single region to access device registers
> + - clocks : The reference to the clock to use for this block
> + - clock-names : The name for the clock at index 0 (must be "usbhs")
> +
> +Optional properties:
> +
> + - renesas,usb0-device: boolean, if present USB0 is connected to HS device
> +			otherwise the USB0 is connected to OHCI/EHCI host.

    IIUC, the testing has shown that USBHS is dual-role controller in that 
case, i.e. supports both host and device roles (the manual has the host 
controller details too). Vladimir, is it so?

> + - renesas,usb2-xhci: boolean, if present USB2 is connected to XHCI controller
> +		      otherwise the USB2 is connected to OHCI/EHCI host.
> +
> +
> +Example device node for SoC dtsi file:
> +
> +	usbphy: usbphy@e6590100 {
> +		compatible = "renesas,usb-phy-r8a7790";
> +		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> +		clock-names = "usbhs";
> +		reg = < 0x0 0xe6590100 0x0 0x100>;
> +		status = "disabled";
> +	};
> +
> +Example board file:
> +
> +&usbphy {
> +	status = "okay";
> +};

    These are usually merged into one node for the example.

WBR, Sergei


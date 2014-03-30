From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 30 Mar 2014 19:29:31 +0000
Subject: Re: [PATCH 9/9] ARM: shmobile: lager.dts: link usb-phy to pci nodes
Message-Id: <5338709B.1080001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-10-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-10-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/06/2014 09:01 PM, Ben Dooks wrote:

> Add the necessary links to add the USB phy nodes to the PCI devices
> that are behind the bridges specified.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 63d58d6..62f486e 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -233,18 +233,55 @@
>   &pci0 {
>   	pinctrl-0 = <&usb0_pins>;
>   	pinctrl-names = "default";
> +	device_type = "pci";
> +
> +	pci@0,1 {
> +		reg = <0x800 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
> +
> +	pci@0,2 {
> +		reg = <0x1000 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
>   };
>
>   &pci1 {
>   	status = "okay";
>   	pinctrl-0 = <&usb1_pins>;
>   	pinctrl-names = "default";
> +
> +	pci@0,1 {
> +		reg = <0x800 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
> +
> +	pci@0,2 {
> +		reg = <0x1000 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
>   };
>
>   &pci2 {
>   	status = "okay";
>   	pinctrl-0 = <&usb2_pins>;
>   	pinctrl-names = "default";
> +
> +	pci@0,1 {
> +		reg = <0x800 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
> +
> +	pci@0,2 {
> +		reg = <0x1000 0 0 0 0>;
> +		device_type = "pci";
> +		usb-phy = <&usbphy>;
> +	};
>   };

    I don't see why the internal PCI devices are added to the board file, not 
the SoC file.

WBR, Sergei


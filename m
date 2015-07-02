From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 02 Jul 2015 11:32:11 +0000
Subject: Re: [PATCH v2] arm: koelsch: make USB0 perform Host/Function switching
Message-Id: <5595213B.7080809@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435824869-22784-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1435824869-22784-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 7/2/2015 11:14 AM, Phil Edworthy wrote:

> Both USB Host (pci0) and Function (USBHS) drivers are enabled.
> The USB PHY driver determines which IP block should be connected
> based on vbus and id signals read via gpios.

> Note that switch SW5 and SW6 on Koelsch board needs to be set to
> position 3 for this to work.

[...]

> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index cffe33f..1bb34d0 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -615,7 +615,6 @@
>
>   &pci0 {
>   	status = "okay";
> -	pinctrl-0 = <&usb0_pins>;
>   	pinctrl-names = "default";

    As you're removing "pinctrl-0" prop, you also should remove "pinctrl-names".

>   };
>
> @@ -627,13 +626,15 @@
>
>   &hsusb {
>   	status = "okay";
> -	pinctrl-0 = <&usb0_pins>;

    Likewise.

[...]

WBR, Sergei


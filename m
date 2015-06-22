From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 22 Jun 2015 17:43:31 +0000
Subject: Re: [PATCH 3/3] arm: koelsch: make USB0 perform Host/Function switching
Message-Id: <55884943.9080607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434984151-27274-1-git-send-email-phil.edworthy@renesas.com> <1434984151-27274-4-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1434984151-27274-4-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>, Kishon Vijay Abraham I <kishon@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 06/22/2015 05:42 PM, Phil Edworthy wrote:

> Both USB Host (pci0) and Function (USBHS) drivers are enabled.
> The USB PHY driver determines which IP block should be connected
> based on vbus and id signals read via gpios.

> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7791-koelsch.dts | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index cffe33f..8f394be 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
[...]
> @@ -627,13 +626,15 @@
>
>   &hsusb {
>   	status = "okay";
> -	pinctrl-0 = <&usb0_pins>;
>   	pinctrl-names = "default";
> -	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
>   };
>
>   &usbphy {
>   	status = "okay";
> +	renesas,pwr = <&gpio2 4 GPIO_ACTIVE_HIGH>;
> +	renesas,id = <&gpio5 31 GPIO_ACTIVE_HIGH>;
> +	renesas,vbus = <&gpio7 24 GPIO_ACTIVE_HIGH>;
> +	renesas,vbus-pwr = <&gpio7 23 GPIO_ACTIVE_HIGH>;

    The prop names should end with "-gpio" or even "-gpios", according to the 
GPIO bindings.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in

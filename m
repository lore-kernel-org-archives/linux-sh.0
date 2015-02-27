From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Feb 2015 01:49:42 +0000
Subject: Re: [PATCH] ARM: shmobile: ape6evm dts: Fix polarity of LEDs
Message-Id: <20150227014940.GJ31738@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424947589-8303-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424947589-8303-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 26, 2015 at 11:46:29AM +0100, Geert Uytterhoeven wrote:
> While the LEDs on r8a73a4/ape6evm are tied to VSUPPLY, they're driven by
> an N-channel MOSFET. Hence the GPIO signal should be active high.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Thanks, I have queued this up.

> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> index f9e81512201a2ec4..b355fafc32f188dc 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> @@ -75,27 +75,27 @@
>  	leds {
>  		compatible = "gpio-leds";
>  		led1 {
> -			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
> +			gpios = <&pfc 28 GPIO_ACTIVE_HIGH>;
>  			label = "GNSS_EN";
>  		};
>  		led2 {
> -			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
> +			gpios = <&pfc 126 GPIO_ACTIVE_HIGH>;
>  			label = "NFC_NRST";
>  		};
>  		led3 {
> -			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
> +			gpios = <&pfc 132 GPIO_ACTIVE_HIGH>;
>  			label = "GNSS_NRST";
>  		};
>  		led4 {
> -			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
> +			gpios = <&pfc 232 GPIO_ACTIVE_HIGH>;
>  			label = "BT_WAKEUP";
>  		};
>  		led5 {
> -			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
> +			gpios = <&pfc 250 GPIO_ACTIVE_HIGH>;
>  			label = "STROBE";
>  		};
>  		led6 {
> -			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
> +			gpios = <&pfc 288 GPIO_ACTIVE_HIGH>;
>  			label = "BBRESETOUT";
>  		};
>  	};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

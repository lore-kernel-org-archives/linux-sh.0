From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 01:31:05 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: armadillo-reference dts: Add matching LED labels
Message-Id: <20140513013105.GB10973@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1399550800-25656-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399550800-25656-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Thu, May 08, 2014 at 02:06:40PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Should the node names be changed from "led[1-4]" to "led[3-6]", too?

Yes, I think so. At the very least that would seem to be
the way it has been done for newer renesas SoCs.

> 
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index 486007d7ffe4..8c7255438292 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -106,15 +106,19 @@
>  		compatible = "gpio-leds";
>  		led1 {
>  			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
> +			label = "LED3";
>  		};
>  		led2 {
>  			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
> +			label = "LED4";
>  		};
>  		led3 {
>  			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
> +			label = "LED5";
>  		};
>  		led4 {
>  			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
> +			label = "LED6";
>  		};
>  	};
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

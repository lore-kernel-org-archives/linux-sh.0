From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Dec 2014 00:26:55 +0000
Subject: Re: [PATCH] ARM: shmobile: ape6evm: Fix LAN9220 VDDVARIO voltage
Message-Id: <20141217002655.GF23321@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771845-12191-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771845-12191-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 17, 2014 at 01:17:25AM +0200, Laurent Pinchart wrote:
> The LAN9220 VDDVARIO supply is powered by a 1.8V source, not 3.3V. Fix
> it in the device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> This patch is based on top of Ulrich's "[PATCH v2 0/7] ARM: shmobile: ape6evm:
> multiplatform support" series, but it could easily be rebased to apply without
> that dependency.

My preference is to take this fix before Ulrich's series.
But I am happy to negotiate if others have a different preference.

> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> index 6b7bc1fb842e..0d50bef01234 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> @@ -55,8 +55,16 @@
>  		enable-active-high;
>  	};
>  
> -	/* Common 3.3V rail, used by several devices on APE6EVM */
> -	ape6evm_fixed_3v3: regulator@2 {
> +	/* Common 1.8V and 3.3V rails, used by several devices on APE6EVM */
> +	ape6evm_fixed_1v8: regulator@2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	ape6evm_fixed_3v3: regulator@3 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "3V3";
>  		regulator-min-microvolt = <3300000>;
> @@ -80,7 +88,7 @@
>  			smsc,irq-active-high;
>  			smsc,irq-push-pull;
>  			vdd33a-supply = <&ape6evm_fixed_3v3>;
> -			vddvario-supply = <&ape6evm_fixed_3v3>;
> +			vddvario-supply = <&ape6evm_fixed_1v8>;
>  		};
>  	};
>  
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

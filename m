From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:52:36 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: kzm9g-reference: Add GPIO keys to DT
Message-Id: <20131128075236.GK24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385428879-26849-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385428879-26849-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 26, 2013 at 02:21:19AM +0100, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 46 ++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Thanks, I have queued this up.

> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index d58877d..5bb593d 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -106,6 +106,52 @@
>  			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		back-key {
> +			gpios = <&pcf8575 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <158>;
> +			label = "SW3";
> +		};
> +
> +		right-key {
> +			gpios = <&pcf8575 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <106>;
> +			label = "SW2-R";
> +		};
> +
> +		left-key {
> +			gpios = <&pcf8575 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <105>;
> +			label = "SW2-L";
> +		};
> +
> +		enter-key {
> +			gpios = <&pcf8575 11 GPIO_ACTIVE_LOW>;
> +			linux,code = <28>;
> +			label = "SW2-P";
> +		};
> +
> +		up-key {
> +			gpios = <&pcf8575 12 GPIO_ACTIVE_LOW>;
> +			linux,code = <103>;
> +			label = "SW2-U";
> +		};
> +
> +		down-key {
> +			gpios = <&pcf8575 13 GPIO_ACTIVE_LOW>;
> +			linux,code = <108>;
> +			label = "SW2-D";
> +		};
> +
> +		home-key {
> +			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
> +			linux,code = <102>;
> +			label = "SW1";
> +		};
> +	};
>  };
>  
>  &i2c0 {
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

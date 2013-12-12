From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 13:23:01 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: dts: Add gpio-keys device
Message-Id: <20131212132300.GG30624@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386776571-12979-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386776571-12979-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 11, 2013 at 04:42:51PM +0100, Laurent Pinchart wrote:
> The board has 7 buttons connected to GPIOs, add a corresponding
> gpio-keys device.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch-reference.dts | 54 +++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> index 1919273..588ca17 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> @@ -31,6 +31,60 @@
>  		#size-cells = <1>;
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		key-a {
> +			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
> +			linux,code = <30>;
> +			label = "SW30";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +		key-b {
> +			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <48>;
> +			label = "SW31";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +		key-c {
> +			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <46>;
> +			label = "SW32";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +		key-d {
> +			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <32>;
> +			label = "SW33";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +		key-e {
> +			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
> +			linux,code = <18>;
> +			label = "SW34";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +		key-f {
> +			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
> +			linux,code = <33>;
> +			label = "SW35";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +		key-g {
> +			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <34>;
> +			label = "SW36";
> +			gpio-key,wakeup;
> +			debounce-interval = <20>;
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		led6 {
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

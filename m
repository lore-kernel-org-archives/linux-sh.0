From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Apr 2014 00:11:29 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo-reference dts: enable RTC
Message-Id: <20140403001129.GB4223@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 31, 2014 at 05:38:20PM +0200, Ulrich Hecht wrote:
> This enables the Seiko real-time clock that is attached to a couple of
> GPIO pins.

Hi Ulrich,

I am a little confused about i2c2 appearing below as
the documentation that I have only seems to refer to
the presence of i2c0 and i2c1.

> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>  .../arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index b79ea51..ac352ef 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -118,6 +118,16 @@
>  		};
>  	};
>  
> +	i2c2: i2c@2 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "i2c-gpio";
> +		gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
> +			 &pfc 91 GPIO_ACTIVE_HIGH /* scl */
> +			>;
> +		i2c-gpio,delay-us = <5>;
> +	};
> +
>  	backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
> @@ -178,6 +188,14 @@
>  	};
>  };
>  
> +&i2c2 {
> +	status = "okay";
> +	rtc@30 {
> +		compatible = "seiko,s35390a";
> +		reg = <0x30>;
> +	};
> +};
> +
>  &pfc {
>  	pinctrl-0 = <&scifa1_pins>;
>  	pinctrl-names = "default";
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

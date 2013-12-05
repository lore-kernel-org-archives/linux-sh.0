From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 05:09:21 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: armadillo: add FSI support for DTS
Message-Id: <20131205050918.GF12774@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wqjlz9nr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqjlz9nr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 03, 2013 at 05:28:59PM -0800, Kuninori Morimoto wrote:
> This patch support FSI-WM8978 with simple audio card
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |   37 ++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index 7b80f19..6d6fd3d 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -87,6 +87,24 @@
>  		pinctrl-0 = <&backlight_pins>;
>  		pinctrl-names = "default";
>  	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +
> +		simple-audio-card,format = "i2s";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sh_fsi2 0>;
> +			bitclock-inversion;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&wm8978>;
> +			bitclock-master;
> +			frame-master;
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
>  };
>  
>  &i2c0 {
> @@ -100,6 +118,12 @@
>  		pinctrl-names = "default";
>  		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
>  	};
> +
> +	wm8978: wm8978@1a {
> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8978";
> +		reg = <0x1a>;
> +	};
>  };
>  
>  &pfc {
> @@ -130,6 +154,12 @@
>  		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
>  		renesas,function = "sdhi0";
>  	};
> +
> +	fsia_pins: sounda {
> +		renesas,groups = "fsia_sclk_in", "fsia_mclk_out",
> +				 "fsia_data_in_1", "fsia_data_out_0";
> +		renesas,function = "fsia";
> +	};
>  };
>  
>  &tpu {
> @@ -156,3 +186,10 @@
>  	cd-gpios = <&pfc 167 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
> +
> +&sh_fsi2 {
> +	pinctrl-0 = <&fsia_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

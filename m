From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 03:47:16 +0000
Subject: Re: [PATCH] ARM: shmobile: Use interrupt macros in r8a73a4 and r8a7778 DT files
Message-Id: <20131205034716.GC20388@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 28, 2013 at 05:22:13PM +0100, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 50 +++++++++++++++++++++---------------------
>  arch/arm/boot/dts/r8a7778.dtsi |  6 ++---
>  2 files changed, 28 insertions(+), 28 deletions(-)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index b4a6c3b..6b7ce89 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -137,27 +137,27 @@
>  			compatible = "renesas,shdma-r8a73a4";
>  			reg = <0 0xe6700020 0 0x89e0>;
>  			interrupt-parent = <&gic>;
> -			interrupts = <0 220 4
> -					0 200 4
> -					0 201 4
> -					0 202 4
> -					0 203 4
> -					0 204 4
> -					0 205 4
> -					0 206 4
> -					0 207 4
> -					0 208 4
> -					0 209 4
> -					0 210 4
> -					0 211 4
> -					0 212 4
> -					0 213 4
> -					0 214 4
> -					0 215 4
> -					0 216 4
> -					0 217 4
> -					0 218 4
> -					0 219 4>;
> +			interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
> +					0 200 IRQ_TYPE_LEVEL_HIGH
> +					0 201 IRQ_TYPE_LEVEL_HIGH
> +					0 202 IRQ_TYPE_LEVEL_HIGH
> +					0 203 IRQ_TYPE_LEVEL_HIGH
> +					0 204 IRQ_TYPE_LEVEL_HIGH
> +					0 205 IRQ_TYPE_LEVEL_HIGH
> +					0 206 IRQ_TYPE_LEVEL_HIGH
> +					0 207 IRQ_TYPE_LEVEL_HIGH
> +					0 208 IRQ_TYPE_LEVEL_HIGH
> +					0 209 IRQ_TYPE_LEVEL_HIGH
> +					0 210 IRQ_TYPE_LEVEL_HIGH
> +					0 211 IRQ_TYPE_LEVEL_HIGH
> +					0 212 IRQ_TYPE_LEVEL_HIGH
> +					0 213 IRQ_TYPE_LEVEL_HIGH
> +					0 214 IRQ_TYPE_LEVEL_HIGH
> +					0 215 IRQ_TYPE_LEVEL_HIGH
> +					0 216 IRQ_TYPE_LEVEL_HIGH
> +					0 217 IRQ_TYPE_LEVEL_HIGH
> +					0 218 IRQ_TYPE_LEVEL_HIGH
> +					0 219 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "error",
>  					"ch0", "ch1", "ch2", "ch3",
>  					"ch4", "ch5", "ch6", "ch7",
> @@ -181,7 +181,7 @@
>  		compatible = "renesas,rmobile-iic";
>  		reg = <0 0xe6500000 0 0x428>;
>  		interrupt-parent = <&gic>;
> -		interrupts = <0 174 0x4>;
> +		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> @@ -191,7 +191,7 @@
>  		compatible = "renesas,rmobile-iic";
>  		reg = <0 0xe6510000 0 0x428>;
>  		interrupt-parent = <&gic>;
> -		interrupts = <0 175 0x4>;
> +		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> @@ -201,7 +201,7 @@
>  		compatible = "renesas,rmobile-iic";
>  		reg = <0 0xe6520000 0 0x428>;
>  		interrupt-parent = <&gic>;
> -		interrupts = <0 176 0x4>;
> +		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> @@ -211,7 +211,7 @@
>  		compatible = "renesas,rmobile-iic";
>  		reg = <0 0xe6530000 0 0x428>;
>  		interrupt-parent = <&gic>;
> -		interrupts = <0 177 0x4>;
> +		interrupts = <0 177 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 3314e0a..b530df6 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -247,7 +247,7 @@
>  		compatible = "renesas,hspi";
>  		reg = <0xfffc7000 0x18>;
>  		interrupt-controller = <&gic>;
> -		interrupts = <0 63 4>;
> +		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> @@ -255,7 +255,7 @@
>  		compatible = "renesas,hspi";
>  		reg = <0xfffc8000 0x18>;
>  		interrupt-controller = <&gic>;
> -		interrupts = <0 84 4>;
> +		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> @@ -263,7 +263,7 @@
>  		compatible = "renesas,hspi";
>  		reg = <0xfffc6000 0x18>;
>  		interrupt-controller = <&gic>;
> -		interrupts = <0 85 4>;
> +		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  };
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

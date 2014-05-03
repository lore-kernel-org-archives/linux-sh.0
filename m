From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 03 May 2014 16:56:37 +0000
Subject: Re: [PATCH v3 4/7] ARM: lager: add vin1 node
Message-Id: <Pine.LNX.4.64.1405031855350.26510@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-5-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 14 Apr 2014, Ben Dooks wrote:

> Add device-tree for vin1 (composite video in) on the
> lager board.

I think this patch should be the last. The rest isn't so important, but 
also for them I would go from more generic to device / platform / board 
specific ones.

Thanks
Guennadi

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index a087421..6888866 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -158,6 +158,11 @@
>  		renesas,groups = "i2c2";
>  		renesas,function = "i2c2";
>  	};
> +
> +	vin1_pins: vin {
> +		renesas,groups = "vin1_data8", "vin1_clk";
> +		renesas,function = "vin1";
> +	};
>  };
>  
>  &mmcif1 {
> @@ -239,8 +244,41 @@
>  	status = "ok";
>  	pinctrl-0 = <&i2c2_pins>;
>  	pinctrl-names = "default";
> +
> +	adv7180: composite-in@0x20 {
> +		compatible = "adi,adv7180";
> +		reg = <0x20>;
> +		remote = <&vin1>;
> +
> +		port {
> +			adv7180_1: endpoint {
> +				bus-width = <8>;
> +				remote-endpoint = <&vin1ep0>;
> +			};
> +		};
> +	};
> +
>  };
>  
>  &i2c3	{
>  	status = "ok";
>  };
> +
> +/* composite video input */
> +&vin1 {
> +	pinctrl-0 = <&vin1_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "ok";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vin1ep0: endpoint {
> +			remote-endpoint = <&adv7180_1>;
> +			bus-width = <8>;
> +		};
> +	};
> +};
> +
> -- 
> 1.9.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

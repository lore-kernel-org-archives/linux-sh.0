From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Mar 2014 01:55:13 +0000
Subject: Re: [PATCH 2/5] ARM: lager: add vin1 node
Message-Id: <20140313015513.GA16719@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394197299-17528-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394197299-17528-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk

On Fri, Mar 07, 2014 at 01:01:36PM +0000, Ben Dooks wrote:
> Add device-tree for vin1 (composite video in) on the
> lager board.

Please update the prefix of the subject of this patch to:
ARM: shmobile: lager: 

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index a087421..7528cfc 100644
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
> +	adv7180: adv7180@0x20 {
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
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

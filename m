From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 23 Feb 2014 22:28:35 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7791: add IIC(B) cores to dtsi
Message-Id: <1811144.7JYTPar7GZ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393159224-14377-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1393159224-14377-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sunday 23 February 2014 13:40:23 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index eb2cec8..d3aed50 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -26,6 +26,9 @@
>  		i2c3 = &i2c3;
>  		i2c4 = &i2c4;
>  		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
>  	};
> 
>  	cpus {
> @@ -179,6 +182,7 @@
>  			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> 
> +	/* The memory map in the User's Manual maps the cores to bus numbers */
>  	i2c0: i2c@e6508000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -230,6 +234,7 @@
>  	};
> 
>  	i2c5: i2c@e6528000 {
> +		/* doesn't need pinmux */
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "renesas,i2c-r8a7791";
> @@ -239,6 +244,37 @@
>  		status = "disabled";
>  	};
> 
> +	i2c6: i2c@e60b0000 {
> +		/* doesn't need pinmux */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,i2cB-r8a7791", "renesas,rmobile-iic";

Wouldn't "renesas,iic-r8a7791" be more appropriate ? It would be closer to 
"renesas,rmobile-iic".

> +		reg = <0 0xe60b0000 0 0x425>;
> +		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
> +		status = "disabled";
> +	};
> +
> +	i2c7: i2c@e6500000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,i2cB-r8a7791", "renesas,rmobile-iic";
> +		reg = <0 0xe6500000 0 0x425>;
> +		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
> +		status = "disabled";
> +	};
> +
> +	i2c8: i2c@e6510000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,i2cB-r8a7791", "renesas,rmobile-iic";
> +		reg = <0 0xe6510000 0 0x425>;
> +		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
> +		status = "disabled";
> +	};
> +
>  	pfc: pfc@e6060000 {
>  		compatible = "renesas,pfc-r8a7791";
>  		reg = <0 0xe6060000 0 0x250>;

-- 
Regards,

Laurent Pinchart


From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Sep 2014 00:49:21 +0000
Subject: Re: [PATCH 1/6] ARM: shmobile: r7s72100: sort dtsi file by address
Message-Id: <20140916004921.GI26557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1410511876-9235-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1410511876-9235-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com

On Fri, Sep 12, 2014 at 10:51:11AM +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r7s72100.dtsi | 202 ++++++++++++++++++++--------------------

This seems to have some (probably trivial) conflicts with
other changes queued up for v3.18. Accordingly I am deferring
it to v3.19. Please repost once v3.17-rc6 has been released.

>  1 file changed, 101 insertions(+), 101 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
> index 1d28d01..6a0e57e 100644
> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -52,16 +52,6 @@
>  			clock-output-names = "usb_x1";
>  		};
>  
> -		/* Special CPG clocks */
> -		cpg_clocks: cpg_clocks@fcfe0000 {
> -			#clock-cells = <1>;
> -			compatible = "renesas,r7s72100-cpg-clocks",
> -				     "renesas,rz-cpg-clocks";
> -			reg = <0xfcfe0000 0x18>;
> -			clocks = <&extal_clk>, <&usb_x1_clk>;
> -			clock-output-names = "pll", "i", "g";
> -		};
> -
>  		/* Fixed factor clocks */
>  		b_clk: b_clk {
>  			#clock-cells = <0>;
> @@ -88,6 +78,16 @@
>  			clock-output-names = "p0";
>  		};
>  
> +		/* Special CPG clocks */
> +		cpg_clocks: cpg_clocks@fcfe0000 {
> +			#clock-cells = <1>;
> +			compatible = "renesas,r7s72100-cpg-clocks",
> +				     "renesas,rz-cpg-clocks";
> +			reg = <0xfcfe0000 0x18>;
> +			clocks = <&extal_clk>, <&usb_x1_clk>;
> +			clock-output-names = "pll", "i", "g";
> +		};
> +
>  		/* MSTP clocks */
>  		mstp3_clks: mstp3_clks@fcfe0420 {
>  			#clock-cells = <1>;
> @@ -148,97 +148,6 @@
>  		};
>  	};
>  
> -	gic: interrupt-controller@e8201000 {
> -		compatible = "arm,cortex-a9-gic";
> -		#interrupt-cells = <3>;
> -		#address-cells = <0>;
> -		interrupt-controller;
> -		reg = <0xe8201000 0x1000>,
> -			<0xe8202000 0x1000>;
> -	};
> -
> -	i2c0: i2c@fcfee000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> -		reg = <0xfcfee000 0x44>;
> -		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 158 IRQ_TYPE_EDGE_RISING>,
> -			     <0 159 IRQ_TYPE_EDGE_RISING>,
> -			     <0 160 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 161 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
> -		clock-frequency = <100000>;
> -		status = "disabled";
> -	};
> -
> -	i2c1: i2c@fcfee400 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> -		reg = <0xfcfee400 0x44>;
> -		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 166 IRQ_TYPE_EDGE_RISING>,
> -			     <0 167 IRQ_TYPE_EDGE_RISING>,
> -			     <0 168 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 169 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 170 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
> -		clock-frequency = <100000>;
> -		status = "disabled";
> -	};
> -
> -	i2c2: i2c@fcfee800 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> -		reg = <0xfcfee800 0x44>;
> -		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 174 IRQ_TYPE_EDGE_RISING>,
> -			     <0 175 IRQ_TYPE_EDGE_RISING>,
> -			     <0 176 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 177 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 178 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 179 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
> -		clock-frequency = <100000>;
> -		status = "disabled";
> -	};
> -
> -	i2c3: i2c@fcfeec00 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> -		reg = <0xfcfeec00 0x44>;
> -		interrupts = <0 181 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 182 IRQ_TYPE_EDGE_RISING>,
> -			     <0 183 IRQ_TYPE_EDGE_RISING>,
> -			     <0 184 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 185 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 186 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 187 IRQ_TYPE_LEVEL_HIGH>,
> -			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
> -		clock-frequency = <100000>;
> -		status = "disabled";
> -	};
> -
> -	mtu2: timer@fcff0000 {
> -		compatible = "renesas,mtu2";
> -		reg = <0xfcff0000 0x400>;
> -		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "tgi0a";
> -		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
> -		clock-names = "fck";
> -		status = "disabled";
> -	};
> -
>  	scif0: serial@e8007000 {
>  		compatible = "renesas,scif-r7s72100", "renesas,scif";
>  		reg = <0xe8007000 64>;
> @@ -404,4 +313,95 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	gic: interrupt-controller@e8201000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0xe8201000 0x1000>,
> +			<0xe8202000 0x1000>;
> +	};
> +
> +	i2c0: i2c@fcfee000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> +		reg = <0xfcfee000 0x44>;
> +		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 158 IRQ_TYPE_EDGE_RISING>,
> +			     <0 159 IRQ_TYPE_EDGE_RISING>,
> +			     <0 160 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 161 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
> +		clock-frequency = <100000>;
> +		status = "disabled";
> +	};
> +
> +	i2c1: i2c@fcfee400 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> +		reg = <0xfcfee400 0x44>;
> +		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 166 IRQ_TYPE_EDGE_RISING>,
> +			     <0 167 IRQ_TYPE_EDGE_RISING>,
> +			     <0 168 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 169 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
> +		clock-frequency = <100000>;
> +		status = "disabled";
> +	};
> +
> +	i2c2: i2c@fcfee800 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> +		reg = <0xfcfee800 0x44>;
> +		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 174 IRQ_TYPE_EDGE_RISING>,
> +			     <0 175 IRQ_TYPE_EDGE_RISING>,
> +			     <0 176 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 177 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 178 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 179 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
> +		clock-frequency = <100000>;
> +		status = "disabled";
> +	};
> +
> +	i2c3: i2c@fcfeec00 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,riic-r7s72100", "renesas,riic-rz";
> +		reg = <0xfcfeec00 0x44>;
> +		interrupts = <0 181 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 182 IRQ_TYPE_EDGE_RISING>,
> +			     <0 183 IRQ_TYPE_EDGE_RISING>,
> +			     <0 184 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 185 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 186 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 187 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
> +		clock-frequency = <100000>;
> +		status = "disabled";
> +	};
> +
> +	mtu2: timer@fcff0000 {
> +		compatible = "renesas,mtu2";
> +		reg = <0xfcff0000 0x400>;
> +		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tgi0a";
> +		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
> +		clock-names = "fck";
> +		status = "disabled";
> +	};
>  };
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

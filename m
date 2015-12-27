From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 27 Dec 2015 17:42:38 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7793: gose: HDMI prototype
Message-Id: <1473702.lujRLAD5tV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151217063328.27906.61335.sendpatchset@little-apple>
In-Reply-To: <20151217063328.27906.61335.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Thursday 17 December 2015 15:33:28 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> This prototype V2 patch adds r8a7793 GOSE HDMI video out support.
> 
> The r8a7793 GOSE board is similar to r8a7791 Koelsch. For those
> boards an on-board HDMI encoder chip drives an HDMI port and
> also a LVDS port is available for external LCD panels.
> 
> Basic testing with modetest seems to work well. The current state of
> r8a7793 SoC support is improving, however I2C support is still missing.
> 
> To check if the DU and HDMI drivers and hardware are working this
> patch simply ties together I2C2 and GPIO3 with the DU and HDMI
> devices. Once I2C is enabled in upstream for r8a7793 and GOSE then
> this patch can easily be reworked into something suitable for upstream.

Why don't you just split this patch to enable I2C and GPIO on r8a7793 ?

> Tested on r8a7793 Gose with HDMI hooked up to a Toshiba TV.
> # modetest -M rcar-du -s 33:1280x720@AR24
> 
> Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Built on top of "renesas-devel-20151217v2-v4.4-rc5"
> 
>  arch/arm/boot/dts/r8a7793-gose.dts |   98 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7793.dtsi     |   18 +++++-
>  2 files changed, 113 insertions(+), 3 deletions(-)
> 
> --- 0001/arch/arm/boot/dts/r8a7793-gose.dts
> +++ work/arch/arm/boot/dts/r8a7793-gose.dts	2015-12-17 11:48:47.880513000
> +0900 @@ -31,6 +31,54 @@
>  		device_type = "memory";
>  		reg = <0 0x40000000 0 0x40000000>;
>  	};
> +
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&adv7511_out>;
> +			};
> +		};
> +	};
> +
> +	x2_clk: x2-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <74250000>;
> +	};
> +
> +	x13_clk: x13-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <148500000>;
> +	};
> +};
> +
> +&du {
> +	pinctrl-0 = <&du_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	clocks = <&mstp7_clks R8A7793_CLK_DU0>,
> +		 <&mstp7_clks R8A7793_CLK_DU1>,
> +		 <&mstp7_clks R8A7793_CLK_LVDS0>,
> +		 <&x13_clk>, <&x2_clk>;
> +	clock-names = "du.0", "du.1", "lvds.0",
> +		      "dclkin.0", "dclkin.1";
> +
> +	ports {
> +		port@0 {
> +			endpoint {
> +				remote-endpoint = <&adv7511_in>;
> +			};
> +		};
> +		port@1 {
> +			lvds_connector: endpoint {
> +			};
> +		};
> +	};
>  };
> 
>  &extal_clk {
> @@ -38,6 +86,16 @@
>  };
> 
>  &pfc {
> +	i2c2_pins: i2c2 {
> +		renesas,groups = "i2c2";
> +		renesas,function = "i2c2";
> +	};
> +
> +	du_pins: du {
> +		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";

How about taking the comments I've made about v1 into account ?

> +		renesas,function = "du";
> +	};
> +
>  	scif0_pins: serial0 {
>  		renesas,groups = "scif0_data_d";
>  		renesas,function = "scif0";
> @@ -134,4 +192,44 @@
>  			};
>  		};
>  	};
> +};
> +
> +&i2c2 {
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	hdmi@39 {
> +		compatible = "adi,adv7511w";
> +		reg = <0x39>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> +
> +		adi,input-depth = <8>;
> +		adi,input-colorspace = "rgb";
> +		adi,input-clock = "1x";
> +		adi,input-style = <1>;
> +		adi,input-justification = "evenly";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7511_in: endpoint {
> +					remote-endpoint = <&du_out_rgb>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7511_out: endpoint {
> +					remote-endpoint = <&hdmi_con>;
> +				};
> +			};
> +		};
> +	};
>  };
> --- 0001/arch/arm/boot/dts/r8a7793.dtsi
> +++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-12-17 11:50:59.980513000 +0900
> @@ -19,6 +19,7 @@
>  	#size-cells = <2>;
> 
>  	aliases {
> +		i2c2 = &i2c2;
>  		spi0 = &qspi;
>  	};
> 
> @@ -405,6 +406,17 @@
>  		status = "disabled";
>  	};
> 
> +	i2c2: i2c@e6530000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,i2c-r8a7793";
> +		reg = <0 0xe6530000 0 0x40>;
> +		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
> +		power-domains = <&cpg_clocks>;
> +		status = "disabled";
> +	};
> +
>  	scif0: serial@e6e60000 {
>  		compatible = "renesas,scif-r8a7793", "renesas,scif";
>  		reg = <0 0xe6e60000 0 64>;
> @@ -820,19 +832,19 @@
>  			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
>  			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
>  				 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
> -				 <&cpg_clocks R8A7793_CLK_QSPI>;
> +				 <&cpg_clocks R8A7793_CLK_QSPI>, <&hp_clk>;
>  			#clock-cells = <1>;
>  			clock-indices = <
>  				R8A7793_CLK_GPIO7 R8A7793_CLK_GPIO6
>  				R8A7793_CLK_GPIO5 R8A7793_CLK_GPIO4
>  				R8A7793_CLK_GPIO3 R8A7793_CLK_GPIO2
>  				R8A7793_CLK_GPIO1 R8A7793_CLK_GPIO0
> -				R8A7793_CLK_QSPI_MOD
> +				R8A7793_CLK_QSPI_MOD R8A7793_CLK_I2C2
> 
>  			>;
> 
>  			clock-output-names >  				"gpio7", "gpio6", "gpio5", "gpio4",
>  				"gpio3", "gpio2", "gpio1", "gpio0",
> -				"qspi_mod";
> +				"qspi_mod", "i2c2";
>  		};
>  		mstp11_clks: mstp11_clks@e615099c {
>  			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-
clocks";

-- 
Regards,

Laurent Pinchart


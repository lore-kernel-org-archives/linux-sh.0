From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 02:23:06 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes
Message-Id: <20130730022306.GC31526@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307231318070.19465@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307231318070.19465@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 23, 2013 at 01:19:14PM +0200, Guennadi Liakhovetski wrote:
> This patch adds MMCIF0, SDHI0 and SDHI1 DT nodes and a fixed voltage
> reglator for them to the ape6evm-reference platform.

Magnus or Laurent, could you please review this?

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v2: also add a regulator
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   51 +++++++++++++++++++++++
>  1 files changed, 51 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> index bbd09d8..74a2e1c 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> @@ -24,6 +24,14 @@
>  		reg = <0 0x40000000 0 0x40000000>;
>  	};
>  
> +	ape6evm_fixed_3v3: fixedregulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
>  	lbsc {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -62,4 +70,47 @@
>  		renesas,groups = "scifa0_data";
>  		renesas,function = "scifa0";
>  	};
> +
> +	mmc0_pins: mmcif {
> +		renesas,groups = "mmc0_data8", "mmc0_ctrl";
> +		renesas,function = "mmc0";
> +	};
> +
> +	sdhi0_pins: sdhi0 {
> +		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
> +		renesas,function = "sdhi0";
> +	};
> +
> +	sdhi1_pins: sdhi1 {
> +		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
> +		renesas,function = "sdhi1";
> +	};
> +};
> +
> +&mmcif0 {
> +	vmmc-supply = <&ape6evm_fixed_3v3>;
> +	bus-width = <8>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	status = "okay";
> +};
> +
> +&sdhi0 {
> +	vmmc-supply = <&ape6evm_fixed_3v3>;
> +	bus-width = <4>;
> +	toshiba,mmc-wrprotect-disable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhi0_pins>;
> +	status = "okay";
> +};
> +
> +&sdhi1 {
> +	vmmc-supply = <&ape6evm_fixed_3v3>;
> +	bus-width = <4>;
> +	broken-cd;
> +	toshiba,mmc-wrprotect-disable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhi1_pins>;
> +	status = "okay";
>  };
> -- 
> 1.7.2.5
> 

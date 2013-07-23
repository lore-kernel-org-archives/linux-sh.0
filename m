From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jul 2013 02:25:17 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes
Message-Id: <20130723022517.GA29561@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307191724560.26183@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307191724560.26183@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 19, 2013 at 05:30:24PM +0200, Guennadi Liakhovetski wrote:
> This patch adds MMCIF0, SDHI0 and SDHI1 DT nodes to the ape6evm-reference
> platform.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> This won't work, until my patch "mmc: SDHI: add DT compatibility strings 
> for further SoCs" is applied, but it won't hurt either anyway, SDHI DT 
> nodes simply will not be recognised by the driver.
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   43 +++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> index bbd09d8..292414f 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> @@ -62,4 +62,47 @@
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

I don't seem to have a patch that adds ape6evm_fixed_3v3
and it doesn't seem to be present in renesas-devel-20130722.

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

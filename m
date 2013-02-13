From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 04:01:14 +0000
Subject: Re: [PATCH/RFC v2 3/8] ARM: shmobile: SDHI and MMCIF interfaces to kzm9g-reference
Message-Id: <20130213040114.GG30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2013 at 07:38:27PM +0100, Guennadi Liakhovetski wrote:
> Add SDHI0 and SDHI2 interfaces to kzm9g-reference. With no pinctrl DT
> support we cannot use GPIO card-detection and regulator switching.
> Also update the MMCIF DT node to use all 8 data lines and avoid
> redundant information in DT.

This seems reasonable to me and I have added it to the
boards-kzm9g-reference branch which is targeted at v3.10.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> NOTE: With no DT pinctrl support this is very limited - no GPIO card 
> detection, no dynamically switchable regulators. But after all the 
> patching this brings interfaces up.
> 
> NOTE 2: I'm not sure the way MMCIF is added to .dtsi and then extended 
> here is a very good idea. Not all sh73a0 boards will want MMCIF, actually, 
> same holds for I2C. I see some examples, where device DT node templates 
> are provided in .dtsi with a 'status="disabled"' property. Then, if a 
> board wants to use that template it patches it with 'status="okay".' 
> However, what also confuses me, they don't use the '&' "patching" symbol. 
> E.g. see "sdi0_per1@80126000" node in snowball.dts and its template in 
> dbx5x0.dtsi.

I'm unsure too.

It was my understanding that I2C and MMCIF are part of the SoC and
thus should logically go in the SOC's dtsi file.

Do we actually have any sh73a0 boards that don't use I2C or MMCIF?
If not perhaps its a problem for another day.

> v2:
> 1. renamed regulators to match armadillo800eva
> 2. changed SDHI0/2 Vcc supply to 2.8V to match the original OCR mask from 
>    board-kzm9g.c. Schematics suggests it's actually 3.3V. No idea which is 
>    correct.
> 3. added "always-on" and "boot-on" regulator properties
> 4. fixed identical regulator node names
> 5. added a "bus-width" property to MMCIF to avoid running in 1-bit mode
> 6. removed unused CD IRQ on SDHI2
> 7. removed the optional vqmmc-supply on MMCIF - it isn't needed, if 
>    identical to vmmc-supply
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   42 ++++++++++++++++++++++--
>  arch/arm/mach-shmobile/board-kzm9g-reference.c |   21 ++++++++++++
>  2 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index 06f52f9..7fad4b9 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -27,15 +27,51 @@
>  		reg = <0x41000000 0x1e800000>;
>  	};
>  
> -	fixedregulator1v8: fixedregulator@0 {
> +	reg_1p8v: regulator@0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "fixed-1.8V";
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_2p8v: regulator@1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-2.8V";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	sdhi0: sdhi@0xee100000 {
> +		compatible = "renesas,shmobile-sdhi";
> +		reg = <0xee100000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 83 4
> +				0 84 4
> +				0 85 4>;
> +		vmmc-supply = <&reg_2p8v>;
> +		bus-width = <4>;
> +		toshiba,mmc-has-idle-wait;
> +	};
> +
> +	sdhi2: sdhi@0xee140000 {
> +		compatible = "renesas,shmobile-sdhi";
> +		reg = <0xee140000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 104 4
> +				0 105 4>;
> +		vmmc-supply = <&reg_2p8v>;
> +		bus-width = <4>;
> +		broken-cd;
> +		toshiba,mmc-wrprotect-disable;
> +		toshiba,mmc-has-idle-wait;
>  	};
>  };
>  
>  &mmcif {
> -	vmmc-supply = <&fixedregulator1v8>;
> -	vqmmc-supply = <&fixedregulator1v8>;
> +	bus-width = <8>;
> +	vmmc-supply = <&reg_1p8v>;
>  };
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index 6a1222e..534eee6 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -52,6 +52,27 @@ static void __init kzm_init(void)
>  	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
>  	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
>  
> +	/* enable SD */
> +	gpio_request(GPIO_FN_SDHIWP0,		NULL);
> +	gpio_request(GPIO_FN_SDHICD0,		NULL);
> +	gpio_request(GPIO_FN_SDHICMD0,		NULL);
> +	gpio_request(GPIO_FN_SDHICLK0,		NULL);
> +	gpio_request(GPIO_FN_SDHID0_3,		NULL);
> +	gpio_request(GPIO_FN_SDHID0_2,		NULL);
> +	gpio_request(GPIO_FN_SDHID0_1,		NULL);
> +	gpio_request(GPIO_FN_SDHID0_0,		NULL);
> +	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
> +	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
> +
> +	/* enable Micro SD */
> +	gpio_request(GPIO_FN_SDHID2_0,		NULL);
> +	gpio_request(GPIO_FN_SDHID2_1,		NULL);
> +	gpio_request(GPIO_FN_SDHID2_2,		NULL);
> +	gpio_request(GPIO_FN_SDHID2_3,		NULL);
> +	gpio_request(GPIO_FN_SDHICMD2,		NULL);
> +	gpio_request(GPIO_FN_SDHICLK2,		NULL);
> +	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
> +
>  	/* I2C 3 */
>  	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
>  	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
> -- 
> 1.7.2.5
> 

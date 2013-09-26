From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 26 Sep 2013 18:23:22 +0000
Subject: Re: [PATCH v2 5/5] ARM: shmobile: lager: (DEVEL) add CPUFreq support
Message-Id: <52447B9A.5090805@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de> <1380216060-14506-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1380216060-14506-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hello.

On 09/26/2013 09:21 PM, Guennadi Liakhovetski wrote:

> The Lager board uses a DA9210 voltage regulator to supply DVFS power to the
> CA15 cores on the r8a7790 SoC. This patch adds CPUFreq support for that
> board using the cpufreq-cpu0 driver.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---

> v2: added 'status = "okay";' to the i2c bus

>   arch/arm/boot/dts/r8a7790-lager-reference.dts  |   33 ++++++++++++++++++++++++
>   arch/arm/mach-shmobile/board-lager-reference.c |    4 ++-
>   2 files changed, 36 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
> index c462ef1..1ce0a97 100644
> --- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
> @@ -43,3 +43,36 @@
>   		};
>   	};
>   };
> +
> +&i2c3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +
> +	vdd_dvfs: da9210@68 {

   ePAPR spec [1] says: "The name of a node should be somewhat generic, 
reflecting the function of the device and not its precise programming model."
So I suggest "regulator" instead of "da9210".

> +		compatible = "diasemi,da9210";
> +		reg = <0x68>;
> +
> +		regulator-min-microvolt = <900000>;
> +		regulator-max-microvolt = <1000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
[...]
> diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
> index 1a1a4a8..2bc8bae 100644
> --- a/arch/arm/mach-shmobile/board-lager-reference.c
> +++ b/arch/arm/mach-shmobile/board-lager-reference.c
[...]
> @@ -29,7 +30,8 @@ static void __init lager_add_standard_devices(void)
>   	r8a7790_clock_init();
>
>   	r8a7790_add_dt_devices();
> -        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

    Hm, "drove-by" cleanup?

> +	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>   }
>
>   static const char *lager_boards_compat_dt[] __initdata = {

    Shouldn't the patch be split into .dts and .c parts, I wonder?

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei


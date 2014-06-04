From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Jun 2014 23:33:47 +0000
Subject: Re: [PATCH v2 2/8] ARM: shmobile: r8a7790/lager dts: Add DVFS parameters into cpu0 node for r8a7790
Message-Id: <20140604233347.GB27080@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <538DB950.6070203@bp.renesas.com>
In-Reply-To: <538DB950.6070203@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 03, 2014 at 09:02:24PM +0900, Gaku Inami wrote:
> From: Benoit Cousson <bcousson@baylibre.com>
> 
> Add needed information inside CPU0 for the generic cpufreq-cpu0 driver.
> 
> - voltage-tolerance = 1%
>   It reflects the tolerance for the CPU voltage defined inside the OPP
>   table. Due to the lack of proper OPP definition, use an arbitrary safe
>   value.
> - clock-latency = 300 us
>   Approximate worst-case latency to do a full DVFS transition for every
>   OPPs. Due to the lack of HW information, use an arbitrary safe value.
>   Note: The term transition-latency will be more accurate to define this
>   value since the clock transition latency is not the only parameter that
>   will define the overall DVFS transition.
> - operating-points = < kHz - uV >
>   List of 6 operating points. All of them are using the same voltage
>   since the valid Vmin voltage is not documented in the HW spec.
> - clocks
>   phandle to the CPU clock source. This clock source is used for all the
>   4 CortexA15 located inside the same cluster.
> 
> Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
> [gaku.inami.xw@bp.renesas.com: Change the setting of OPPs for ES2.0]
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Thanks, I have queued this up with Magnus's ack.

> ---
> 
> Changes since version 1:
> - changed "Signed-off-by" and "From" correctly.
> - added the setting of VDD.
> - changed the setting of OPPs for ES2.0
> - fixed subject.
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |    4 ++++
>  arch/arm/boot/dts/r8a7790.dtsi      |   11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 8428204..b9cbeda 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -338,3 +338,7 @@
>  		regulator-always-on;
>  	};
>  };
> +
> +&cpu0 {
> +	cpu0-supply = <&vdd_dvfs>;
> +};
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7ff2960..30f7104 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -44,6 +44,17 @@
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
>  			clock-frequency = <1300000000>;
> +			voltage-tolerance = <1>; /* 1% */
> +			clocks = <&cpg_clocks R8A7790_CLK_Z>;
> +			clock-latency = <300000>; /* 300 us */
> +
> +			/* kHz - uV - OPPs unknown yet */
> +			operating-points = <1400000 1000000>,
> +					   <1225000 1000000>,
> +					   <1050000 1000000>,
> +					   < 875000 1000000>,
> +					   < 700000 1000000>,
> +					   < 350000 1000000>;
>  		};
>  
>  		cpu1: cpu@1 {
> -- 
> 1.7.9.5
> 

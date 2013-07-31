From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Jul 2013 06:39:19 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: add PMU information to r8a7740.dtsi
Message-Id: <20130731063918.GC5090@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724035909.30648.64982.sendpatchset@w520>
In-Reply-To: <20130724035909.30648.64982.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org

On Wed, Jul 24, 2013 at 12:59:09PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add PMU information to r8a7740.dtsi. With this
> included Armadillo800eva DT reference may use the PMU.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up for v3.12 in the dt2 branch.

> ---
> 
>  Dry coded based on data sheet, not runtime tested.
> 
>  arch/arm/boot/dts/r8a7740.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a7740.dtsi
> +++ work/arch/arm/boot/dts/r8a7740.dtsi	2013-07-24 04:20:42.000000000 +0900
> @@ -32,6 +32,11 @@
>  		      <0xc2000000 0x1000>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupts = <0 83 4>;
> +	};
> +
>  	/* irqpin0: IRQ0 - IRQ7 */
>  	irqpin0: irqpin@e6900000 {
>  		compatible = "renesas,intc-irqpin";
> 

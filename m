From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Jul 2013 06:39:10 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: add PMU information to sh73a0.dtsi
Message-Id: <20130731063909.GB5090@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724034503.30609.21892.sendpatchset@w520>
In-Reply-To: <20130724034503.30609.21892.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, koba@kmckk.co.jp, linux-sh@vger.kernel.org

On Wed, Jul 24, 2013 at 12:45:03PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add PMU information to sh73a0.dtsi. With this
> included KZM9G DT reference may use the PMU.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up for v3.12 in the dt2 branch.

> ---
> 
>  arch/arm/boot/dts/sh73a0.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/sh73a0.dtsi
> +++ work/arch/arm/boot/dts/sh73a0.dtsi	2013-07-24 04:12:57.000000000 +0900
> @@ -38,6 +38,12 @@
>  		      <0xf0000100 0x100>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupts = <0 55 4>,
> +			     <0 56 4>;
> +	};
> +
>  	irqpin0: irqpin@e6900000 {
>  		compatible = "renesas,intc-irqpin";
>  		#interrupt-cells = <2>;
> 

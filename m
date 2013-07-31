From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Jul 2013 06:39:04 +0000
Subject: Re: [PATCH] ARM: shmobile: emev2: add PMU information to emev2.dtsi
Message-Id: <20130731063900.GA5090@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724034240.30596.52917.sendpatchset@w520>
In-Reply-To: <20130724034240.30596.52917.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, koba@kmckk.co.jp, linux-sh@vger.kernel.org

On Wed, Jul 24, 2013 at 12:42:40PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add PMU information to emev2.dtsi. With this
> included KZM9D DT reference may use the PMU.

Thanks, I will queue this up for v3.12 in the dt2 branch.

> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/emev2.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- 0009/arch/arm/boot/dts/emev2.dtsi
> +++ work/arch/arm/boot/dts/emev2.dtsi	2013-07-02 17:32:45.000000000 +0900
> @@ -46,6 +46,12 @@
>  		      <0xe0020000 0x0100>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupts = <0 120 4>,
> +			     <0 121 4>;
> +	};
> +
>  	sti@e0180000 {
>  		compatible = "renesas,em-sti";
>  		reg = <0xe0180000 0x54>;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 04:07:14 +0000
Subject: Re: [PATCH 01/05] ARM: shmobile: Add r8a7790 thermal device node to DTS
Message-Id: <20131121040712.GJ31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120075921.23557.23231.sendpatchset@w520>
 <20131120075930.23557.3517.sendpatchset@w520>
In-Reply-To: <20131120075930.23557.3517.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 04:59:30PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Hook up the r8a7790 thermal sensor to the DTS.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> ---
> 
>  arch/arm/boot/dts/r8a7790.dtsi |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- 0004/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 08:25:53.000000000 +0900
> @@ -162,6 +162,13 @@
>  		interrupt-controller;
>  	};
>  
> +	thermal@e61f0000 {
> +		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
> +		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> 

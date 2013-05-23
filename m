From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 May 2013 01:39:45 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove unused r8a73a4 GIC CPU interface DT bits
Message-Id: <20130523013944.GK22608@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130516060355.29253.21426.sendpatchset@w520>
In-Reply-To: <20130516060355.29253.21426.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 16, 2013 at 03:03:55PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove unused GIC CPU interface DT bits for r8a73a4.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks. Queued up for v3.11 in the soc-r8a74a4 branch.

> ---
> 
>  arch/arm/boot/dts/r8a73a4.dtsi |    6 ------
>  1 file changed, 6 deletions(-)
> 
> --- 0001/arch/arm/boot/dts/r8a73a4.dtsi
> +++ work/arch/arm/boot/dts/r8a73a4.dtsi	2013-05-15 14:40:15.000000000 +0900
> @@ -37,12 +37,6 @@
>  			<0 0xf1004000 0 0x2000>,
>  			<0 0xf1006000 0 0x2000>;
>  		interrupts = <1 9 0xf04>;
> -
> -		gic-cpuif@4 {
> -			compatible = "arm,gic-cpuif";
> -			cpuif-id = <4>;
> -			cpu = <&cpu0>;
> -		};
>  	};
>  
>  	timer {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

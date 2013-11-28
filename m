From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:55:24 +0000
Subject: Re: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM DT Ref
Message-Id: <20131128075522.GM24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131031031841.15992.74619.sendpatchset@w520>
In-Reply-To: <20131031031841.15992.74619.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 31, 2013 at 12:18:41PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add 1GiB of DRAM at 0x2_0000_0000 to support the full 2GiB
> of APE6EVM system memory also in case of DT reference.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.

> ---
> 
>  For correct run time operation regardless of kernel configuration
>  ARM patches 7863/1 and 7864/1 are needed.
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ work/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts	2013-10-31 11:46:51.000000000 +0900
> @@ -25,6 +25,11 @@
>  		reg = <0 0x40000000 0 0x40000000>;
>  	};
>  
> +	memory@200000000 {
> +		device_type = "memory";
> +		reg = <2 0x00000000 0 0x40000000>;
> +	};
> +
>  	vcc_mmc0: regulator@0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "MMC0 Vcc";
> 

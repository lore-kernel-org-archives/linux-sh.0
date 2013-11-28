From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:56:02 +0000
Subject: Re: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
Message-Id: <20131128075600.GN24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131031031549.15985.23547.sendpatchset@w520>
In-Reply-To: <20131031031549.15985.23547.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 31, 2013 at 12:15:49PM +0900, Magnus Damm wrote:
> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> Add 1GiB of DRAM at 0x2_0000_0000 to support the full 2GiB
> of APE6EVM system memory.
> 
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

Thanks, I have queued this up.

> 
>  For correct run time operation regardless of kernel configuration
>  ARM patches 7863/1 and 7864/1 are needed.
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts	2013-10-31 11:44:53.000000000 +0900
> @@ -24,6 +24,11 @@
>  		reg = <0 0x40000000 0 0x40000000>;
>  	};
>  
> +	memory@200000000 {
> +		device_type = "memory";
> +		reg = <2 0x00000000 0 0x40000000>;
> +	};
> +
>  	ape6evm_fixed_3v3: fixedregulator@0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "3V3";
> 

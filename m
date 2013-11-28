From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Nov 2013 07:56:43 +0000
Subject: Re: [PATCH] ARM: shmobile: Include all 4 GiB of memory on Lager DT Ref
Message-Id: <20131128075641.GP24146@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131031032436.16031.48305.sendpatchset@w520>
In-Reply-To: <20131031032436.16031.48305.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 31, 2013 at 12:24:36PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add 2GiB of DRAM at 0x1_8000_0000 to support the full 4GiB
> of Lager system memory in case of DT Reference.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.

> ---
> 
>  For correct run time operation regardless of kernel configuration
>  ARM patches 7863/1 and 7864/1 are needed.
> 
>  Written on top of renesas-devel-v3.12-rc7-20131030
> 
>  arch/arm/boot/dts/r8a7790-lager-reference.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a7790-lager-reference.dts
> +++ work/arch/arm/boot/dts/r8a7790-lager-reference.dts	2013-10-31 11:51:18.000000000 +0900
> @@ -25,6 +25,11 @@
>  		reg = <0 0x40000000 0 0x80000000>;
>  	};
>  
> +	memory@180000000 {
> +		device_type = "memory";
> +		reg = <1 0x80000000 0 0x80000000>;
> +	};
> +
>  	lbsc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> 

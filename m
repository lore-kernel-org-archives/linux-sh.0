From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 07 Mar 2012 21:57:58 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7779 L2 cache support
Message-Id: <201203072301.19787.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120301034803.12883.22696.sendpatchset@w520>
In-Reply-To: <20120301034803.12883.22696.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, March 01, 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> L2 Cache support for r8a7779. Settings taken from
> out-of-tree kernel patches by Kouei Abe.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied.

Thanks,
Rafael


> ---
> 
>  arch/arm/mach-shmobile/setup-r8a7779.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0007/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2012-03-01 12:28:07.000000000 +0900
> @@ -34,6 +34,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> +#include <asm/hardware/cache-l2x0.h>
>  
>  static struct map_desc r8a7779_io_desc[] __initdata = {
>  	/* 2M entity map for 0xf0000000 (MPCORE) */
> @@ -242,6 +243,10 @@ static struct platform_device *r8a7779_l
>  
>  void __init r8a7779_add_standard_devices(void)
>  {
> +#ifdef CONFIG_CACHE_L2X0
> +	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
> +	l2x0_init(__io(0xf0100000), 0x40470000, 0x82000fff);
> +#endif
>  	r8a7779_pm_init();
>  
>  	r8a7779_init_pm_domain(&r8a7779_sh4a);
> 
> 


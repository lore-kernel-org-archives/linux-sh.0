From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 00:23:25 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7779 Marzen legacy fix V2
Message-Id: <20150715002324.GE30642@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150714072522.2854.69938.sendpatchset@little-apple>
In-Reply-To: <20150714072522.2854.69938.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 14, 2015 at 04:25:22PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
> 
> As it is today Marzen multiplatform is working, but the legacy code
> is broken. This patch intends to leave multiplatform as-is but do
> a simple one-shot fix to unbreak the legacy code base.
> 
> Without this patch there is no preset delay and the TWD is defined
> both in C code and in DT. Solve the delay by invoking shmobile_init_delay()
> and simply disable TWD in case of building for legacy.
> 
> Marzen legacy code will be removed in the near future, but until then
> we may as well avoid breaking it.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>


Thanks, that does seem to improve things a lot.
I can now boot all the way to a nfs userspace :^)

Tested-by: Simon Horman <horms+renesas@verge.net.au>

I wonder if we should also add the following?

Fixes: f2a5473861cf ("clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast")


For the record, I found that after I enabled CONFIG_SMSC_PHY the boot
now gets as far as initialising SDHI.

> ---
> 
>  Developed and tested on top of renesas-devel-20150706-v4.2-rc1
> 
>  arch/arm/Kconfig                       |    1 -
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- 0001/arch/arm/Kconfig
> +++ work/arch/arm/Kconfig	2015-07-14 16:00:38.902366518 +0900
> @@ -626,7 +626,6 @@ config ARCH_SHMOBILE_LEGACY
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_ARM_SCU if SMP
> -	select HAVE_ARM_TWD if SMP
>  	select HAVE_SMP
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select MULTI_IRQ_HANDLER
> --- 0003/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-07-13 15:18:50.000000000 +0900
> @@ -677,6 +677,8 @@ void __init r8a7779_add_standard_devices
>  
>  void __init r8a7779_add_early_devices(void)
>  {
> +	shmobile_init_delay();
> +
>  	early_platform_add_devices(r8a7779_early_devices,
>  				   ARRAY_SIZE(r8a7779_early_devices));
>  
> 

From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 Aug 2014 03:55:17 +0000
Subject: Re: [PATCH] ARM: shmobile: ape6evm: Remove duplicate CPUFreq bits
Message-Id: <20140822035513.GR9099@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820131015.373.91949.sendpatchset@w520>
In-Reply-To: <20140820131015.373.91949.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 20, 2014 at 10:10:15PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> The CPUFreq platform device is already registered by
> shmobile_init_late(), so get rid of ape6evm specific bits.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up.

> ---
> 
>  Built of top of renesas-devel-20140820-v3.17-rc1
> 
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-ape6evm-reference.c
> +++ work/arch/arm/mach-shmobile/board-ape6evm-reference.c	2014-08-20 19:34:53.000000000 +0900
> @@ -50,7 +50,6 @@ static void __init ape6evm_add_standard_
>  
>  	r8a73a4_add_dt_devices();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
>  }
>  
>  static const char *ape6evm_boards_compat_dt[] __initdata = {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

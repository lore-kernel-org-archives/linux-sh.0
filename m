From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jun 2014 08:41:54 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Use shmobile_init_late() on r8a7790 DT-only
Message-Id: <20140606084151.GE27546@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606061347.13388.53582.sendpatchset@w520>
In-Reply-To: <20140606061347.13388.53582.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2014 at 03:13:47PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Tie in shmobile_init_late for the DT-only r8a7790 SoC
> Multiplatform support code. This will make sure that
> Suspend-to-RAM, CPUIdle and CPUFreq get initialized.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued this up.

> ---
> 
>  Changes since V1:
>  - Broke out patch from larger series
> 
>  arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-06 14:39:09.000000000 +0900
> @@ -318,6 +318,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8
>  	.smp		= smp_ops(r8a7790_smp_ops),
>  	.init_early	= shmobile_init_delay,
>  	.init_time	= rcar_gen2_timer_init,
> +	.init_late	= shmobile_init_late,
>  	.dt_compat	= r8a7790_boards_compat_dt,
>  MACHINE_END
>  #endif /* CONFIG_USE_OF */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

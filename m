From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Jun 2014 08:04:21 +0000
Subject: Re: [PATCH v2 01/07] ARM: shmobile: Allow use of boot code for non-SMP case
Message-Id: <20140625080417.GA8693@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606072010.14868.5474.sendpatchset@w520>
In-Reply-To: <20140606072010.14868.5474.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2014 at 04:20:10PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Allow build of platsmp.c and headsmp.S even though
> SMP is disabled in the kernel configuration. With
> this in place it is possible to share the reset
> vector setup code with power management code that
> needs to be built even though SMP is disabled.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Hi Magnus,

could you let me know what the status of this series is.
Should I queue it up?

> ---
> 
>  arch/arm/mach-shmobile/Makefile  |   11 +++++++----
>  arch/arm/mach-shmobile/headsmp.S |   13 ++++++++-----
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2014-06-05 10:49:20.000000000 +0900
> @@ -34,17 +34,17 @@ obj-$(CONFIG_ARCH_R8A7791)	+= clock-r8a7
>  obj-$(CONFIG_ARCH_R7S72100)	+= clock-r7s72100.o
>  endif
>  
> +# CPU reset vector handling objects
> +cpu-y				:= platsmp.o headsmp.o
> +
>  # SMP objects
> -smp-y				:= platsmp.o headsmp.o
> +smp-y				:= $(cpu-y)
>  smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o platsmp-apmu.o
>  smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o platsmp-apmu.o
>  smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
>  
> -# IRQ objects
> -obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
> -
>  # PM objects
>  obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> @@ -56,6 +56,9 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779
>  obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
>  
> +# IRQ objects
> +obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
> +
>  # Board objects
>  ifdef CONFIG_ARCH_SHMOBILE_MULTI
>  obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
> --- 0001/arch/arm/mach-shmobile/headsmp.S
> +++ work/arch/arm/mach-shmobile/headsmp.S	2014-06-05 10:48:14.000000000 +0900
> @@ -10,14 +10,17 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#include <linux/linkage.h>
>  #include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/threads.h>
>  #include <asm/memory.h>
>  
> +#ifdef CONFIG_SMP
>  ENTRY(shmobile_invalidate_start)
>  	bl	v7_invalidate_l1
>  	b	secondary_startup
>  ENDPROC(shmobile_invalidate_start)
> +#endif
>  
>  /*
>   * Reset vector for secondary CPUs.
> @@ -68,7 +71,7 @@ shmobile_smp_boot_find_mpidr:
>  
>  shmobile_smp_boot_next:
>  	add	r1, r1, #1
> -	cmp	r1, #CONFIG_NR_CPUS
> +	cmp	r1, #NR_CPUS
>  	blo	shmobile_smp_boot_find_mpidr
>  
>  	b	shmobile_smp_sleep
> @@ -85,10 +88,10 @@ ENDPROC(shmobile_smp_sleep)
>  
>  	.globl	shmobile_smp_mpidr
>  shmobile_smp_mpidr:
> -1:	.space	CONFIG_NR_CPUS * 4
> +1:	.space	NR_CPUS * 4
>  	.globl	shmobile_smp_fn
>  shmobile_smp_fn:
> -2:	.space	CONFIG_NR_CPUS * 4
> +2:	.space	NR_CPUS * 4
>  	.globl	shmobile_smp_arg
>  shmobile_smp_arg:
> -3:	.space	CONFIG_NR_CPUS * 4
> +3:	.space	NR_CPUS * 4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

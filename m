From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:08:35 +0000
Subject: Re: [PATCH 06/11] ARM: shmobile: r8a7793: add SMP support
Message-Id: <20150307000835.GI19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Mar 06, 2015 at 06:09:53PM +0100, Ulrich Hecht wrote:
> Enables SMP support, similar to other R-Car Gen2 SoCs.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [uli: moved rest handling to PM, minor adjustments]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

As you mentioned elsewhere there seems to be some scope for consolidating
this code with similar code for the r8a7791.

More comments follow...

> ---
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/r8a7793.h       |  1 +
>  arch/arm/mach-shmobile/setup-r8a7793.c |  2 +
>  arch/arm/mach-shmobile/smp-r8a7793.c   | 69 ++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/smp-r8a7793.c
> 
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index a104a24..b527a63 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -40,6 +40,7 @@ smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
>  smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
> +smp-$(CONFIG_ARCH_R8A7793)	+= smp-r8a7793.o
>  smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
>  
>  # PM objects
> diff --git a/arch/arm/mach-shmobile/r8a7793.h b/arch/arm/mach-shmobile/r8a7793.h
> index 78894c3..3703a38 100644
> --- a/arch/arm/mach-shmobile/r8a7793.h
> +++ b/arch/arm/mach-shmobile/r8a7793.h
> @@ -2,5 +2,6 @@
>  #define __ASM_R8A7793_H__
>  
>  void r8a7793_pm_init(void);
> +extern struct smp_operations r8a7793_smp_ops;
>  
>  #endif /* __ASM_R8A7793_H__ */
> diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
> index 1d2825c..d20cf2a 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7793.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7793.c
> @@ -17,6 +17,7 @@
>  #include <asm/mach/arch.h>
>  
>  #include "common.h"
> +#include "r8a7793.h"
>  #include "rcar-gen2.h"
>  
>  static const char *r8a7793_boards_compat_dt[] __initconst = {
> @@ -25,6 +26,7 @@ static const char *r8a7793_boards_compat_dt[] __initconst = {
>  };
>  
>  DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
> +	.smp		= smp_ops(r8a7793_smp_ops),
>  	.init_early	= shmobile_init_delay,
>  	.init_time	= rcar_gen2_timer_init,
>  	.init_late	= shmobile_init_late,
> diff --git a/arch/arm/mach-shmobile/smp-r8a7793.c b/arch/arm/mach-shmobile/smp-r8a7793.c
> new file mode 100644
> index 0000000..64941fe
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r8a7793.c
> @@ -0,0 +1,69 @@
> +/*
> + * SMP support for r8a7793
> + *
> + * Copyright (C) 2014 Renesas Electronics Corporation
> + * Copyright (C) 2015 Ulrich Hecht
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/smp.h>
> +#include <linux/io.h>
> +
> +#include <asm/smp_plat.h>
> +#include "platsmp-apmu.h"
> +
> +#include "common.h"
> +#include "pm-rcar.h"
> +#include "r8a7793.h"
> +#include "rcar-gen2.h"
> +
> +#define APMU		0xe6151000
> +#define CA15DBGRCR	0x1180
> +#define CA15RESCNT	0x0040
> +
> +static struct rcar_apmu_config r8a7793_apmu_config[] = {
> +	{
> +		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),

The above seems inconsistent with the r8a7791 where
0x188 is used as the size of the resource.

> +		.cpus = { 0, 1 },
> +	},
> +};
> +
> +static void __init r8a7793_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	void __iomem *p;
> +	u32 val;
> +
> +	/* let APMU code install data related to shmobile_boot_vector */
> +	shmobile_smp_apmu_prepare_cpus(max_cpus,
> +				       r8a7793_apmu_config,
> +				       ARRAY_SIZE(r8a7793_apmu_config));
> +
> +	/* setup for debug mode */
> +	if (rcar_gen2_read_mode_pins() & MD(21)) {
> +		p = ioremap_nocache(APMU, 0x2000);
> +		val = readl_relaxed(p + CA15DBGRCR);
> +		writel_relaxed((val | 0x01f80000), p + CA15DBGRCR);
> +		iounmap(p);

As you noted elsewhere, the above is inconsistent with the r8a7791 where an
error returned if debug mode is enabled: that is if the if condition is
true.

> +	}
> +
> +	r8a7793_pm_init();
> +}
> +
> +struct smp_operations r8a7793_smp_ops __initdata = {
> +	.smp_prepare_cpus	= r8a7793_smp_prepare_cpus,
> +	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_disable		= shmobile_smp_cpu_disable,
> +	.cpu_die		= shmobile_smp_apmu_cpu_die,
> +	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
> +#endif
> +};
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

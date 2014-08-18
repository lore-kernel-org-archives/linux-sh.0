From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:47:22 +0000
Subject: Re: [PATCH 2/8] ARM: shmobile: Initial r8a7794 SoC support
Message-Id: <20140818234722.GJ1623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:41PM +0200, Ulrich Hecht wrote:
> Initial support for the r8a7794 SoC, based on work by Hisashi Nakamura.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/Kconfig         |  4 ++++
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/Makefile.boot   |  1 +
>  arch/arm/mach-shmobile/setup-r8a7794.c | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 5814754..0ef01d4 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -41,6 +41,10 @@ config ARCH_R8A7791
>  	select RENESAS_IRQC
>  	select SYS_SUPPORTS_SH_CMT
>  
> +config ARCH_R8A7794
> +	bool "R-Car E2 (R8A77940)"
> +	select RENESAS_IRQC
> +
>  comment "Renesas ARM SoCs Board Type"
>  
>  config MACH_KOELSCH
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index 2eb2c5b..315784f 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
> +obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o setup-rcar-gen2.o
>  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
>  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
>  
> diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
> index a23e155..dbc0482 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -12,6 +12,7 @@ loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
>  loadaddr-$(CONFIG_MACH_LAGER) += 0x40008000
>  loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
>  loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
> +loadaddr-$(CONFIG_MACH_ALT) += 0x40008000
>  
>  __ZRELADDR	:= $(sort $(loadaddr-y))
>     zreladdr-y   += $(__ZRELADDR)
> diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
> new file mode 100644
> index 0000000..0c15d9f
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/setup-r8a7794.c
> @@ -0,0 +1,34 @@
> +/*
> + * r8a7794 processor support
> + *
> + * Copyright (C) 2014  Renesas Electronics Corporation
> + * Copyright (C) 2014  Ulrich Hecht
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
> +
> +#include <linux/of_platform.h>
> +#include "common.h"
> +#include "rcar-gen2.h"
> +#include <asm/mach/arch.h>
> +
> +#ifdef CONFIG_USE_OF
> +
> +static const char * const r8a7794_boards_compat_dt[] __initconst = {
> +	"renesas,r8a7794",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
> +	.init_early	= shmobile_init_delay,

I think the following should go here as such lines have recently
been added to other SoC setup files.

	.init_late      = shmobile_init_late,

> +	.init_time	= rcar_gen2_timer_init,
> +	.dt_compat	= r8a7794_boards_compat_dt,
> +MACHINE_END
> +#endif /* CONFIG_USE_OF */

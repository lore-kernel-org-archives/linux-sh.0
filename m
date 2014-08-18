From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:37:47 +0000
Subject: Re: [PATCH 3/8] ARM: shmobile: Initial r8a7794 Alt board support
Message-Id: <20140818233747.GE1623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:42PM +0200, Ulrich Hecht wrote:
> Minimal board support, based on work by Hisashi Nakamura.

I believe we should drop this patch and add Alt without a board file.
There are patches queued up to remove the board file for Genmai.
The one for kzm9d was removed long ago. And in general I believe
no-board-file is the direction we would like to go in.

Although I am recommending dropping this patch I would like to make a
comment on it. I have done so below.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/Kconfig               |  5 ++++
>  arch/arm/mach-shmobile/Makefile              |  1 +
>  arch/arm/mach-shmobile/board-alt-reference.c | 38 ++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/board-alt-reference.c
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 0ef01d4..9c4a670 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -62,6 +62,11 @@ config MACH_MARZEN
>  	depends on ARCH_R8A7779
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  
> +config MACH_ALT
> +	bool "Alt board"
> +	depends on ARCH_R8A7794
> +	select MICREL_PHY if SH_ETH
> +
>  comment "Renesas ARM SoCs System Configuration"
>  endif
>  
> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> index 315784f..ec0cd31 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -64,6 +64,7 @@ ifdef CONFIG_ARCH_SHMOBILE_MULTI
>  obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
>  obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
>  obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
> +obj-$(CONFIG_MACH_ALT)		+= board-alt-reference.o
>  else
>  obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
>  obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
> diff --git a/arch/arm/mach-shmobile/board-alt-reference.c b/arch/arm/mach-shmobile/board-alt-reference.c
> new file mode 100644
> index 0000000..c74935e
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/board-alt-reference.c
> @@ -0,0 +1,38 @@
> +/*
> + * Alt board support - Reference DT implementation
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
> +static void __init alt_add_standard_devices(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char * const alt_boards_compat_dt[] __initconst = {
> +	"renesas,alt-reference",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(ALT_DT, "alt")
> +	.init_early	= shmobile_init_delay,
> +	.init_time	= rcar_gen2_timer_init,
> +	.init_machine	= alt_add_standard_devices,
> +	.init_late	= shmobile_init_late,
> +	.dt_compat	= alt_boards_compat_dt,
> +MACHINE_END

I do not think you need to set .init_machine if there is only
a call to of_platform_populate() as of_platform_populate() is called
if .init_machine is NULL. I do think we want to only call 
of_platform_populate() and thus we do want .init_machine to be NULL.

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 18:03:27 +0000
Subject: Re: [RFC 3/3] ARM: shmobile: r8a7794: use generic "renesas,rcar-gen2" machine
Message-Id: <1713607.pbqI4tD1kC@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205413-9584-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205413-9584-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 21 May 2015 12:50:13 Ulrich Hecht wrote:
> Removes the unnecessary SoC-specific setup code and uses the generic
> R-Car Gen2 machine.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7794-alt.dts      |  2 +-
>  arch/arm/boot/dts/r8a7794.dtsi         |  2 +-
>  arch/arm/mach-shmobile/Makefile        |  1 -
>  arch/arm/mach-shmobile/setup-r8a7794.c | 33 ------------------------------
>  4 files changed, 2 insertions(+), 36 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c
> 
> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts
> b/arch/arm/boot/dts/r8a7794-alt.dts index c3b90f9..686179a 100644
> --- a/arch/arm/boot/dts/r8a7794-alt.dts
> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> @@ -13,7 +13,7 @@
> 
>  / {
>  	model = "Alt";
> -	compatible = "renesas,alt", "renesas,r8a7794";
> +	compatible = "renesas,alt", "renesas,r8a7794", "renesas,rcar-gen2";
> 
>  	aliases {
>  		serial0 = &scif2;
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index 01cf54f..5189356 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -14,7 +14,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
> 
>  / {
> -	compatible = "renesas,r8a7794";
> +	compatible = "renesas,r8a7794", "renesas,rcar-gen2";
>  	interrupt-parent = <&gic>;
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> diff --git a/arch/arm/mach-shmobile/Makefile
> b/arch/arm/mach-shmobile/Makefile index 81431c9..70f3700 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
>  obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
> -obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
>  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
>  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c
> b/arch/arm/mach-shmobile/setup-r8a7794.c deleted file mode 100644
> index d2b0930..0000000
> --- a/arch/arm/mach-shmobile/setup-r8a7794.c
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - * r8a7794 processor support
> - *
> - * Copyright (C) 2014  Renesas Electronics Corporation
> - * Copyright (C) 2014  Ulrich Hecht
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; version 2 of the License.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#include <linux/of_platform.h>
> -#include "common.h"
> -#include "rcar-gen2.h"
> -#include <asm/mach/arch.h>
> -
> -static const char * const r8a7794_boards_compat_dt[] __initconst = {
> -	"renesas,r8a7794",
> -	NULL,
> -};
> -
> -DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
> -	.init_early	= shmobile_init_delay,
> -	.init_late	= shmobile_init_late,
> -	.init_time	= rcar_gen2_timer_init,
> -	.reserve	= rcar_gen2_reserve,
> -	.dt_compat	= r8a7794_boards_compat_dt,
> -MACHINE_END

-- 
Regards,

Laurent Pinchart


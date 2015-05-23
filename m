From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 18:02:26 +0000
Subject: Re: [RFC 2/3] ARM: shmobile: r8a7793: use generic "renesas,rcar-gen2" machine
Message-Id: <2297771.6zOlWIIOB5@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205413-9584-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205413-9584-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 21 May 2015 12:50:12 Ulrich Hecht wrote:
> Removes the unnecessary SoC-specific setup code and uses the generic
> R-Car Gen2 machine.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7793-gose.dts     |  2 +-
>  arch/arm/boot/dts/r8a7793.dtsi         |  2 +-
>  arch/arm/mach-shmobile/Makefile        |  1 -
>  arch/arm/mach-shmobile/setup-r8a7793.c | 34 -------------------------------
>  4 files changed, 2 insertions(+), 37 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
> 
> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts
> b/arch/arm/boot/dts/r8a7793-gose.dts index 1edeba2..f6c5803 100644
> --- a/arch/arm/boot/dts/r8a7793-gose.dts
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts
> @@ -34,7 +34,7 @@
> 
>  / {
>  	model = "Gose";
> -	compatible = "renesas,gose", "renesas,r8a7793";
> +	compatible = "renesas,gose", "renesas,r8a7793", "renesas,rcar-gen2";
> 
>  	aliases {
>  		serial0 = &scif0;
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index 7ab3902..ea96479 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -13,7 +13,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
> 
>  / {
> -	compatible = "renesas,r8a7793";
> +	compatible = "renesas,r8a7793", "renesas,rcar-gen2";
>  	interrupt-parent = <&gic>;
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> diff --git a/arch/arm/mach-shmobile/Makefile
> b/arch/arm/mach-shmobile/Makefile index a8f5d5d..81431c9 100644
> --- a/arch/arm/mach-shmobile/Makefile
> +++ b/arch/arm/mach-shmobile/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
>  obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
>  obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
> -obj-$(CONFIG_ARCH_R8A7793)	+= setup-r8a7793.o
>  obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
>  obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
>  obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
> diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c
> b/arch/arm/mach-shmobile/setup-r8a7793.c deleted file mode 100644
> index 2d7f18a..0000000
> --- a/arch/arm/mach-shmobile/setup-r8a7793.c
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * r8a7793 processor support
> - *
> - * Copyright (C) 2015  Ulrich Hecht
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
> -#include <linux/init.h>
> -#include <asm/mach/arch.h>
> -
> -#include "common.h"
> -#include "r8a7793.h"
> -#include "rcar-gen2.h"
> -
> -static const char *r8a7793_boards_compat_dt[] __initconst = {
> -	"renesas,r8a7793",
> -	NULL,
> -};
> -
> -DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
> -	.init_early	= shmobile_init_delay,
> -	.init_time	= rcar_gen2_timer_init,
> -	.init_late	= shmobile_init_late,
> -	.reserve	= rcar_gen2_reserve,
> -	.dt_compat	= r8a7793_boards_compat_dt,
> -MACHINE_END

-- 
Regards,

Laurent Pinchart


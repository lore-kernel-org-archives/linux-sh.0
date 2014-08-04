From: Simon Horman <horms@verge.net.au>
Date: Mon, 04 Aug 2014 07:01:55 +0000
Subject: Re: [PATCH] ARM: shmobile: Rework multiplatform include workaround
Message-Id: <20140804070151.GA1889@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2014 at 09:25:15AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Now when the majority of the include files have moved from
> arch/arm/mach-shmobile/include/mach/ to arch/arm/mach-shmobile/
> remove the header include file workaround in the Makefile...
> 
> ... and add another workaround in irqs.h to cope with the fact
> that <mach/irqs.h> needs to be where it is until the PFC code
> has been updated to remove legacy non-DT interfaces.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written against renesas-devel-v3.16-rc7-20140729

Thanks, I have queued this up as a cleanup for v3.18.

> 
>  arch/arm/mach-shmobile/Makefile |    2 --
>  arch/arm/mach-shmobile/irqs.h   |    2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/Makefile
> +++ work/arch/arm/mach-shmobile/Makefile	2014-07-31 09:11:18.000000000 +0900
> @@ -2,8 +2,6 @@
>  # Makefile for the linux kernel.
>  #
>  
> -ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
> -
>  # Common objects
>  obj-y				:= timer.o console.o
>  
> --- 0001/arch/arm/mach-shmobile/irqs.h
> +++ work/arch/arm/mach-shmobile/irqs.h	2014-07-31 09:12:56.000000000 +0900
> @@ -2,7 +2,7 @@
>  #define __SHMOBILE_IRQS_H
>  
>  #include <linux/sh_intc.h>
> -#include <mach/irqs.h>
> +#include "include/mach/irqs.h"
>  
>  /* GIC */
>  #define gic_spi(nr)		((nr) + 32)
> 

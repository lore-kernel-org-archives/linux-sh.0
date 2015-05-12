From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 May 2015 06:50:01 +0000
Subject: Re: [PATCH v2 10/15] ARM: shmobile: r8a7793: add SMP support
Message-Id: <1543071.BYqSDIJCJa@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 30 April 2015 16:18:59 Ulrich Hecht wrote:
> Enables SMP support, similar to other R-Car Gen2 SoCs.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [uli: moved reset handling to PM, minor adjustments]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/r8a7793.h       |  6 +++
>  arch/arm/mach-shmobile/setup-r8a7793.c |  2 +
>  arch/arm/mach-shmobile/smp-r8a7793.c   | 67 +++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/r8a7793.h
>  create mode 100644 arch/arm/mach-shmobile/smp-r8a7793.c

[snip]

> diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c
> b/arch/arm/mach-shmobile/setup-r8a7793.c index 1d2825c..d20cf2a 100644
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
> @@ -25,6 +26,7 @@ static const char *r8a7793_boards_compat_dt[] __initconst
> = { };
> 
>  DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
> +	.smp		= smp_ops(r8a7793_smp_ops),

As mentioned in my review of v1, ARM has a CPU_METHOD_OF_DECLARE() macro which 
seems to be preferred over setting the machine definition .smp field directly. 
Using it would make it easier to merge the machine definitions for the Gen2 
SoCs.

>  	.init_early	= shmobile_init_delay,
>  	.init_time	= rcar_gen2_timer_init,
>  	.init_late	= shmobile_init_late,

-- 
Regards,

Laurent Pinchart


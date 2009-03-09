From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Mar 2009 16:10:57 +0000
Subject: Re: [PATCH] sh: SuperH Mobile suspend support
Message-Id: <20090309161057.GB31103@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090309105143.23622.42915.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090309105143.23622.42915.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 09, 2009 at 07:51:43PM +0900, Magnus Damm wrote:
> --- 0004/arch/sh/Kconfig
> +++ work/arch/sh/Kconfig	2009-03-09 19:36:29.000000000 +0900
> @@ -159,6 +159,7 @@ config CPU_SH4
>  	select CPU_HAS_SR_RB
>  	select CPU_HAS_PTEA if !CPU_SH4A || CPU_SHX2
>  	select CPU_HAS_FPU if !CPU_SH4AL_DSP
> +	select ARCH_SUSPEND_POSSIBLE
>  
>  config CPU_SH4A
>  	bool

This is bogus, as this is all SH-Mobile specific. The easiest option is
probably to define a CPU_SHMOBILE that all of these CPUs can select, and
then moving all of this in to arch/sh/kernel/cpu/shmobile/. We've done
similar things on the ARM side for code-sharing between SH-Mobile G3 and
G4 for example.

> --- 0005/arch/sh/include/asm/suspend.h
> +++ work/arch/sh/include/asm/suspend.h	2009-03-09 19:36:29.000000000 +0900
> @@ -1,6 +1,7 @@
>  #ifndef _ASM_SH_SUSPEND_H
>  #define _ASM_SH_SUSPEND_H
>  
> +#ifndef __ASSEMBLY__
>  static inline int arch_prepare_suspend(void) { return 0; }
>  
>  #include <asm/ptrace.h>
> @@ -9,5 +10,16 @@ struct swsusp_arch_regs {
>  	struct pt_regs user_regs;
>  	unsigned long bank1_regs[8];
>  };
> +#endif
> +
> +#define SUSP_SH_SLEEP		(1 << 0) /* Regular sleep mode */
> +#define SUSP_SH_STANDBY		(1 << 1) /* Software standby mode */
> +#define SUSP_SH_RSTANDBY	(1 << 2) /* R-standby mode */
> +#define SUSP_SH_USTANDBY	(1 << 3) /* U-standby mode */
> +#define SUSP_SH_SF		(1 << 4) /* Enable self-refresh */
> +
This probably wants a bit more explanation, as it's not entirely obvious
for folks not familiar with SH-Mobile internals what standby modes are
generic SH vs SH-Mobile specific.

> +extern const unsigned char do_standby[];
> +extern const unsigned int do_standby_size;
> +
These are pretty uninspired globals, please use something more
definitive. (ie, shmobile_enter_standby/shmobile_standby_size or
something similar).

> +static void set_vbr(void *base)
> +{
> +	asm volatile("ldc	%0, vbr"
> +		     : /* no output */
> +		     : "r" (base)
> +		     : "memory");
> +}
> +
Just toss this in an asm/ header somewhere, it's not worth reimplementing
all over the place. Although for a single instruction it doesn't really
add much, you may as well just open-code it.

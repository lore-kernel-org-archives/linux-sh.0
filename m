From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Mar 2009 06:57:40 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <20090306065739.GA14735@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2009 at 03:41:56PM +0900, Magnus Damm wrote:
> --- /dev/null
> +++ work/arch/sh/include/asm/suspend.h	2009-03-02 15:23:59.000000000 +0900
> @@ -0,0 +1,14 @@
> +#ifndef _ASM_SH_SUSPEND_H
> +#define _ASM_SH_SUSPEND_H
> +
> +static inline int arch_prepare_suspend(void) { return 0; }
> +extern const void __nosave_begin, __nosave_end;
> +
These belong in asm/sections.h.

> --- 0001/arch/sh/kernel/Makefile_32
> +++ work/arch/sh/kernel/Makefile_32	2009-03-02 15:23:59.000000000 +0900
> @@ -30,5 +30,6 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
>  obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
> +obj-$(CONFIG_PM)		+= pm.o
>  
As this is hibernation specific, you should just use CONFIG_HIBERNATION
here. pm.c is also a bit ambiguous, this probably ought to be named
something more accurate, like swsusp.c or suspend.c.

> --- 0001/arch/sh/kernel/asm-offsets.c
> +++ work/arch/sh/kernel/asm-offsets.c	2009-03-02 15:23:59.000000000 +0900
> @@ -25,5 +27,11 @@ int main(void)
>  	DEFINE(TI_PRE_COUNT,	offsetof(struct thread_info, preempt_count));
>  	DEFINE(TI_RESTART_BLOCK,offsetof(struct thread_info, restart_block));
>  
> +#ifdef CONFIG_HIBERNATION
> +	DEFINE(pbe_address, offsetof(struct pbe, address));
> +	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
> +	DEFINE(pbe_next, offsetof(struct pbe, next));
> +	DEFINE(SWSUSP_ARCH_REGS_SIZE, sizeof(struct swsusp_arch_regs));
> +#endif

These should all be upper-case.

> --- 0001/arch/sh/kernel/cpu/sh3/entry.S
> +++ work/arch/sh/kernel/cpu/sh3/entry.S	2009-03-02 15:26:57.000000000 +0900
> @@ -323,6 +323,76 @@ skip_restore:
>  #endif
>  7:	.long	0x30000000
>  
> +#ifdef CONFIG_HIBERNATION
> +! swsusp_arch_resume()
> +! - copy restore_pblist pages
> +! - restore registers from swsusp_arch_regs_cpu0
> +
> +ENTRY(swsusp_arch_resume)
> +	mov.l	4f, r15
> +	mov.l	1f, r4
> +	mov.l	@r4, r4
> +
Please split all of this out in to a swsusp.S instead of hacking entry.S
directly.

> +copy_loop:
> +	mov	r4, r0
> +	cmp/eq	#0, r0
> +	bt	do_restore_regs
> +
tst works for this, too.

> +	mov.l	@(pbe_address, r4), r2
> +	mov.l	@(pbe_orig_address, r4), r5
> +
> +	mov.l	2f, r3
> +	shlr2	r3
> +	shlr2	r3

Consider using PAGE_SHIFT, or shifting and masking PAGE_SIZE in place.
The pre-processor can break it down in to manageable chunks for you
without having to resort to the memory load.

> +copy_page:

Please use a better name that isn't already in the global namespace.

> --- /dev/null
> +++ work/arch/sh/kernel/pm.c	2009-03-02 15:23:59.000000000 +0900
> @@ -0,0 +1,39 @@
> +/*
> + * pm.c - SuperH power management code
> + *
> + * Copyright (C) 2009 Magnus Damm
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/suspend.h>
> +#include <asm/suspend.h>
> +#include <asm/tlbflush.h>
> +#include <asm/page.h>
> +#include <asm/fpu.h>
> +
> +#ifdef CONFIG_HIBERNATION
> +struct swsusp_arch_regs swsusp_arch_regs_cpu0;
> +
If you fix up the Makefile rule, you don't need the ifdef here.

Also, do you need to pre-zero swsusp_arch_regs_cpu0? Presumably this code
is also only geared at UP?

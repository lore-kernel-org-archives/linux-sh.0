From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 07 Apr 2008 01:50:04 +0000
Subject: Re: [PATCH] sh: cpuvec prototype for sh7722
Message-Id: <20080407015004.GB11221@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080402014915.21660.4184.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080402014915.21660.4184.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 02, 2008 at 10:49:15AM +0900, Magnus Damm wrote:
> This patch contains my cpuvec prototype for sh7722. The idea behind
> cpuvec is that we need something similar to machvec, but cpu specific.
> 
> Commonly used data structures such as platform device lists and intc
> controller data are pointed out directly by the cpuvec struct. This
> is convenient since it allows us to locate cpu specific platform data
> early in the boot process. Think serial port data for early printk,
> tmu information for the timers, pci bridge base addresses and so on.
> 
> Matching is done by comparing the detected cpu_type enum with the
> one present in the cpuvec. Seems to work well.
> 
> I'd be happy to convert the rest of the cpu code, just let me know
> if the currect struct sh_cpu_vector is good enough.
> 
The general idea seems fine, but I don't think it's appropriate to have
platform device data as part of the vector itself. Having a device setup
callback where the CPU setup code can register all of its devices is
fine, but that should be the end of the abstraction.

We already have cases today (ie, SH4-202) where on-chip devices are
mapped under a differing bus abstraction. There's no reason to drag this
sort of information around, as we're never going to tear these devices
down anyways.

> --- /dev/null
> +++ work/arch/sh/kernel/cpuvec.c	2008-04-01 18:33:06.000000000 +0900
> @@ -0,0 +1,65 @@
> +/*
> + * arch/sh/kernel/cpuvec.c
> + *
> + * SuperH cpu vector setup code, yanked from machvec.c
> + *
> + *  Copyright (C) 1999 Niibe Yutaka
> + *  Copyright (C) 2002 - 2007 Paul Mundt
> + *  Copyright (C) 2008 Magnus Damm
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +#include <linux/init.h>
> +#include <asm/processor.h>
> +#include <asm/cpuvec.h>
> +#include <asm/sections.h>
> +
This has almost 100% overlap with the machvec.c, lets just macroify that
and have it handle both the mach and cpu vec cases instead.

> --- 0001/arch/sh/kernel/irq.c
> +++ work/arch/sh/kernel/irq.c	2008-04-01 18:16:31.000000000 +0900
> @@ -12,6 +12,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/seq_file.h>
>  #include <asm/processor.h>
> +#include <asm/cpuvec.h>
>  #include <asm/machvec.h>
>  #include <asm/uaccess.h>
>  #include <asm/thread_info.h>
> @@ -246,9 +247,20 @@ asmlinkage void do_softirq(void)
>  }
>  #endif
>  
> +void __init plat_irq_setup_pins(int mode)
> +{
> +	if (sh_cv.setup_irq_pins)
> +		sh_cv.setup_irq_pins(mode);
> +}
> +
>  void __init init_IRQ(void)
>  {
> -	plat_irq_setup();
> +	/* Cpu-specific setup first */
> +	if (sh_cv.intc)
> +		register_intc_controller(sh_cv.intc);
> +
> +	if (sh_cv.setup_irq)
> +		sh_cv.setup_irq();
>  
>  	/* Perform the machine specific initialisation */
>  	if (sh_mv.mv_init_irq)

What exactly does this buy us? If we already have a CPU-specific IRQ
setup, we can do the registration there. Some CPUs may also have multiple
controllers, so the intc abstraction here isn't really useful.

> @@ -318,30 +320,22 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  }
>  
> -static const char *cpu_name[] = {
> -	[CPU_SH7203]	= "SH7203",	[CPU_SH7263]	= "SH7263",
> -	[CPU_SH7206]	= "SH7206",	[CPU_SH7619]	= "SH7619",
> -	[CPU_SH7705]	= "SH7705",	[CPU_SH7706]	= "SH7706",
> -	[CPU_SH7707]	= "SH7707",	[CPU_SH7708]	= "SH7708",
> -	[CPU_SH7709]	= "SH7709",	[CPU_SH7710]	= "SH7710",
> -	[CPU_SH7712]	= "SH7712",	[CPU_SH7720]	= "SH7720",
> -	[CPU_SH7721]	= "SH7721",	[CPU_SH7729]	= "SH7729",
> -	[CPU_SH7750]	= "SH7750",	[CPU_SH7750S]	= "SH7750S",
> -	[CPU_SH7750R]	= "SH7750R",	[CPU_SH7751]	= "SH7751",
> -	[CPU_SH7751R]	= "SH7751R",	[CPU_SH7760]	= "SH7760",
> -	[CPU_SH4_202]	= "SH4-202",	[CPU_SH4_501]	= "SH4-501",
> -	[CPU_SH7763]	= "SH7763",	[CPU_SH7770]	= "SH7770",
> -	[CPU_SH7780]	= "SH7780",	[CPU_SH7781]	= "SH7781",
> -	[CPU_SH7343]	= "SH7343",	[CPU_SH7785]	= "SH7785",
> -	[CPU_SH7722]	= "SH7722",	[CPU_SHX3]	= "SH-X3",
> -	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
> -	[CPU_MXG]	= "MX-G",
> -	[CPU_SH7366]	= "SH7366",	[CPU_SH_NONE]	= "Unknown"
> -};
> +static int __init devices_setup(void)
> +{
> +	int ret = 0;
> +
> +	if (sh_cv.devices)
> +		ret = platform_add_devices(sh_cv.devices, sh_cv.nr_devices);
> +	if (!ret && sh_cv.setup_devices)
> +		ret = sh_cv.setup_devices();
> +
> +	return ret;
> +}
> +__initcall(devices_setup);
>  
This conversion also needs to be incremental, we are not going to break
bisect on every possible CPU except the one you happen to be converting.

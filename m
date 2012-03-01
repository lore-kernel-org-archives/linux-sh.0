From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 01 Mar 2012 21:21:14 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: rename clk_init() to shmobile_clk_init()
Message-Id: <201203012221.14287.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120229124130.29066.74120.sendpatchset@w520>
In-Reply-To: <20120229124130.29066.74120.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, February 29, 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Rename clk_init() to shmobile_clk_init() to avoid a potential
> future name space collision with the common clock framework.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Paul, would you mind if I took this patchset into the renesas tree for v3.4?

Rafael


> ---
> 
>  arch/arm/mach-shmobile/clock-r8a7740.c       |    2 +-
>  arch/arm/mach-shmobile/clock-r8a7779.c       |    2 +-
>  arch/arm/mach-shmobile/clock-sh7367.c        |    2 +-
>  arch/arm/mach-shmobile/clock-sh7372.c        |    2 +-
>  arch/arm/mach-shmobile/clock-sh7377.c        |    2 +-
>  arch/arm/mach-shmobile/clock-sh73a0.c        |    2 +-
>  arch/arm/mach-shmobile/clock.c               |    2 +-
>  arch/arm/mach-shmobile/include/mach/common.h |    2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- 0015/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ work/arch/arm/mach-shmobile/clock-r8a7740.c	2012-02-29 20:59:39.000000000 +0900
> @@ -376,7 +376,7 @@ void __init r8a7740_clock_init(u8 md_ck)
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)
> -		clk_init();
> +		shmobile_clk_init();
>  	else
>  		panic("failed to setup r8a7740 clocks\n");
>  }
> --- 0016/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ work/arch/arm/mach-shmobile/clock-r8a7779.c	2012-02-29 20:59:53.000000000 +0900
> @@ -170,7 +170,7 @@ void __init r8a7779_clock_init(void)
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)
> -		clk_init();
> +		shmobile_clk_init();
>  	else
>  		panic("failed to setup r8a7779 clocks\n");
>  }
> --- 0014/arch/arm/mach-shmobile/clock-sh7367.c
> +++ work/arch/arm/mach-shmobile/clock-sh7367.c	2012-02-29 21:00:12.000000000 +0900
> @@ -349,7 +349,7 @@ void __init sh7367_clock_init(void)
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)
> -		clk_init();
> +		shmobile_clk_init();
>  	else
>  		panic("failed to setup sh7367 clocks\n");
>  }
> --- 0012/arch/arm/mach-shmobile/clock-sh7372.c
> +++ work/arch/arm/mach-shmobile/clock-sh7372.c	2012-02-29 21:00:34.000000000 +0900
> @@ -710,7 +710,7 @@ void __init sh7372_clock_init(void)
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)
> -		clk_init();
> +		shmobile_clk_init();
>  	else
>  		panic("failed to setup sh7372 clocks\n");
>  
> --- 0013/arch/arm/mach-shmobile/clock-sh7377.c
> +++ work/arch/arm/mach-shmobile/clock-sh7377.c	2012-02-29 21:00:25.000000000 +0900
> @@ -360,7 +360,7 @@ void __init sh7377_clock_init(void)
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)
> -		clk_init();
> +		shmobile_clk_init();
>  	else
>  		panic("failed to setup sh7377 clocks\n");
>  }
> --- 0011/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2012-02-29 21:00:48.000000000 +0900
> @@ -620,7 +620,7 @@ void __init sh73a0_clock_init(void)
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>  
>  	if (!ret)
> -		clk_init();
> +		shmobile_clk_init();
>  	else
>  		panic("failed to setup sh73a0 clocks\n");
>  }
> --- 0001/arch/arm/mach-shmobile/clock.c
> +++ work/arch/arm/mach-shmobile/clock.c	2012-02-29 20:58:43.000000000 +0900
> @@ -24,7 +24,7 @@
>  #include <linux/sh_clk.h>
>  #include <linux/export.h>
>  
> -int __init clk_init(void)
> +int __init shmobile_clk_init(void)
>  {
>  	/* Kick the child clocks.. */
>  	recalculate_root_clocks();
> --- 0008/arch/arm/mach-shmobile/include/mach/common.h
> +++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-02-29 20:59:15.000000000 +0900
> @@ -6,7 +6,7 @@ extern void shmobile_setup_console(void)
>  extern void shmobile_secondary_vector(void);
>  extern int shmobile_platform_cpu_kill(unsigned int cpu);
>  struct clk;
> -extern int clk_init(void);
> +extern int shmobile_clk_init(void);
>  extern void shmobile_handle_irq_intc(struct pt_regs *);
>  extern struct platform_suspend_ops shmobile_suspend_ops;
>  struct cpuidle_driver;
> 
> 


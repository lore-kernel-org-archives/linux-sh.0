From: Simon Horman <horms@verge.net.au>
Date: Mon, 09 Jul 2012 01:19:35 +0000
Subject: Re: [PATCH] ARM: shmobile: Build code depending on PM only if PM is set
Message-Id: <20120709011935.GE28823@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201207090015.12531.rjw@sisk.pl>
In-Reply-To: <201207090015.12531.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 09, 2012 at 12:15:12AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> There are a few files under arch/arm/mach-shmobile/ whose entire
> contents depend on CONFIG_PM, but they are compiled even if
> CONFIG_PM is unset.  It is cleaner to modify the Makefile to
> avoid building those files entirely for CONFIG_PM unset and
> remove #ifdef CONFIG_PM directives from them.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/arm/mach-shmobile/Makefile              |    4 +++-
>  arch/arm/mach-shmobile/include/mach/common.h |    4 ++++
>  arch/arm/mach-shmobile/pm-r8a7740.c          |    3 ---
>  arch/arm/mach-shmobile/pm-rmobile.c          |    2 --
>  arch/arm/mach-shmobile/pm-sh7372.c           |    4 ----
>  5 files changed, 7 insertions(+), 10 deletions(-)
> 
> Index: linux/arch/arm/mach-shmobile/Makefile
> =================================> --- linux.orig/arch/arm/mach-shmobile/Makefile
> +++ linux/arch/arm/mach-shmobile/Makefile
> @@ -37,11 +37,13 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.
>  obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc.o
>  
>  # PM objects
> -obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
> +ifeq ($(CONFIG_PM),y)
> +obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
>  obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
>  obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
> +endif
>  obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
>  
>  # Board objects
> Index: linux/arch/arm/mach-shmobile/include/mach/common.h
> =================================> --- linux.orig/arch/arm/mach-shmobile/include/mach/common.h
> +++ linux/arch/arm/mach-shmobile/include/mach/common.h
> @@ -41,7 +41,11 @@ extern void sh7372_add_early_devices(voi
>  extern void sh7372_add_standard_devices(void);
>  extern void sh7372_clock_init(void);
>  extern void sh7372_pinmux_init(void);
> +#ifdef CONFIG_PM
>  extern void sh7372_pm_init(void);
> +#else
> +static inline void sh7372_pm_init(void) {}

This seems to slightly alter the behaviour in the case where
CONFIG_PM is not set. I'm unsure if that is a problem or not.

> +#endif
>  extern void sh7372_resume_core_standby_sysc(void);
>  extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
>  extern struct clk sh7372_extal1_clk;
> Index: linux/arch/arm/mach-shmobile/pm-r8a7740.c
> =================================> --- linux.orig/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ linux/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -11,7 +11,6 @@
>  #include <linux/console.h>
>  #include <mach/pm-rmobile.h>
>  
> -#ifdef CONFIG_PM
>  static int r8a7740_pd_a4s_suspend(void)
>  {
>  	/*
> @@ -50,5 +49,3 @@ struct rmobile_pm_domain r8a7740_pd_a4lc
>  	.genpd.name	= "A4LC",
>  	.bit_shift	= 1,
>  };
> -
> -#endif /* CONFIG_PM */
> Index: linux/arch/arm/mach-shmobile/pm-rmobile.c
> =================================> --- linux.orig/arch/arm/mach-shmobile/pm-rmobile.c
> +++ linux/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -27,7 +27,6 @@
>  #define PSTR_RETRIES	100
>  #define PSTR_DELAY_US	10
>  
> -#ifdef CONFIG_PM
>  static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
>  {
>  	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
> @@ -164,4 +163,3 @@ void rmobile_pm_add_subdomain(struct rmo
>  {
>  	pm_genpd_add_subdomain(&rmobile_pd->genpd, &rmobile_sd->genpd);
>  }
> -#endif /* CONFIG_PM */
> Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
> =================================> --- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
> +++ linux/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -69,8 +69,6 @@
>  /* AP-System Core */
>  #define APARMBAREA 0xe6f10020
>  
> -#ifdef CONFIG_PM
> -
>  struct rmobile_pm_domain sh7372_pd_a4lc = {
>  	.genpd.name = "A4LC",
>  	.bit_shift = 1,
> @@ -149,8 +147,6 @@ struct rmobile_pm_domain sh7372_pd_a3sg
>  	.bit_shift = 13,
>  };
>  
> -#endif /* CONFIG_PM */
> -
>  #ifdef CONFIG_SUSPEND
>  static void sh7372_set_reset_vector(unsigned long address)
>  {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

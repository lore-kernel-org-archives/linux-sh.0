From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Sep 2014 04:25:36 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Cleanup PM Kconfig usage
Message-Id: <20140930042535.GC24253@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904033942.22881.84361.sendpatchset@w520>
In-Reply-To: <20140904033942.22881.84361.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 24, 2014 at 09:54:49AM +0900, Simon Horman wrote:
> On Thu, Sep 04, 2014 at 08:31:45AM +0200, Geert Uytterhoeven wrote:
> > Hi Magnus,
> > 
> > On Thu, Sep 4, 2014 at 5:39 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > > @@ -58,7 +58,9 @@ void __init r8a7740_init_pm_domains(void
> > >         rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
> > >         pm_genpd_add_subdomain_names("A4S", "A3SP");
> > >  }
> > > -#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> > > +#else
> > > +void r8a7740_init_pm_domains(void) {}
> > > +#endif
> > >
> > >  #ifdef CONFIG_SUSPEND
> > >  static int r8a7740_enter_suspend(suspend_state_t suspend_state)
> > > --- 0001/arch/arm/mach-shmobile/r8a7740.h
> > > +++ work/arch/arm/mach-shmobile/r8a7740.h       2014-09-04 12:29:12.000000000 +0900
> > > @@ -52,11 +52,6 @@ extern void r8a7740_add_standard_devices
> > >  extern void r8a7740_clock_init(u8 md_ck);
> > >  extern void r8a7740_pinmux_init(void);
> > >  extern void r8a7740_pm_init(void);
> > > -
> > > -#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> > > -extern void __init r8a7740_init_pm_domains(void);
> > > -#else
> > > -static inline void r8a7740_init_pm_domains(void) {}
> > > -#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> > > +extern void r8a7740_init_pm_domains(void);
> > >
> > >  #endif /* __ASM_R8A7740_H__ */
> > 
> > Why do you make r8a7740_init_pm_domains() out-of-line in the
> > !CONFIG_PM_RMOBILE case?
> > It increases code size (call to an empty function that cannot be optimized
> > away), and prevents us from building pm-r8a7740.c conditionally on
> > CONFIG_PM_RMOBILE and CONFIG_ARCH_R8A7740 in the future.
> > 
> > For the latter, we can turn pm-rmobile into a library, and do something
> > like
> > 
> > pm-rmobile-objs-$(CONFIG_ARCH_R8A7740)      += pm-r8a7740.o
> 
> This seems to have slipped through the cracks.

Geert, are you happy with this?

> For the first part of the problem how about this update to Magnus's patch?
> 
> [PATCH v1.1] ARM: shmobile: r8a7740: Cleanup PM Kconfig usage
> 
> Simplify the r8a7740 PM code by using CONFIG_PM_RMOBILE instead
> of having a complex #if expression embedded in the C code.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> [horms+renesas@verge.net.au: do not make r8a7740_init_pm_domains
>  out-of-line for !CONFIG_PM_RMOBILE case]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/pm-r8a7740.c | 4 ++--
>  arch/arm/mach-shmobile/r8a7740.h    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
> index e3f1464..225be5e 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -13,7 +13,7 @@
>  #include "common.h"
>  #include "pm-rmobile.h"
>  
> -#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> +#ifdef CONFIG_PM_RMOBILE
>  static int r8a7740_pd_a4s_suspend(void)
>  {
>  	/*
> @@ -56,7 +56,7 @@ void __init r8a7740_init_pm_domains(void)
>  	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
>  	pm_genpd_add_subdomain_names("A4S", "A3SP");
>  }
> -#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> +#endif
>  
>  #ifdef CONFIG_SUSPEND
>  static int r8a7740_enter_suspend(suspend_state_t suspend_state)
> diff --git a/arch/arm/mach-shmobile/r8a7740.h b/arch/arm/mach-shmobile/r8a7740.h
> index f369b4b..5ba292e 100644
> --- a/arch/arm/mach-shmobile/r8a7740.h
> +++ b/arch/arm/mach-shmobile/r8a7740.h
> @@ -53,10 +53,10 @@ extern void r8a7740_clock_init(u8 md_ck);
>  extern void r8a7740_pinmux_init(void);
>  extern void r8a7740_pm_init(void);
>  
> -#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> +#ifdef CONFIG_PM_RMOBILE
>  extern void __init r8a7740_init_pm_domains(void);
>  #else
>  static inline void r8a7740_init_pm_domains(void) {}
> -#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> +#endif
>  
>  #endif /* __ASM_R8A7740_H__ */
> -- 
> 2.0.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

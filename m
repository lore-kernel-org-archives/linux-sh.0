From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Aug 2014 01:03:49 +0000
Subject: Re: [PATCH] ARM: shmobile: Partial build of pm-rmobile.c for multiplatform
Message-Id: <20140811010345.GG26570@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140808105923.2628.30007.sendpatchset@w520>
In-Reply-To: <20140808105923.2628.30007.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 08, 2014 at 07:59:23PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Disconnect Multiplatform PM domain enablement and
> SoC specific Multiplatform enablement by allowing
> to build pm-rmobile.c with parts of it disabled.
> 
> This way it is possible to start using r8a7740
> with Multiplatform before PM domain DT is ready.

This seems to disconnect PM domain enablement and
all Multiplatform enablement. It doesn't seem very SoC specific to me.

Would it be possible to define a new Kconfig symbol,
say PM_RMOBILE, which is only selected when the code in
pm-rmobile.c is wanted?

It could even be used in the Makefile to allow us
to get rid of the big #ifdef in pm-rmobile.c.


Alternatively, if you want to keep the code as below perhaps
you could update the changelog to note that the intersection
of multiplatform and pm-rmobile only occurs on the
r8a7740 at this time and is not likely to occur anywhere else in
the forseeable future.

> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Built on top of renesas-devel-v3.16-20140808
> 
>  arch/arm/mach-shmobile/pm-rmobile.c |    4 ++--
>  arch/arm/mach-shmobile/pm-rmobile.h |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/pm-rmobile.c
> +++ work/arch/arm/mach-shmobile/pm-rmobile.c	2014-08-07 15:36:40.000000000 +0900
> @@ -27,7 +27,7 @@
>  #define PSTR_RETRIES	100
>  #define PSTR_DELAY_US	10
>  
> -#ifdef CONFIG_PM
> +#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
>  static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
>  {
>  	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
> @@ -151,4 +151,4 @@ void rmobile_add_devices_to_domains(stru
>  		rmobile_add_device_to_domain_td(data[j].domain_name,
>  						data[j].pdev, &latencies);
>  }
> -#endif /* CONFIG_PM */
> +#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
> --- 0001/arch/arm/mach-shmobile/pm-rmobile.h
> +++ work/arch/arm/mach-shmobile/pm-rmobile.h	2014-08-07 15:34:58.000000000 +0900
> @@ -36,7 +36,7 @@ struct pm_domain_device {
>  	struct platform_device *pdev;
>  };
>  
> -#ifdef CONFIG_PM
> +#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
>  extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
>  extern void rmobile_add_device_to_domain_td(const char *domain_name,
>  					    struct platform_device *pdev,
> @@ -58,6 +58,6 @@ extern void rmobile_add_devices_to_domai
>  
>  static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
>  						  int size) {}
> -#endif /* CONFIG_PM */
> +#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
>  
>  #endif /* PM_RMOBILE_H */
> 

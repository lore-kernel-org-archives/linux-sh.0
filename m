From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Nov 2011 12:19:55 +0000
Subject: Re: sh7372 compile breakage in current -next
Message-Id: <Pine.LNX.4.64.1111171319110.2650@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201111162325.51517.rjw@sisk.pl>
In-Reply-To: <201111162325.51517.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 16 Nov 2011, Rafael J. Wysocki wrote:

> On Wednesday, November 16, 2011, Rafael J. Wysocki wrote:
> > On Wednesday, November 16, 2011, Rafael J. Wysocki wrote:
> > > On Wednesday, November 16, 2011, Guennadi Liakhovetski wrote:
> > > > arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
> > > > arch/arm/mach-shmobile/pm-sh7372.c:476: error: 'sh7372_a3sp' undeclared (first use in this function)
> > > > arch/arm/mach-shmobile/pm-sh7372.c:476: error: (Each undeclared identifier is reported only once
> > > > arch/arm/mach-shmobile/pm-sh7372.c:476: error: for each function it appears in.)
> > > > make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1
> > > 
> > > OK, I'll have a look at that.
> > > 
> > > What's the .config you used?
> > 
> > Do you have CONFIG_PM unset, perchance?
> 
> Well, I'm quite sure you do.  The appended patch should help, then.

Yes, you're right on both occasions:-)

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / shmobile: Fix build of sh7372_pm_init() for CONFIG_PM unset
> 
> Fix build regression introduced by commit 056879d2f244001b2888cdc8cf
> (ARM: mach-shmobile: sh7372 A3SP no_suspend_console fix) by moving
> the intialization of the A3SP domain to a separate function and
> providing an empty definition of it for CONFIG_PM unset.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/arm/mach-shmobile/pm-sh7372.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
> =================================> --- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
> +++ linux/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -232,11 +232,23 @@ struct sh7372_pm_domain sh7372_a3sp = {
>  	.no_debug = true,
>  };
>  
> +static void sh7372_a3sp_init(void)
> +{
> +	/* serial consoles make use of SCIF hardware located in A3SP,
> +	 * keep such power domain on if "no_console_suspend" is set.
> +	 */
> +	sh7372_a3sp.stay_on = !console_suspend_enabled;
> +}
> +
>  struct sh7372_pm_domain sh7372_a3sg = {
>  	.bit_shift = 13,
>  };
>  
> -#endif /* CONFIG_PM */
> +#else /* !CONFIG_PM */
> +
> +static inline void sh7372_a3sp_init(void) {}
> +
> +#endif /* !CONFIG_PM */
>  
>  #if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
>  static int sh7372_do_idle_core_standby(unsigned long unused)
> @@ -470,10 +482,7 @@ void __init sh7372_pm_init(void)
>  	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
>  	__raw_writel(0, PDNSEL);
>  
> -	/* serial consoles make use of SCIF hardware located in A3SP,
> -	 * keep such power domain on if "no_console_suspend" is set.
> -	 */
> -	sh7372_a3sp.stay_on = !console_suspend_enabled;
> +	sh7372_a3sp_init();
>  
>  	sh7372_suspend_init();
>  	sh7372_cpuidle_init();
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 06 May 2011 07:42:50 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add definitions for 3 more power
Message-Id: <Pine.LNX.4.64.1105060816030.10445@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105051826080.29735@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105051826080.29735@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael,

On Thu, 5 May 2011, Rafael J. Wysocki wrote:

> On Thursday, May 05, 2011, Guennadi Liakhovetski wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Rafael, a modest contribution to your power-domains branch;) I've also had 
> > to add devices to these domains in my tests, but we have to be careful 
> > with those additions. Not all, what's logical, works... E.g., to test PM 
> > with some devices / drivers, certain other devices had to be disabled, 
> > which is, certainly, not suitable for the mainline.
> 
> OK, but some more details would be helpful. :-)

I think, my main concern with the power domain API is, that you need 
drivers for all devices. Consider this: in the core we will want to add 
all devices to respective domains, e.g., all devices from the 
sh7372_early_devices[] and sh7372_late_devices[] arrays in setup-sh7372.c. 
But there will be (embedded) systems, that will not want to build all 
those drivers, but will want to save power by turning those domains off. 
What shall it be doing? So, either we need a way to only selectively add 
even centrally defined devices to their power domains, or a way, to manage 
those power domains even if not all drivers are present.

> > We'll have to think about what and how exactly to mainline a bit more.
> 
> No question about that.  For now, I'd like to push
> 
> https://patchwork.kernel.org/patch/742942/
> https://patchwork.kernel.org/patch/742932/

Yes, that's what I based all my tests on.

> upstream, depending on what Magnus thinks of the second one.  I also did
> a A4MP patch:
> 
> https://patchwork.kernel.org/patch/743142/
> 
> which I think is safe, because there is only one device in this domain.
> 
> I guess we may simply add domains as needed, ie. once we have tested that
> all of the drivers in a given domain work well together, we may add that
> domain and populate it with devices in a single patch.
> 
> Of course, what we have right now may not be suitable for the more
> complicated cases (eg. domains containing CPUs or interrupt controllers),
> so most likely we will need to extend the common code in the process.
> 
> Please tell me what you think.

Right, there are also domains, which we will never want to suspend, at 
least not during operation. Even for system suspend sometimes you have to 
keep some domains powered for wakeup. But why are driver runtime_suspend() 
methods, for devices in a power domain, only called when the complete 
domain is going down? Perhaps, the idea behind this design is, that 
driver's runtime_suspend() / restore() only save and restore device's 
state. So, they only have to be called, when the device loses power, i.e., 
when the domain is turned off. But what if the device also has some 
internal means to save power, e.g., by switching off some PLLs, with this 
design this will only happen when the whole domain goes down. Why not call 
driver's rtpm methods for each device individually, like in the default 
platform-device case?

Thanks
Guennadi

> 
> Thanks,
> Rafael
> 
> 
> >  arch/arm/mach-shmobile/include/mach/sh7372.h |    9 +++++++++
> >  arch/arm/mach-shmobile/pm-sh7372.c           |   18 ++++++++++++++++++
> >  2 files changed, 27 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
> > index 8372c8f..6a290b7 100644
> > --- a/arch/arm/mach-shmobile/include/mach/sh7372.h
> > +++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
> > @@ -474,12 +474,21 @@ struct platform_device;
> >  
> >  #ifdef CONFIG_PM
> >  extern struct generic_power_domain sh7372_a4lc_domain;
> > +extern struct generic_power_domain sh7372_a4mp_domain;
> > +extern struct generic_power_domain sh7372_a4r_domain;
> > +extern struct generic_power_domain sh7372_a3sp_domain;
> >  #define SH7372_A4LC	(&sh7372_a4lc_domain)
> > +#define SH7372_A4MP	(&sh7372_a4mp_domain)
> > +#define SH7372_A4R	(&sh7372_a4r_domain)
> > +#define SH7372_A3SP	(&sh7372_a3sp_domain)
> >  
> >  extern void sh7372_add_device_to_domain(struct generic_power_domain *domain,
> >  					struct platform_device *pdev);
> >  #else
> >  #define SH7372_A4LC	NULL
> > +#define SH7372_A4MP	NULL
> > +#define SH7372_A4R	NULL
> > +#define SH7372_A3SP	NULL
> >  
> >  static inline void sh7372_add_device_to_domain(struct generic_power_domain *dom,
> >  					       struct platform_device *pd) {}
> > diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> > index 589bb0d..1bf3351 100644
> > --- a/arch/arm/mach-shmobile/pm-sh7372.c
> > +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> > @@ -88,11 +88,29 @@ static struct sh7372_domain_data sh7372_a4lc_domain_data = {
> >  	.bit_shift = 1,
> >  };
> >  
> > +static struct sh7372_domain_data sh7372_a4mp_domain_data = {
> > +	.bit_shift = 2,
> > +};
> > +
> > +static struct sh7372_domain_data sh7372_a4r_domain_data = {
> > +	.bit_shift = 5,
> > +};
> > +
> > +static struct sh7372_domain_data sh7372_a3sp_domain_data = {
> > +	.bit_shift = 11,
> > +};
> > +
> >  struct generic_power_domain sh7372_a4lc_domain;
> > +struct generic_power_domain sh7372_a4mp_domain;
> > +struct generic_power_domain sh7372_a4r_domain;
> > +struct generic_power_domain sh7372_a3sp_domain;
> >  
> >  static int __init sh7372_power_domains_init(void)
> >  {
> >  	sh7372_init_domain(&sh7372_a4lc_domain, &sh7372_a4lc_domain_data);
> > +	sh7372_init_domain(&sh7372_a4lc_domain, &sh7372_a4mp_domain_data);
> > +	sh7372_init_domain(&sh7372_a4r_domain, &sh7372_a4r_domain_data);
> > +	sh7372_init_domain(&sh7372_a3sp_domain, &sh7372_a3sp_domain_data);
> >  	return 0;
> >  }
> >  core_initcall(sh7372_power_domains_init);
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 09 Nov 2011 08:52:18 +0000
Subject: Re: [PATCH 2/7] PM / Domains: Make it possible to use per-device
Message-Id: <Pine.LNX.4.64.1111090818060.24340@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201111070101.33960.rjw@sisk.pl> <201111070106.52411.rjw@sisk.pl>
 <Pine.LNX.4.64.1111081054070.10851@axis700.grange> <201111082140.00876.rjw@sisk.pl>
In-Reply-To: <201111082140.00876.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

On Tue, 8 Nov 2011, Rafael J. Wysocki wrote:

> On Tuesday, November 08, 2011, Guennadi Liakhovetski wrote:
> > On Mon, 7 Nov 2011, Rafael J. Wysocki wrote:
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > The current generic PM domains code requires that the same
> > > .active_wakeup() device callback routine be used for all devices in
> > > the given domain, which is inflexible and may not cover some specific
> > > use cases.  For this reason, make it possible to use device specific
> > > .active_wakeup() callback routines by adding a corresponding callback
> > > pointer to struct generic_pm_domain_data.  To reduce code duplication
> > > use struct gpd_dev_ops to represent PM domain device callbacks as
> > > well as device-specific ones and add a macro for defining routines
> > > that will execute those callbacks.
> > > 
> > > Modify the shmobile's power domains code to allow drivers to use
> > > their own .active_wakeup() callback routines.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  arch/arm/mach-shmobile/pm-sh7372.c |   11 ++++---
> > >  drivers/base/power/domain.c        |   54 ++++++++++++++++++-------------------
> > >  include/linux/pm_domain.h          |   15 ++++------
> > >  3 files changed, 41 insertions(+), 39 deletions(-)
> > > 
> > > Index: linux/include/linux/pm_domain.h
> > > =================================> > > --- linux.orig/include/linux/pm_domain.h
> > > +++ linux/include/linux/pm_domain.h
> > > @@ -23,6 +23,12 @@ struct dev_power_governor {
> > >  	bool (*power_down_ok)(struct dev_pm_domain *domain);
> > >  };
> > >  
> > > +struct gpd_dev_ops {
> > > +	int (*start)(struct device *dev);
> > > +	int (*stop)(struct device *dev);
> > > +	bool (*active_wakeup)(struct device *dev);
> > > +};
> > > +
> > >  struct generic_pm_domain {
> > >  	struct dev_pm_domain domain;	/* PM domain operations */
> > >  	struct list_head gpd_list_node;	/* Node in the global PM domains list */
> > > @@ -45,9 +51,7 @@ struct generic_pm_domain {
> > >  	bool dev_irq_safe;	/* Device callbacks are IRQ-safe */
> > >  	int (*power_off)(struct generic_pm_domain *domain);
> > >  	int (*power_on)(struct generic_pm_domain *domain);
> > > -	int (*start_device)(struct device *dev);
> > > -	int (*stop_device)(struct device *dev);
> > > -	bool (*active_wakeup)(struct device *dev);
> > > +	struct gpd_dev_ops dev_ops;
> > 
> > Wouldn't it be better to merge patches 1 and 2?
> 
> First, why would it?

Because (1) AFAICS both these patches add new logically rather close to 
each other methods to the same existing API, and (2) it would reduce the 
total changed lines count and simplify reading of the patch(es), because 
your second patch moves around and modifies lines of code, that the first 
patch adds.

> Second, why does it matter?

See above.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

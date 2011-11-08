From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 08 Nov 2011 09:30:38 +0000
Subject: Re: [PATCH 1/7] PM / Domains: Make it possible to use per-device
Message-Id: <Pine.LNX.4.64.1111080951040.10851@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201111070101.33960.rjw@sisk.pl> <201111070106.14607.rjw@sisk.pl>
In-Reply-To: <201111070106.14607.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

Hi Rafael

On Mon, 7 Nov 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The current generic PM domains code requires that the same .stop()
> and .start() device callback routines be used for all devices in the
> given domain, which is inflexible and may not cover some specific use
> cases.  For this reason, make it possible to use device specific
> .start() and .stop() callback routines by adding corresponding
> callback pointers to struct generic_pm_domain_data.  Add a new helper
> routine, pm_genpd_register_callbacks(), that can be used to populate
> the new per-device callback pointers.
> 
> Modify the shmobile's power domains code to allow drivers to add
> their own code to be run during the device stop and start operations
> with the help of the new callback pointers.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

[snip]

> Index: linux/drivers/base/power/domain.c
> =================================> --- linux.orig/drivers/base/power/domain.c
> +++ linux/drivers/base/power/domain.c
> @@ -29,6 +29,36 @@ static struct generic_pm_domain *dev_to_
>  	return pd_to_genpd(dev->pm_domain);
>  }
>  
> +static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
> +{
> +	int (*stop)(struct device *dev);
> +
> +	stop = genpd->stop_device;
> +	if (stop)
> +		return stop(dev);
> +
> +	stop = dev_gpd_data(dev)->ops.stop;
> +	if (stop)
> +		return stop(dev);

With this implementation your approach is: in your genpd_stop_dev() and 
genpd_start_dev() you first check for the pm-domain _common_ .start() and 
.stop(), and if they exist, the specific ones will not be called. Then in 
your sh7372 pm domain implementation you do the domain-common part - 
switch the PM clock on or off, and you _again_ check for device-specific 
domains, and this time you call both of them.

Do you have specific reasons to think, that calling both of them from 
genpd_stop_dev() / genpd_start_dev() might not fit some PM-domain 
implementations?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

From: Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 09 May 2011 14:36:03 +0000
Subject: Re: [linux-pm] [PATCH 3/5] PM: Support for system-wide power
Message-Id: <Pine.LNX.4.44L0.1105091032190.2002-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <201105082324.19674.rjw@sisk.pl>
References: <201105082324.19674.rjw@sisk.pl>
In-Reply-To: <201105082324.19674.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Sun, 8 May 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make generic power domains support system-wide power transitions
> (system suspend and hibernation).  Add suspend, resume, freeze and
> thaw callbacks to be associated with struct generic_power_domain
> objects and make pm_genpd_init() use them as appropriate.

...

> Index: linux-2.6/drivers/base/power/domain.c
> =================================> --- linux-2.6.orig/drivers/base/power/domain.c
> +++ linux-2.6/drivers/base/power/domain.c
> @@ -273,6 +273,280 @@ static int pm_genpd_runtime_resume(struc
>  
>  #endif /* CONFIG_PM_RUNTIME */
>  
> +#ifdef CONFIG_PM_SLEEP
> +
> +/**
> + * pm_genpd_powered_down - Check if power has been removed from a power domain.
> + * @genpd: Power domain to check.
> + */
> +static bool pm_genpd_powered_down(struct generic_power_domain *genpd)
> +{
> +	bool ret;
> +
> +	mutex_lock(&genpd->lock);
> +	ret = genpd->power_is_off;
> +	mutex_unlock(&genpd->lock);
> +
> +	return ret;
> +}

What is the purpose of the mutex?  On the face of it, there's nothing 
to prevent another thread from changing the domain's power state in 
between the mutex_unlock() call and the return statement.

Alan Stern


From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 11 May 2011 17:17:32 +0000
Subject: Re: [PATCH 3/5] PM: Support for system-wide power transitions in
Message-Id: <20110511111732.2f75713a@bike.lwn.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105082320.57185.rjw@sisk.pl>
	<201105082324.19674.rjw@sisk.pl>
In-Reply-To: <201105082324.19674.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi, Rafael,

One small question that came to mind as I was looking at this patch:

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

I'm not quite sure why this function exists?  The lock doesn't really
change anything, since the power state can change before or after this
check regardless.  If you need the power state to be stable, it seems like
the lock needs to be taken further up the stack; otherwise simply checking
genpd->power_is_off directly would seem to be sufficient. Am I missing
something?

Thanks,

jon

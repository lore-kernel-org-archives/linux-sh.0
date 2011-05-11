From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 11 May 2011 19:11:50 +0000
Subject: Re: [PATCH 3/5] PM: Support for system-wide power transitions in generic power domains
Message-Id: <201105112111.50740.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105082324.19674.rjw@sisk.pl> <20110511111732.2f75713a@bike.lwn.net>
In-Reply-To: <20110511111732.2f75713a@bike.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Wednesday, May 11, 2011, Jonathan Corbet wrote:
> Hi, Rafael,
> 
> One small question that came to mind as I was looking at this patch:
> 
> > +/**
> > + * pm_genpd_powered_down - Check if power has been removed from a power domain.
> > + * @genpd: Power domain to check.
> > + */
> > +static bool pm_genpd_powered_down(struct generic_power_domain *genpd)
> > +{
> > +	bool ret;
> > +
> > +	mutex_lock(&genpd->lock);
> > +	ret = genpd->power_is_off;
> > +	mutex_unlock(&genpd->lock);
> > +
> > +	return ret;
> 
> I'm not quite sure why this function exists?  The lock doesn't really
> change anything, since the power state can change before or after this
> check regardless.  If you need the power state to be stable, it seems like
> the lock needs to be taken further up the stack; otherwise simply checking
> genpd->power_is_off directly would seem to be sufficient. Am I missing
> something?

No, you aren't. :-)

In fact, the function doesn't exist any more in the most recent version
of the patch: https://patchwork.kernel.org/patch/775412/

Thanks,
Rafael

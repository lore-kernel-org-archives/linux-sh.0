From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 07 May 2012 19:10:07 +0000
Subject: Re: [PATCH] clocksource: em_sti: Emma Mobile STI driver
Message-Id: <alpine.LFD.2.02.1205072054130.6271@ionos>
List-Id: <linux-sh.vger.kernel.org>
References: <20120503125611.4314.52231.sendpatchset@w520>
In-Reply-To: <20120503125611.4314.52231.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, lethal@linux-sh.org, gregkh@linuxfoundation.org, olof@lixom.net

On Thu, 3 May 2012, Magnus Damm wrote:
> +/* private flags */
> +#define FLAG_CLOCKEVENT (1 << 0)
> +#define FLAG_CLOCKSOURCE (1 << 1)
> +
> +static int em_sti_start(struct em_sti_priv *p, unsigned long flag)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&p->lock, flags);
> +
> +	if (!(p->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
> +		ret = em_sti_enable(p);

That's confusing. You seem to enable both CLOCKEVENT and CLOCKSOURCE
independent of "flag" value.

> +
> +	if (!ret)
> +		p->flags |= flag;

And then just or "flag" ??????

> +	spin_unlock_irqrestore(&p->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void em_sti_stop(struct em_sti_priv *p, unsigned long flag)
> +{
> +	unsigned long flags;
> +	unsigned long f;
> +
> +	spin_lock_irqsave(&p->lock, flags);
> +
> +	f = p->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
> +	p->flags &= ~flag;
> +
> +	if (f && !(p->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
> +		em_sti_disable(p);

Huch? If the caller wants to disable the clockevent, you stop the
clocksource as well because em_sti_disable() stops the clock.

/me is confused.

> +static void em_sti_clock_event_start(struct em_sti_priv *p)
> +{
> +	struct clock_event_device *ced = &p->ced;
> +
> +	em_sti_start(p, FLAG_CLOCKEVENT);
> +
> +	/* TODO: calculate good shift from rate and counter bit width */
> +
> +	ced->shift = 32;
> +	ced->mult = div_sc(p->rate, NSEC_PER_SEC, ced->shift);

IIRC, we have a generic function to do that :)

Thanks,

	tglx

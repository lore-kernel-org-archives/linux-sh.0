From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 24 May 2012 23:42:14 +0000
Subject: Re: [PATCH 02/03] clocksource: em_sti: Emma Mobile STI driver V2
Message-Id: <alpine.LFD.2.02.1205250135340.3231@ionos>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509143926.27521.20342.sendpatchset@w520> <20120509143942.27521.8595.sendpatchset@w520>
In-Reply-To: <20120509143942.27521.8595.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, horms@verge.net.au, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, lethal@linux-sh.org, gregkh@linuxfoundation.org, olof@lixom.net

On Wed, 9 May 2012, Magnus Damm wrote:
> +static irqreturn_t em_sti_interrupt(int irq, void *dev_id)
> +{
> +	struct em_sti_priv *p = dev_id;
> +
> +	/* Always regprogram timer compare A */
> +	if (p->ced.mode = CLOCK_EVT_MODE_PERIODIC)
> +		em_sti_update(p);

Why do you want to do that? The core code already handles timers which
only support oneshot mode.

> +	spin_lock_irqsave(&p->lock, flags);

Please make that a raw_spinlock.

> +static void em_sti_clock_event_mode(enum clock_event_mode mode,
> +				    struct clock_event_device *ced)
> +{
> +	struct em_sti_priv *p = ced_to_em_sti(ced);
> +
> +	/* deal with old setting first */
> +	switch (ced->mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		em_sti_stop(p, USER_CLOCKEVENT);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		dev_info(&p->pdev->dev, "used for periodic clock events\n");
> +		em_sti_start(p, USER_CLOCKEVENT);
> +		clockevents_config(&p->ced, p->rate);
> +		p->delta = (p->rate + HZ/2) / HZ;
> +		p->next = em_sti_count(p);
> +		em_sti_update(p);
> +		break;

All that code in this case can go away.

> +static void em_sti_register_clockevent(struct em_sti_priv *p)
> +{
> +	struct clock_event_device *ced = &p->ced;
> +
> +	memset(ced, 0, sizeof(*ced));
> +	ced->name = dev_name(&p->pdev->dev);
> +	ced->features = CLOCK_EVT_FEAT_PERIODIC;
> +	ced->features |= CLOCK_EVT_FEAT_ONESHOT;

If you make that:

	ced->features = CLOCK_EVT_FEAT_ONESHOT;

Thanks,

	tglx

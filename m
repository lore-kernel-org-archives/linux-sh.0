From: john stultz <johnstul@us.ibm.com>
Date: Mon, 01 Dec 2008 20:29:14 +0000
Subject: Re: [PATCH 04/10] timer_inc: timer helper code, clockevent only
Message-Id: <1228163354.7176.18.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2008-12-01 at 19:33 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds clock source/event helper code for incrementing timers.
> 
> Normally tickless operation requires two timers, one for the clock source
> and another one for a oneshot timer event. The helper code makes it
> possible to use a single timer for both clock source and clock event,
> ie tickless with a single incrementing timer. Useful on for instance
> processors where all timers except one needs to be disabled for deep sleep.
> 
> The clock source is calculated from the running hardware timer plus a
> software controlled counter which together form a 32 bit value. High
> accuracy of the clock source is kept by never reprogramming the hardware
> counter, only the hardware match value.
> 
> Clock events are handled by reading out current hardware counter value
> and reprogramming the match register. Both periodic and oneshot modes
> are supported.
> 
> The helper code only supports incrementing timer hardware which at
> matching time resets and generates an interrupt but keeps on counting.
> Timers counting down are not supported.

Hey Magnus,
	Forgive me again for not understanding all this immediately. It just
seems like a fair amount of generic infrastructure, so I want to make
sure it really is reusable.

I'm not sure your initial assertion that tickless operation requires two
timers is correct. Can you explain why this timer_inc structure is
necessary, in comparison to just having separate clockevent and
clocksource interfaces for one bit of hardware, like what is done with
the similar count-up HPET on x86?

I just worry that we're adding extra structures and interfaces where it
might be better to just re-factor the clocksource and clockevent
structures themselves to handle the needs you have.

thanks
-john


> This patch only implements clock event code to begin with. The code
> gets updated with full clock source support later in the series.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  drivers/clocksource/timer_inc.c |  349 +++++++++++++++++++++++++++++++++++++++
>  include/linux/timer_inc.h       |   44 ++++
>  2 files changed, 393 insertions(+)
> 
> --- /dev/null
> +++ work/drivers/clocksource/timer_inc.c	2008-12-01 12:51:28.000000000 +0900
> @@ -0,0 +1,349 @@
> +/*
> + * timer_inc.c - Clock source/event helper code for incrementing timers.
> + *
> + *  Copyright (C) 2008 Magnus Damm
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/spinlock.h>
> +#include <linux/timer_inc.h>
> +
> +/*
> + * Written for increment-match-wrap timer hardware. The timer is constantly
> + * enabled and a software cycle counter is updated at interrupt time.
> + * The hardware timer counter is never modified to allow high clock source
> + * quality. The match register is rewritten to support oneshot and periodic
> + * clock events.
> + */
> +
> +/* private flags */
> +#define FLAG_CLOCKEVENT (1 << 0)
> +#define FLAG_REPROGRAM (1 << 2)
> +#define FLAG_SKIPEVENT (1 << 3)
> +#define FLAG_IRQCONTEXT (1 << 4)
> +
> +static void timer_inc_clock_event_program_verify(struct timer_inc *tip,
> +						 int absolute)
> +{
> +	unsigned long new_match;
> +	unsigned long value = tip->next_match_value;
> +	unsigned long delay = 0;
> +	unsigned long now = 0;
> +	int has_wrapped;
> +
> +	now = tip->ops->get_counter(tip->priv, &has_wrapped);
> +	tip->flags |= FLAG_REPROGRAM; /* force reprogram */
> +
> +	if (has_wrapped) {
> +		/* we're competing with the interrupt handler.
> +		 *  -> let the interrupt handler reprogram the timer.
> +		 *  -> interrupt number two handles the event.
> +		 */
> +		tip->flags |= FLAG_SKIPEVENT;
> +		return;
> +	}
> +
> +	if (absolute)
> +		now = 0;
> +
> +	do {
> +		/* reprogram the timer hardware,
> +		 * but don't save the new match value yet.
> +		 */
> +		new_match = now + value + delay;
> +		if (new_match > tip->max_match_value)
> +			new_match = tip->max_match_value;
> +
> +		tip->ops->set_match(tip->priv, new_match);
> +
> +		now = tip->ops->get_counter(tip->priv, &has_wrapped);
> +		if (has_wrapped && (new_match > tip->match_value)) {
> +			/* we are changing to a greater match value,
> +			 * so this wrap must be caused by the counter
> +			 * matching the old value.
> +			 * -> first interrupt reprograms the timer.
> +			 * -> interrupt number two handles the event.
> +			 */
> +			tip->flags |= FLAG_SKIPEVENT;
> +			break;
> +		}
> +
> +		if (has_wrapped) {
> +			/* we are changing to a smaller match value,
> +			 * so the wrap must be caused by the counter
> +			 * matching the new value.
> +			 * -> save programmed match value.
> +			 * -> let isr handle the event.
> +			 */
> +			tip->match_value = new_match;
> +			break;
> +		}
> +
> +		/* be safe: verify hardware settings */
> +		if (now < new_match) {
> +			/* timer value is below match value, all good.
> +			 * this makes sure we won't miss any match events.
> +			 * -> save programmed match value.
> +			 * -> let isr handle the event.
> +			 */
> +			tip->match_value = new_match;
> +			break;
> +		}
> +
> +		/* the counter has reached a value greater
> +		 * than our new match value. and since the
> +		 * has_wrapped flag isn't set we must have
> +		 * programmed a too close event.
> +		 * -> increase delay and retry.
> +		 */
> +		if (delay)
> +			delay <<= 1;
> +		else
> +			delay = 1;
> +
> +		if (!delay)
> +			pr_warning("timer_inc: too long delay\n");
> +
> +	} while (delay);
> +}
> +
> +static void timer_inc_set_next(struct timer_inc *tip, unsigned long delta)
> +{
> +	unsigned long flags;
> +
> +	if (delta > tip->max_match_value)
> +		pr_warning("timer_inc: delta out of range\n");
> +
> +	spin_lock_irqsave(&tip->lock, flags);
> +	tip->next_match_value = delta;
> +	timer_inc_clock_event_program_verify(tip, 0);
> +	spin_unlock_irqrestore(&tip->lock, flags);
> +}
> +
> +void timer_inc_interrupt(struct timer_inc *tip)
> +{
> +	if (!(tip->flags & FLAG_REPROGRAM))
> +		tip->next_match_value = tip->max_match_value;
> +
> +	tip->flags |= FLAG_IRQCONTEXT;
> +
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> +	if (tip->flags & FLAG_CLOCKEVENT) {
> +		if (!(tip->flags & FLAG_SKIPEVENT)) {
> +			if (tip->ced.mode = CLOCK_EVT_MODE_ONESHOT) {
> +				tip->next_match_value = tip->max_match_value;
> +				tip->flags |= FLAG_REPROGRAM;
> +			}
> +
> +			tip->ced.event_handler(&tip->ced);
> +		}
> +	}
> +#endif
> +	tip->flags &= ~FLAG_SKIPEVENT;
> +
> +	if (tip->flags & FLAG_REPROGRAM) {
> +		tip->flags &= ~FLAG_REPROGRAM;
> +		timer_inc_clock_event_program_verify(tip, 1);
> +
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> +		if (tip->flags & FLAG_CLOCKEVENT)
> +			if ((tip->ced.mode = CLOCK_EVT_MODE_SHUTDOWN)
> +			    || (tip->match_value = tip->next_match_value))
> +				tip->flags &= ~FLAG_REPROGRAM;
> +#endif
> +	}
> +
> +	tip->flags &= ~FLAG_IRQCONTEXT;
> +}
> +
> +static int timer_inc_start(struct timer_inc *tip, unsigned long flag)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tip->lock, flags);
> +
> +	if (!(tip->flags & FLAG_CLOCKEVENT))
> +		ret = tip->ops->enable(tip->priv, &tip->rate);
> +
> +	if (!ret)
> +		tip->flags |= flag;
> +
> +	spin_unlock_irqrestore(&tip->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void timer_inc_stop(struct timer_inc *tip, unsigned long flag)
> +{
> +	unsigned long flags;
> +	unsigned long f;
> +
> +	spin_lock_irqsave(&tip->lock, flags);
> +
> +	f = tip->flags & FLAG_CLOCKEVENT;
> +	tip->flags &= ~flag;
> +
> +	if (f && !(tip->flags & FLAG_CLOCKEVENT))
> +		tip->ops->disable(tip->priv);
> +
> +	spin_unlock_irqrestore(&tip->lock, flags);
> +}
> +
> +
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> +
> +static struct timer_inc *ced_to_timer_inc(struct clock_event_device *ced)
> +{
> +	return container_of(ced, struct timer_inc, ced);
> +}
> +
> +static void timer_inc_clock_event_start(struct timer_inc *tip, int periodic)
> +{
> +	struct clock_event_device *ced = &tip->ced;
> +
> +	timer_inc_start(tip, FLAG_CLOCKEVENT);
> +
> +	/* TODO: calculate good shift from rate and counter bit width */
> +
> +	ced->shift = 32;
> +	ced->mult = div_sc(tip->rate, NSEC_PER_SEC, ced->shift);
> +	ced->max_delta_ns = clockevent_delta2ns(tip->max_match_value, ced);
> +	ced->min_delta_ns = clockevent_delta2ns(0x1f, ced);
> +
> +	if (periodic)
> +		timer_inc_set_next(tip, (tip->rate + HZ/2) / HZ);
> +	else
> +		timer_inc_set_next(tip, tip->max_match_value);
> +}
> +
> +static void timer_inc_clock_event_mode(enum clock_event_mode mode,
> +				       struct clock_event_device *ced)
> +{
> +	struct timer_inc *tip = ced_to_timer_inc(ced);
> +
> +	/* deal with old setting first */
> +	switch (ced->mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		timer_inc_stop(tip, FLAG_CLOCKEVENT);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		pr_info("timer_inc: %s used for periodic clock events\n",
> +			ced->name);
> +		timer_inc_clock_event_start(tip, 1);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		pr_info("timer_inc: %s used for oneshot clock events\n",
> +			ced->name);
> +		timer_inc_clock_event_start(tip, 0);
> +		break;
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +	case CLOCK_EVT_MODE_UNUSED:
> +		timer_inc_stop(tip, FLAG_CLOCKEVENT);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static int timer_inc_clock_event_next(unsigned long delta,
> +				      struct clock_event_device *ced)
> +{
> +	struct timer_inc *tip = ced_to_timer_inc(ced);
> +
> +	BUG_ON(ced->mode != CLOCK_EVT_MODE_ONESHOT);
> +	if (likely(tip->flags & FLAG_IRQCONTEXT))
> +		tip->next_match_value = delta;
> +	else
> +		timer_inc_set_next(tip, delta);
> +
> +	return 0;
> +}
> +
> +static void timer_inc_register_clockevent(struct timer_inc *tip,
> +					  char *name,
> +					  unsigned long rating)
> +{
> +	struct clock_event_device *ced = &tip->ced;
> +
> +	memset(ced, 0, sizeof(*ced));
> +
> +	ced->name = name;
> +	ced->features = CLOCK_EVT_FEAT_PERIODIC;
> +	ced->features |= CLOCK_EVT_FEAT_ONESHOT;
> +	ced->rating = rating;
> +	ced->cpumask = CPU_MASK_CPU0;
> +	ced->set_next_event = timer_inc_clock_event_next;
> +	ced->set_mode = timer_inc_clock_event_mode;
> +
> +	pr_info("timer_inc: %s used for clock events\n", ced->name);
> +	clockevents_register_device(ced);
> +}
> +
> +static void timer_inc_unregister_clockevent(struct timer_inc *tip)
> +{
> +	struct clock_event_device *ced = &tip->ced;
> +
> +	if (ced->features)
> +		clockevents_unregister_device(ced);
> +}
> +
> +#else /* CONFIG_GENERIC_CLOCKEVENTS */
> +static inline void timer_inc_register_clockevent(struct timer_inc *tip,
> +						 char *name,
> +						 unsigned long rating) {}
> +static inline void timer_inc_unregister_clockevent(struct timer_inc *tip) {}
> +#endif /* CONFIG_GENERIC_CLOCKEVENTS */
> +
> +int timer_inc_register(struct timer_inc *tip,
> +		       char *name, void *priv,
> +		       unsigned long bits,
> +		       struct timer_inc_ops *ops,
> +		       unsigned long clockevent_rating,
> +		       unsigned long clocksource_rating)
> +{
> +	memset(tip, 0, sizeof(*tip));
> +
> +	if (bits = (sizeof(tip->max_match_value) * 8))
> +		tip->max_match_value = ~0;
> +	else
> +		tip->max_match_value = (1 << bits) - 1;
> +
> +	tip->match_value = tip->max_match_value;
> +	tip->priv = priv;
> +	tip->ops = ops;
> +	spin_lock_init(&tip->lock);
> +
> +	if (clockevent_rating)
> +		timer_inc_register_clockevent(tip, name, clockevent_rating);
> +
> +	return 0;
> +}
> +
> +void timer_inc_unregister(struct timer_inc *tip)
> +{
> +	timer_inc_unregister_clockevent(tip);
> +}
> --- /dev/null
> +++ work/include/linux/timer_inc.h	2008-12-01 12:47:28.000000000 +0900
> @@ -0,0 +1,44 @@
> +#ifndef __TIMER_INC_H__
> +#define __TIMER_INC_H__
> +
> +/* Clock source/event helper code for incrementing timers. */
> +
> +#include <linux/clocksource.h>
> +#include <linux/clockchips.h>
> +#include <linux/spinlock.h>
> +
> +struct timer_inc;
> +
> +struct timer_inc_ops {
> +	void (*set_match)(void *priv, unsigned long value);
> +	unsigned long (*get_counter)(void *priv, int *has_wrapped);
> +	int (*enable)(void *priv, unsigned long *rate);
> +	void (*disable)(void *priv);
> +};
> +
> +struct timer_inc {
> +	struct timer_inc_ops *ops;
> +	void *priv;
> +	unsigned long flags;
> +	unsigned long match_value;
> +	unsigned long next_match_value;
> +	unsigned long max_match_value;
> +	unsigned long rate;
> +	spinlock_t lock;
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> +	struct clock_event_device ced;
> +#endif
> +};
> +
> +void timer_inc_interrupt(struct timer_inc *t);
> +
> +int timer_inc_register(struct timer_inc *tip,
> +		       char *name, void *priv,
> +		       unsigned long bits,
> +		       struct timer_inc_ops *ops,
> +		       unsigned long clockevent_rating,
> +		       unsigned long clocksource_rating);
> +
> +void timer_inc_unregister(struct timer_inc *tip);
> +
> +#endif /* __TIMER_INC_H__ */


From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:33:56 +0000
Subject: [PATCH 10/10] timer_inc: add clocksource support
Message-Id: <20081201103356.26620.13594.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clocksource support to timer_inc using the recently added
read2(), enable() and disable() callbacks. The interface between
the timer_inc main code and the timer driver remains unchanged.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Unregistration of clocksources does not seem to work very well.

 drivers/clocksource/timer_inc.c |  100 +++++++++++++++++++++++++++++++++++++--
 include/linux/timer_inc.h       |    3 +
 2 files changed, 98 insertions(+), 5 deletions(-)

--- 0006/drivers/clocksource/timer_inc.c
+++ work/drivers/clocksource/timer_inc.c	2008-12-01 14:43:36.000000000 +0900
@@ -35,6 +35,7 @@
 
 /* private flags */
 #define FLAG_CLOCKEVENT (1 << 0)
+#define FLAG_CLOCKSOURCE (1 << 1)
 #define FLAG_REPROGRAM (1 << 2)
 #define FLAG_SKIPEVENT (1 << 3)
 #define FLAG_IRQCONTEXT (1 << 4)
@@ -139,6 +140,13 @@ static void timer_inc_set_next(struct ti
 
 void timer_inc_interrupt(struct timer_inc *tip)
 {
+	/* update clock source counter to begin with if enabled
+	 * the wrap flag should be cleared by the timer specific
+	 * isr before we end up here.
+	 */
+	if (tip->flags & FLAG_CLOCKSOURCE)
+		tip->total_cycles += tip->match_value;
+
 	if (!(tip->flags & FLAG_REPROGRAM))
 		tip->next_match_value = tip->max_match_value;
 
@@ -180,12 +188,17 @@ static int timer_inc_start(struct timer_
 
 	spin_lock_irqsave(&tip->lock, flags);
 
-	if (!(tip->flags & FLAG_CLOCKEVENT))
+	if (!(tip->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
 		ret = tip->ops->enable(tip->priv, &tip->rate);
 
-	if (!ret)
-		tip->flags |= flag;
+	if (ret)
+		goto out;
+	tip->flags |= flag;
 
+	/* setup timeout if no clockevent */
+	if ((flag = FLAG_CLOCKSOURCE) && (!(tip->flags & FLAG_CLOCKEVENT)))
+		timer_inc_set_next(tip, tip->max_match_value);
+ out:
 	spin_unlock_irqrestore(&tip->lock, flags);
 
 	return ret;
@@ -198,15 +211,88 @@ static void timer_inc_stop(struct timer_
 
 	spin_lock_irqsave(&tip->lock, flags);
 
-	f = tip->flags & FLAG_CLOCKEVENT;
+	f = tip->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE);
 	tip->flags &= ~flag;
 
-	if (f && !(tip->flags & FLAG_CLOCKEVENT))
+	if (f && !(tip->flags & (FLAG_CLOCKEVENT | FLAG_CLOCKSOURCE)))
 		tip->ops->disable(tip->priv);
 
+	/* adjust the timeout to maximum if only clocksource left */
+	if ((flag = FLAG_CLOCKEVENT) && (tip->flags & FLAG_CLOCKSOURCE))
+		timer_inc_set_next(tip, tip->max_match_value);
+
+	spin_unlock_irqrestore(&tip->lock, flags);
+}
+
+static struct timer_inc *cs_to_timer_inc(struct clocksource *cs)
+{
+	return container_of(cs, struct timer_inc, cs);
+}
+
+static cycle_t timer_inc_clocksource_read(struct clocksource *cs)
+{
+	struct timer_inc *tip = cs_to_timer_inc(cs);
+	unsigned long flags, raw;
+	unsigned long value;
+	int has_wrapped;
+
+	spin_lock_irqsave(&tip->lock, flags);
+	value = tip->total_cycles;
+	raw = tip->ops->get_counter(tip->priv, &has_wrapped);
+
+	if (unlikely(has_wrapped))
+		raw = tip->match_value;
 	spin_unlock_irqrestore(&tip->lock, flags);
+
+	return value + raw;
+}
+
+static int timer_inc_clocksource_enable(struct clocksource *cs)
+{
+	struct timer_inc *tip = cs_to_timer_inc(cs);
+	int ret;
+
+	tip->total_cycles = 0;
+
+	ret = timer_inc_start(tip, FLAG_CLOCKSOURCE);
+	if (ret)
+		return ret;
+
+	/* TODO: calculate good shift from rate and counter bit width */
+	cs->shift = 0;
+	cs->mult = clocksource_hz2mult(tip->rate, cs->shift);
+	return 0;
+}
+
+static void timer_inc_clocksource_disable(struct clocksource *cs)
+{
+	timer_inc_stop(cs_to_timer_inc(cs), FLAG_CLOCKSOURCE);
 }
 
+static int timer_inc_register_clocksource(struct timer_inc *tip,
+					  char *name, unsigned long rating)
+{
+	struct clocksource *cs = &tip->cs;
+
+	cs->name = name;
+	cs->rating = rating;
+	cs->read2 = timer_inc_clocksource_read;
+	cs->enable = timer_inc_clocksource_enable;
+	cs->disable = timer_inc_clocksource_disable;
+	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	pr_info("timer_inc: %s used as clock source\n", cs->name);
+	clocksource_register(cs);
+	return 0;
+}
+
+static void timer_inc_unregister_clocksource(struct timer_inc *tip)
+{
+	struct clocksource *cs = &tip->cs;
+
+	if (cs->flags)
+		clocksource_unregister(cs);
+}
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
@@ -340,10 +426,14 @@ int timer_inc_register(struct timer_inc 
 	if (clockevent_rating)
 		timer_inc_register_clockevent(tip, name, clockevent_rating);
 
+	if (clocksource_rating)
+		timer_inc_register_clocksource(tip, name, clocksource_rating);
+
 	return 0;
 }
 
 void timer_inc_unregister(struct timer_inc *tip)
 {
+	timer_inc_unregister_clocksource(tip);
 	timer_inc_unregister_clockevent(tip);
 }
--- 0006/include/linux/timer_inc.h
+++ work/include/linux/timer_inc.h	2008-12-01 14:21:43.000000000 +0900
@@ -28,6 +28,9 @@ struct timer_inc {
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	struct clock_event_device ced;
 #endif
+	struct clocksource cs;
+	unsigned long total_cycles;
+
 };
 
 void timer_inc_interrupt(struct timer_inc *t);

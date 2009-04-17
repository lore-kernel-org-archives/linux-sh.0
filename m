From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Apr 2009 05:26:31 +0000
Subject: [PATCH] clocksource: sh_cmt clocksource support
Message-Id: <20090417052631.8114.81559.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add clocksource support to the sh_cmt driver. With this in
place we can do tickless with a single CMT channel.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 This patch depends on the following -mm patches:
  clocksource-add-enable-and-disable-callbacks.patch
  clocksource-pass-clocksource-to-read-callback.patch

 drivers/clocksource/sh_cmt.c |   66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

--- 0006/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-02-04 19:48:04.000000000 +0900
@@ -47,6 +47,7 @@ struct sh_cmt_priv {
 	unsigned long rate;
 	spinlock_t lock;
 	struct clock_event_device ced;
+	struct clocksource cs;
 	unsigned long total_cycles;
 };
 
@@ -376,6 +377,68 @@ static void sh_cmt_stop(struct sh_cmt_pr
 	spin_unlock_irqrestore(&p->lock, flags);
 }
 
+static struct sh_cmt_priv *cs_to_sh_cmt(struct clocksource *cs)
+{
+	return container_of(cs, struct sh_cmt_priv, cs);
+}
+
+static cycle_t sh_cmt_clocksource_read(struct clocksource *cs)
+{
+	struct sh_cmt_priv *p = cs_to_sh_cmt(cs);
+	unsigned long flags, raw;
+	unsigned long value;
+	int has_wrapped;
+
+	spin_lock_irqsave(&p->lock, flags);
+	value = p->total_cycles;
+	raw = sh_cmt_get_counter(p, &has_wrapped);
+
+	if (unlikely(has_wrapped))
+		raw = p->match_value;
+	spin_unlock_irqrestore(&p->lock, flags);
+
+	return value + raw;
+}
+
+static int sh_cmt_clocksource_enable(struct clocksource *cs)
+{
+	struct sh_cmt_priv *p = cs_to_sh_cmt(cs);
+	int ret;
+
+	p->total_cycles = 0;
+
+	ret = sh_cmt_start(p, FLAG_CLOCKSOURCE);
+	if (ret)
+		return ret;
+
+	/* TODO: calculate good shift from rate and counter bit width */
+	cs->shift = 0;
+	cs->mult = clocksource_hz2mult(p->rate, cs->shift);
+	return 0;
+}
+
+static void sh_cmt_clocksource_disable(struct clocksource *cs)
+{
+	sh_cmt_stop(cs_to_sh_cmt(cs), FLAG_CLOCKSOURCE);
+}
+
+static int sh_cmt_register_clocksource(struct sh_cmt_priv *p,
+				       char *name, unsigned long rating)
+{
+	struct clocksource *cs = &p->cs;
+
+	cs->name = name;
+	cs->rating = rating;
+	cs->read = sh_cmt_clocksource_read;
+	cs->enable = sh_cmt_clocksource_enable;
+	cs->disable = sh_cmt_clocksource_disable;
+	cs->mask = CLOCKSOURCE_MASK(sizeof(unsigned long) * 8);
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	pr_info("sh_cmt: %s used as clock source\n", cs->name);
+	clocksource_register(cs);
+	return 0;
+}
+
 static struct sh_cmt_priv *ced_to_sh_cmt(struct clock_event_device *ced)
 {
 	return container_of(ced, struct sh_cmt_priv, ced);
@@ -484,6 +547,9 @@ int sh_cmt_register(struct sh_cmt_priv *
 	if (clockevent_rating)
 		sh_cmt_register_clockevent(p, name, clockevent_rating);
 
+	if (clocksource_rating)
+		sh_cmt_register_clocksource(p, name, clocksource_rating);
+
 	return 0;
 }
 

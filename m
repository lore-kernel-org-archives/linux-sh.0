From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 May 2009 12:42:07 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in fallback sched_clock().
Message-Id: <20090528124207.GA28830@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1243348681.23657.14.camel@twins> <alpine.LFD.2.00.0905262209160.1762@localhost.localdomain> <20090526230855.GA27218@linux-sh.org> <alpine.LFD.2.00.0905270140030.1762@localhost.localdomain> <20090527001543.GA8493@linux-sh.org> <1243441525.28705.19.camel@desktop> <20090528091936.GA27545@linux-sh.org> <1243503281.23657.80.camel@twins> <20090528110902.GA27884@linux-sh.org> <alpine.LFD.2.00.0905281417500.3397@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0905281417500.3397@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Daniel Walker <dwalker@fifo99.com>, Linus Walleij <linus.ml.walleij@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>

On Thu, May 28, 2009 at 02:22:17PM +0200, Thomas Gleixner wrote:
> On Thu, 28 May 2009, Paul Mundt wrote:
> > @@ -437,10 +441,19 @@ void clocksource_unregister(struct clocksource *cs)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&clocksource_lock, flags);
> > +
> > +	if (sched_clocksource = cs) {
> > +		printk(KERN_WARNING "Refusing to unregister "
> > +		       "scheduler clocksource %s", cs->name);
> 
>   Hmm, isn't that dangerous ? The clocksource might be in a module or
>   in kmalloced memory which is going to be freed.
> 
Perhaps the saner thing to do is see if select_clocksource() manages to
find something suitable, otherwise switch back to jiffies..

--

 include/linux/clocksource.h |    4 +++-
 kernel/sched_clock.c        |    6 ++++--
 kernel/time/clocksource.c   |   14 ++++++++++++++
 kernel/time/jiffies.c       |    2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index c56457c..2109940 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -202,7 +202,8 @@ struct clocksource {
 #endif
 };
 
-extern struct clocksource *clock;	/* current clocksource */
+extern struct clocksource *clock;		/* current clocksource */
+extern struct clocksource *sched_clocksource;	/* sched_clock() clocksource */
 
 /*
  * Clock source flags bits::
@@ -212,6 +213,7 @@ extern struct clocksource *clock;	/* current clocksource */
 
 #define CLOCK_SOURCE_WATCHDOG			0x10
 #define CLOCK_SOURCE_VALID_FOR_HRES		0x20
+#define CLOCK_SOURCE_USE_FOR_SCHED_CLOCK	0x40
 
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) (cycle_t)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
diff --git a/kernel/sched_clock.c b/kernel/sched_clock.c
index e1d16c9..b91190e 100644
--- a/kernel/sched_clock.c
+++ b/kernel/sched_clock.c
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/ktime.h>
 #include <linux/sched.h>
+#include <linux/clocksource.h>
 
 /*
  * Scheduler clock - returns current time in nanosec units.
@@ -38,8 +39,9 @@
  */
 unsigned long long __attribute__((weak)) sched_clock(void)
 {
-	return (unsigned long long)(jiffies - INITIAL_JIFFIES)
-					* (NSEC_PER_SEC / HZ);
+	struct clocksource *clock = ACCESS_ONCE(sched_clocksource);
+
+	return cyc2ns(clock, clocksource_read(clock));
 }
 
 static __read_mostly int sched_clock_running;
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 80189f6..19c72d0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -109,6 +109,7 @@ EXPORT_SYMBOL(timecounter_cyc2time);
 
 /* XXX - Would like a better way for initializing curr_clocksource */
 extern struct clocksource clocksource_jiffies;
+struct clocksource *sched_clocksource = &clocksource_jiffies;
 
 /*[Clocksource internal variables]---------
  * curr_clocksource:
@@ -362,6 +363,9 @@ static struct clocksource *select_clocksource(void)
 	if (next = curr_clocksource)
 		return NULL;
 
+	if (next->flags & CLOCK_SOURCE_USE_FOR_SCHED_CLOCK)
+		sched_clocksource = next;
+
 	return next;
 }
 
@@ -440,7 +444,17 @@ void clocksource_unregister(struct clocksource *cs)
 	list_del(&cs->list);
 	if (clocksource_override = cs)
 		clocksource_override = NULL;
+
 	next_clocksource = select_clocksource();
+
+	/*
+	 * If select_clocksource() fails to find another suitable
+	 * clocksource for sched_clocksource and we are unregistering
+	 * it, switch back to jiffies.
+	 */
+	if (sched_clocksource = cs)
+		sched_clocksource = &clocksource_jiffies;
+
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 }
 
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index c3f6c30..727d881 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -52,7 +52,7 @@
 
 static cycle_t jiffies_read(struct clocksource *cs)
 {
-	return (cycle_t) jiffies;
+	return (cycle_t) (jiffies - INITIAL_JIFFIES);
 }
 
 struct clocksource clocksource_jiffies = {

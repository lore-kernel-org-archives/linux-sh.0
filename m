From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Jun 2013 07:17:56 +0000
Subject: [PATCH/RFC] clockevents: Ignore C3STOP when CPUIdle is disabled
Message-Id: <20130618071756.22598.51046.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, linux-sh@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, horms@verge.net.au, john.stultz@linaro.org, shinya.kuribayashi.px@renesas.com, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Introduce the function tick_device_may_c3stop() that
ignores the C3STOP flag in case CPUIdle is disabled.

The C3STOP flag tells the system that a clock event
device may be stopped during deep sleep, but if this
will happen or not depends on things like if CPUIdle
is enabled and if a CPUIdle driver is available.

This patch assumes that if CPUIdle is disabled then
the sleep mode triggering C3STOP will never be entered.
So by ignoring C3STOP when CPUIdle is disabled then it
becomes possible to use high resolution timers with only
per-cpu local timers - regardless if they have the
C3STOP flag set or not.

Observed on the r8a73a4 SoC that at this point only uses
ARM architected timers for clock event and clock sources.

Without this patch high resolution timers are run time
disabled on the r8a73a4 SoC - this regardless of CPUIdle
is disabled or not.

The less short term fix is to add support for more timers
on the r8a73a4 SoC, but until CPUIdle support is enabled
it must be possible to use high resoultion timers without
additional timers.

I'd like to hear some feedback and also test this on more
systems before merging the code, see the non-SOB below.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 An earlier ARM arch timer specific version of this patch was
 posted yesterday as:
 "[PATCH/RFC] arm: arch_timer: Do not set C3STOP in case CPU_IDLE=n"

 Many thanks to Mark Rutland for his kind feedback.

 kernel/time/tick-broadcast.c |    8 ++++----
 kernel/time/tick-common.c    |    2 +-
 kernel/time/tick-internal.h  |   11 +++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

--- 0001/kernel/time/tick-broadcast.c
+++ work/kernel/time/tick-broadcast.c	2013-06-18 15:36:21.000000000 +0900
@@ -71,7 +71,7 @@ int tick_check_broadcast_device(struct c
 	if ((dev->features & CLOCK_EVT_FEAT_DUMMY) ||
 	    (tick_broadcast_device.evtdev &&
 	     tick_broadcast_device.evtdev->rating >= dev->rating) ||
-	     (dev->features & CLOCK_EVT_FEAT_C3STOP))
+	     tick_device_may_c3stop(dev))
 		return 0;
 
 	clockevents_exchange_device(tick_broadcast_device.evtdev, dev);
@@ -146,7 +146,7 @@ int tick_device_uses_broadcast(struct cl
 		 * feature and the cpu is marked in the broadcast mask
 		 * then clear the broadcast bit.
 		 */
-		if (!(dev->features & CLOCK_EVT_FEAT_C3STOP)) {
+		if (!tick_device_may_c3stop(dev)) {
 			int cpu = smp_processor_id();
 			cpumask_clear_cpu(cpu, tick_broadcast_mask);
 			tick_broadcast_clear_oneshot(cpu);
@@ -270,7 +270,7 @@ static void tick_do_broadcast_on_off(uns
 	/*
 	 * Is the device not affected by the powerstate ?
 	 */
-	if (!dev || !(dev->features & CLOCK_EVT_FEAT_C3STOP))
+	if (!dev || !tick_device_may_c3stop(dev))
 		goto out;
 
 	if (!tick_device_is_functional(dev))
@@ -568,7 +568,7 @@ void tick_broadcast_oneshot_control(unsi
 	td = &per_cpu(tick_cpu_device, cpu);
 	dev = td->evtdev;
 
-	if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
+	if (!tick_device_may_c3stop(dev))
 		return;
 
 	bc = tick_broadcast_device.evtdev;
--- 0001/kernel/time/tick-common.c
+++ work/kernel/time/tick-common.c	2013-06-18 15:36:29.000000000 +0900
@@ -52,7 +52,7 @@ int tick_is_oneshot_available(void)
 
 	if (!dev || !(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return 0;
-	if (!(dev->features & CLOCK_EVT_FEAT_C3STOP))
+	if (!tick_device_may_c3stop(dev))
 		return 1;
 	return tick_broadcast_oneshot_available();
 }
--- 0001/kernel/time/tick-internal.h
+++ work/kernel/time/tick-internal.h	2013-06-18 15:40:10.000000000 +0900
@@ -141,6 +141,17 @@ static inline int tick_device_is_functio
 	return !(dev->features & CLOCK_EVT_FEAT_DUMMY);
 }
 
+/*
+ * Check, if the device has C3STOP behavior and CPU Idle is enabled
+ */
+static inline bool tick_device_may_c3stop(struct clock_event_device *dev)
+{
+	/* The C3 sleep mode can only trigger when CPU Idle is enabled,
+	 * so if CPU Idle is disabled then the C3STOP flag can be ignored */
+	return (IS_ENABLED(CONFIG_CPU_IDLE) &&
+		(dev->features & CLOCK_EVT_FEAT_C3STOP));
+}
+
 #endif
 
 extern void do_timer(unsigned long ticks);

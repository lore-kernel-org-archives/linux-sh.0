From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:32:51 +0000
Subject: [PATCH 03/10] clockevent: add clockevent_unregister()
Message-Id: <20081201103251.26620.23653.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add support for clockevent unregistration. This is used to switch
the boot timer from early timer device to regular platform device.

Also useful for unloading clockevent driver modules. Not sure if
this patch is correct and if it will work well with broadcast timers.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/linux/clockchips.h |    2 ++
 kernel/time/clockevents.c  |   22 ++++++++++++++++++++--
 kernel/time/tick-common.c  |   27 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

--- 0001/include/linux/clockchips.h
+++ work/include/linux/clockchips.h	2008-12-01 12:32:01.000000000 +0900
@@ -29,6 +29,7 @@ enum clock_event_mode {
 /* Clock event notification values */
 enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_ADD,
+	CLOCK_EVT_NOTIFY_DEL,
 	CLOCK_EVT_NOTIFY_BROADCAST_ON,
 	CLOCK_EVT_NOTIFY_BROADCAST_OFF,
 	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
@@ -118,6 +119,7 @@ static inline unsigned long div_sc(unsig
 extern unsigned long clockevent_delta2ns(unsigned long latch,
 					 struct clock_event_device *evt);
 extern void clockevents_register_device(struct clock_event_device *dev);
+extern void clockevents_unregister_device(struct clock_event_device *dev);
 
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
--- 0004/kernel/time/clockevents.c
+++ work/kernel/time/clockevents.c	2008-12-01 12:32:01.000000000 +0900
@@ -165,8 +165,10 @@ static void clockevents_notify_released(
 		dev = list_entry(clockevents_released.next,
 				 struct clock_event_device, list);
 		list_del(&dev->list);
-		list_add(&dev->list, &clockevent_devices);
-		clockevents_do_notify(CLOCK_EVT_NOTIFY_ADD, dev);
+		if (dev->mode = CLOCK_EVT_MODE_UNUSED) {
+			list_add(&dev->list, &clockevent_devices);
+			clockevents_do_notify(CLOCK_EVT_NOTIFY_ADD, dev);
+		}
 	}
 }
 
@@ -186,6 +188,22 @@ void clockevents_register_device(struct 
 	spin_unlock(&clockevents_lock);
 }
 
+/**
+ * clockevents_unregister_device - unregister a clock event device
+ * @dev:	device to register
+ */
+void clockevents_unregister_device(struct clock_event_device *dev)
+{
+	spin_lock(&clockevents_lock);
+
+	clockevents_do_notify(CLOCK_EVT_NOTIFY_DEL, dev);
+	clockevents_notify_released();
+
+	spin_unlock(&clockevents_lock);
+
+	BUG_ON(dev->mode != CLOCK_EVT_MODE_SHUTDOWN);
+}
+
 /*
  * Noop handler when we shut down an event device
  */
--- 0001/kernel/time/tick-common.c
+++ work/kernel/time/tick-common.c	2008-12-01 12:32:01.000000000 +0900
@@ -274,6 +274,30 @@ out_bc:
 }
 
 /*
+ * Delete device.
+ */
+static int tick_del_device(void)
+{
+	struct clock_event_device *curdev;
+	struct tick_device *td;
+	int cpu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tick_device_lock, flags);
+	cpu = smp_processor_id();
+	td = &per_cpu(tick_cpu_device, cpu);
+	curdev = td->evtdev;
+	td->mode = TICKDEV_MODE_PERIODIC;
+	if (curdev) {
+		clockevents_exchange_device(curdev, NULL);
+		td->evtdev = NULL;
+		clockevents_shutdown(curdev);
+	}
+	spin_unlock_irqrestore(&tick_device_lock, flags);
+	return NOTIFY_STOP;
+}
+
+/*
  * Shutdown an event device on a given cpu:
  *
  * This is called on a life CPU, when a CPU is dead. So we cannot
@@ -346,6 +370,9 @@ static int tick_notify(struct notifier_b
 	case CLOCK_EVT_NOTIFY_ADD:
 		return tick_check_new_device(dev);
 
+	case CLOCK_EVT_NOTIFY_DEL:
+		return tick_del_device();
+
 	case CLOCK_EVT_NOTIFY_BROADCAST_ON:
 	case CLOCK_EVT_NOTIFY_BROADCAST_OFF:
 	case CLOCK_EVT_NOTIFY_BROADCAST_FORCE:

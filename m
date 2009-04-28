From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Apr 2009 08:19:50 +0000
Subject: [PATCH] sh: setup timers in late_time_init()
Message-Id: <20090428081950.16616.54750.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch moves the SuperH timer setup code from time_init()
to late_time_init(). Good things about this change:
 - interrupts: they are enabled at late_time_init()
 - mm: regular kmalloc() can be used at late_time_init()

Together with moving to late_time_init() this patch changes
the sh_cmt driver to always allocate with kmalloc(). This
simplifies the code a bit and also fixes section mismatches.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/time_32.c     |   34 ++++++++++++++++++++--------------
 drivers/clocksource/sh_cmt.c |   13 ++-----------
 2 files changed, 22 insertions(+), 25 deletions(-)

--- 0001/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2009-04-28 12:56:26.000000000 +0900
@@ -237,21 +237,8 @@ unsigned long long sched_clock(void)
 }
 #endif
 
-void __init time_init(void)
+static void __init sh_late_time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
-
-	clk_init();
-
-	rtc_sh_get_time(&xtime);
-	set_normalized_timespec(&wall_to_monotonic,
-				-xtime.tv_sec, -xtime.tv_nsec);
-
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-	local_timer_setup(smp_processor_id());
-#endif
-
 	/*
 	 * Make sure all compiled-in early timers register themselves.
 	 * Run probe() for one "earlytimer" device.
@@ -270,3 +257,22 @@ void __init time_init(void)
 
 	printk(KERN_INFO "Using %s for system timer\n", sys_timer->name);
 }
+
+void __init time_init(void)
+{
+	if (board_time_init)
+		board_time_init();
+
+	clk_init();
+
+	rtc_sh_get_time(&xtime);
+	set_normalized_timespec(&wall_to_monotonic,
+				-xtime.tv_sec, -xtime.tv_nsec);
+
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	local_timer_setup(smp_processor_id());
+#endif
+
+	late_time_init = sh_late_time_init;
+}
+
--- 0003/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2009-04-28 12:41:39.000000000 +0900
@@ -18,7 +18,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -645,11 +644,7 @@ static int __devinit sh_cmt_probe(struct
 		return 0;
 	}
 
-	if (is_early_platform_device(pdev))
-		p = alloc_bootmem(sizeof(*p));
-	else
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
-
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
 	if (p = NULL) {
 		dev_err(&pdev->dev, "failed to allocate driver data\n");
 		return -ENOMEM;
@@ -657,11 +652,7 @@ static int __devinit sh_cmt_probe(struct
 
 	ret = sh_cmt_setup(p, pdev);
 	if (ret) {
-		if (is_early_platform_device(pdev))
-			free_bootmem(__pa(p), sizeof(*p));
-		else
-			kfree(p);
-
+		kfree(p);
 		platform_set_drvdata(pdev, NULL);
 	}
 	return ret;

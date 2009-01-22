From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Jan 2009 09:55:49 +0000
Subject: [PATCH 03/05] sh: fix no sys_timer case
Message-Id: <20090122095549.31653.60239.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Handle the case with a sys_timer set to NULL.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/time_32.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- 0015/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2009-01-22 16:24:35.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/clockchips.h>
 #include <linux/mc146818rtc.h>	/* for rtc_lock */
 #include <linux/smp.h>
+#include <linux/platform_device.h>
 #include <asm/clock.h>
 #include <asm/rtc.h>
 #include <asm/timer.h>
@@ -181,7 +182,12 @@ static struct sysdev_class timer_sysclas
 
 static int __init timer_init_sysfs(void)
 {
-	int ret = sysdev_class_register(&timer_sysclass);
+	int ret;
+
+	if (!sys_timer)
+		return 0;
+
+	ret = sysdev_class_register(&timer_sysclass);
 	if (ret != 0)
 		return ret;
 
@@ -230,5 +236,8 @@ void __init time_init(void)
 	 * initialized for us.
 	 */
 	sys_timer = get_sys_timer();
-	printk(KERN_INFO "Using %s for system timer\n", sys_timer->name);
+	if (sys_timer)
+		pr_info("Using %s for system timer\n", sys_timer->name);
+	else
+		pr_warning("System timer missing, boot will fail.\n");
 }

From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 10:50:12 +0000
Subject: [PATCH 02/05] sh: arch earlytimer support
Message-Id: <20090415105012.29940.70431.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Extend the 32-bit SuperH timer code to register and probe
the earlytimer class of Early Platform Drivers.

This registers the sh_cmt driver if compiled-in.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/time_32.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2009-04-15 16:59:31.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/clockchips.h>
 #include <linux/mc146818rtc.h>	/* for rtc_lock */
+#include <linux/platform_device.h>
 #include <linux/smp.h>
 #include <asm/clock.h>
 #include <asm/rtc.h>
@@ -233,6 +234,14 @@ void __init time_init(void)
 	 * initialized for us.
 	 */
 	sys_timer = get_sys_timer();
+
+	/* Make sure all compiled-in early timers register themselves.
+	 * Run probe() for one "earlytimer" device.
+	 */
+	early_platform_driver_register_all("earlytimer");
+	if (early_platform_driver_probe("earlytimer", 1, 0))
+		return;
+
 	if (unlikely(!sys_timer))
 		panic("System timer missing.\n");
 

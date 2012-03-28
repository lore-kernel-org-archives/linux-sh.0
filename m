From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 06:40:26 +0000
Subject: [PATCH 01/06] ARM: mach-shmobile: Introduce shmobile_setup_delay()
Message-Id: <20120328064026.28557.5982.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add the function shmobile_setup_delay() to let platforms
configure their maximum loops per jiffy delay. With this
jiffies calculation done the dependency on early timer
is removed.

In the future this allows us to assign timers
using the regular driver model via the device tree.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    2 ++
 arch/arm/mach-shmobile/timer.c               |   17 +++++++++++++++++
 2 files changed, 19 insertions(+)

--- 0031/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-03-06 13:43:42.000000000 +0900
@@ -3,6 +3,8 @@
 
 extern void shmobile_earlytimer_init(void);
 extern struct sys_timer shmobile_timer;
+extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
+				 unsigned int mult, unsigned int div);
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
 extern int shmobile_platform_cpu_kill(unsigned int cpu);
--- 0031/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2012-03-06 13:44:29.000000000 +0900
@@ -19,8 +19,25 @@
  *
  */
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <asm/mach/time.h>
 
+void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
+				 unsigned int mult, unsigned int div)
+{
+	/* calculate a worst-case loops-per-jiffy value
+	 * based on maximum cpu core mhz setting and the
+	 * __delay() implementation in arch/arm/lib/delay.S
+	 *
+	 * this will result in a longer delay than expected
+	 * when the cpu core runs on lower frequencies.
+	 */
+
+	unsigned int value = (1000000 * mult) / (HZ * div);
+
+	lpj_fine = max_cpu_core_mhz * value;
+}
+
 static void __init shmobile_late_time_init(void)
 {
 	/*

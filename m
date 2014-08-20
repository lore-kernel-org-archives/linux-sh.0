From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:03:12 +0000
Subject: [PATCH 08/10] ARM: shmobile: Remove shmobile_setup_delay()
Message-Id: <20140820130312.32075.52599.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

All ARM mach-shmobile SoCs and boards now rely on DTS for
CPU Frequency information, so remove the unused function
shmobile_setup_delay(). While at it, make the function
shmobile_setup_delay_hz() static.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/common.h |    2 --
 arch/arm/mach-shmobile/timer.c  |   21 ++-------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

--- 0001/arch/arm/mach-shmobile/common.h
+++ work/arch/arm/mach-shmobile/common.h	2014-08-20 21:21:09.000000000 +0900
@@ -2,8 +2,6 @@
 #define __ARCH_MACH_COMMON_H
 
 extern void shmobile_earlytimer_init(void);
-extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-			 unsigned int mult, unsigned int div);
 extern void shmobile_init_delay(void);
 struct twd_local_timer;
 extern void shmobile_setup_console(void);
--- 0001/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2014-08-20 21:21:40.000000000 +0900
@@ -23,8 +23,8 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 
-void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
-				    unsigned int mult, unsigned int div)
+static void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
+					   unsigned int mult, unsigned int div)
 {
 	/* calculate a worst-case loops-per-jiffy value
 	 * based on maximum cpu core hz setting and the
@@ -40,23 +40,6 @@ void __init shmobile_setup_delay_hz(unsi
 		preset_lpj = max_cpu_core_hz / value;
 }
 
-void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
-				 unsigned int mult, unsigned int div)
-{
-	/* calculate a worst-case loops-per-jiffy value
-	 * based on maximum cpu core mhz setting and the
-	 * __delay() implementation in arch/arm/lib/delay.S
-	 *
-	 * this will result in a longer delay than expected
-	 * when the cpu core runs on lower frequencies.
-	 */
-
-	unsigned int value = (1000000 * mult) / (HZ * div);
-
-	if (!preset_lpj)
-		preset_lpj = max_cpu_core_mhz * value;
-}
-
 void __init shmobile_init_delay(void)
 {
 	struct device_node *np, *cpus;

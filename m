From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Mar 2012 08:36:14 +0000
Subject: [PATCH 01/08] ARM: mach-shmobile: add shmobile_earlytimer_init()
Message-Id: <20120306083614.8131.7386.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add shmobile_earlytimer_init() that can be used to
enable the earlytimer probing from the SoC code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/timer.c               |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

--- 0026/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-03-06 12:40:16.000000000 +0900
@@ -1,6 +1,7 @@
 #ifndef __ARCH_MACH_COMMON_H
 #define __ARCH_MACH_COMMON_H
 
+extern void shmobile_earlytimer_init(void);
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
--- 0001/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2012-03-06 12:40:02.000000000 +0900
@@ -36,11 +36,16 @@ static void __init shmobile_late_time_in
 	early_platform_driver_probe("earlytimer", 2, 0);
 }
 
-static void __init shmobile_timer_init(void)
+void __init shmobile_earlytimer_init(void)
 {
 	late_time_init = shmobile_late_time_init;
 }
 
+static void __init shmobile_timer_init(void)
+{
+	shmobile_earlytimer_init();
+}
+
 struct sys_timer shmobile_timer = {
 	.init		= shmobile_timer_init,
 };

From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Dec 2011 07:47:16 +0000
Subject: [PATCH] ARM: mach-shmobile: Allow SoC specific CPU kill code
Message-Id: <20111228074716.14231.48713.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add the function shmobile_platform_kill_cpu() to allow
SoC specific code to tie in their CPU shutdown code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/hotplug.c             |    3 ++-
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/platsmp.c             |    5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/hotplug.c
+++ work/arch/arm/mach-shmobile/hotplug.c	2011-12-28 14:50:29.000000000 +0900
@@ -12,10 +12,11 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
+#include <mach/common.h>
 
 int platform_cpu_kill(unsigned int cpu)
 {
-	return 1;
+	return shmobile_platform_cpu_kill(cpu);
 }
 
 void platform_cpu_die(unsigned int cpu)
--- 0023/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-12-28 14:50:06.000000000 +0900
@@ -4,6 +4,7 @@
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 extern void shmobile_secondary_vector(void);
+extern int shmobile_platform_cpu_kill(unsigned int cpu);
 struct clk;
 extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
--- 0023/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2011-12-28 14:48:58.000000000 +0900
@@ -44,6 +44,11 @@ static void __init shmobile_smp_prepare_
 		r8a7779_smp_prepare_cpus();
 }
 
+int shmobile_platform_cpu_kill(unsigned int cpu)
+{
+	return 1;
+}
+
 void __cpuinit platform_secondary_init(unsigned int cpu)
 {
 	trace_hardirqs_off();

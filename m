From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 07:21:19 +0000
Subject: [PATCH v2 07/07] ARM: shmobile: Allow r8a7791 to build non-SMP APMU code
Message-Id: <20140606072119.14868.66441.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the APMU for r8a7791 even though SMP is
disabled in the kernel config. Also initialize
Suspend-to-RAM from pm-r8a7791.c to in the future
cover both UP and SMP use cases of the APMU.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Makefile      |    5 +++--
 arch/arm/mach-shmobile/pm-r8a7791.c  |    1 +
 arch/arm/mach-shmobile/smp-r8a7791.c |    1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

--- 0014/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-06-06 15:00:42.000000000 +0900
@@ -37,13 +37,14 @@ endif
 # CPU reset vector handling objects
 cpu-y				:= platsmp.o headsmp.o
 cpu-$(CONFIG_ARCH_R8A7790)	+= platsmp-apmu.o
+cpu-$(CONFIG_ARCH_R8A7791)	+= platsmp-apmu.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
-smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o platsmp-apmu.o
+smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
@@ -55,7 +56,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
 obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o $(cpu-y)
-obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o $(cpu-y)
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
--- 0015/arch/arm/mach-shmobile/pm-r8a7791.c
+++ work/arch/arm/mach-shmobile/pm-r8a7791.c	2014-06-06 15:01:29.000000000 +0900
@@ -68,4 +68,5 @@ void __init r8a7791_pm_init(void)
 	iounmap(p);
 
 	r8a7791_sysc_init();
+	shmobile_smp_apmu_suspend_init();
 }
--- 0015/arch/arm/mach-shmobile/smp-r8a7791.c
+++ work/arch/arm/mach-shmobile/smp-r8a7791.c	2014-06-06 15:01:05.000000000 +0900
@@ -28,7 +28,6 @@ static void __init r8a7791_smp_prepare_c
 	shmobile_smp_apmu_prepare_cpus(max_cpus);
 
 	r8a7791_pm_init();
-	shmobile_smp_apmu_suspend_init();
 }
 
 static int r8a7791_smp_boot_secondary(unsigned int cpu,

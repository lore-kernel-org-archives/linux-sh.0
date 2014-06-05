From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:15:36 +0000
Subject: [PATCH 04/08] ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
Message-Id: <20140605051536.18075.24742.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the APMU for r8a7790 even though SMP is
disabled in the kernel config. Also initialize
Suspend-to-RAM from pm-r8a7790.c to in the futre
cover both UP and SMP use cases of the APMU.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Makefile      |    5 +++--
 arch/arm/mach-shmobile/pm-r8a7790.c  |    1 +
 arch/arm/mach-shmobile/smp-r8a7790.c |    1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

--- 0002/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-06-05 11:59:50.000000000 +0900
@@ -36,12 +36,13 @@ endif
 
 # CPU reset vector handling objects
 cpu-y				:= platsmp.o headsmp.o
+cpu-$(CONFIG_ARCH_R8A7790)	+= platsmp-apmu.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
-smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o platsmp-apmu.o
+smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o platsmp-apmu.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
@@ -53,7 +54,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o $(cpu-y)
 obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # IRQ objects
--- 0004/arch/arm/mach-shmobile/pm-r8a7790.c
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c	2014-06-05 11:43:02.000000000 +0900
@@ -78,4 +78,5 @@ void __init r8a7790_pm_init(void)
 	iounmap(p);
 
 	r8a7790_sysc_init();
+	shmobile_smp_apmu_suspend_init();
 }
--- 0004/arch/arm/mach-shmobile/smp-r8a7790.c
+++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2014-06-05 11:42:49.000000000 +0900
@@ -39,7 +39,6 @@ static void __init r8a7790_smp_prepare_c
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
-	shmobile_smp_apmu_suspend_init();
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }

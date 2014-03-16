From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Mar 2014 21:35:29 +0000
Subject: [PATCH 01/06] ARM: shmobile: Allow non-SMP reset hook usage
Message-Id: <20140316213529.15598.7234.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow use of shmobile_smp_hook() regardless if CONFIG_SMP
is enabled or not. This to keep same interface for both SMP
and UP cases.

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile  |    5 ++++-
 arch/arm/mach-shmobile/headsmp.S |   15 +++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile
@@ -47,13 +47,15 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
 obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
 
+# CPU PM objects
+cpu-y				:= cpuidle.o platsmp.o headsmp.o
+
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
@@ -79,3 +81,4 @@ endif
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
+obj-$(CONFIG_CPU_IDLE)		+= $(cpu-y)
--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S
@@ -14,11 +14,18 @@
 #include <linux/init.h>
 #include <asm/memory.h>
 
+#ifdef CONFIG_SMP
+#define HEADSMP_NR_CPUS CONFIG_NR_CPUS
+	
 ENTRY(shmobile_invalidate_start)
 	bl	v7_invalidate_l1
 	b	secondary_startup
 ENDPROC(shmobile_invalidate_start)
 
+#else
+#define HEADSMP_NR_CPUS 1
+#endif
+
 /*
  * Reset vector for secondary CPUs.
  * This will be mapped at address 0 by SBAR register.
@@ -68,7 +75,7 @@ shmobile_smp_boot_find_mpidr:
 
 shmobile_smp_boot_next:
 	add	r1, r1, #1
-	cmp	r1, #CONFIG_NR_CPUS
+	cmp	r1, #HEADSMP_NR_CPUS
 	blo	shmobile_smp_boot_find_mpidr
 
 	b	shmobile_smp_sleep
@@ -85,10 +92,10 @@ ENDPROC(shmobile_smp_sleep)
 
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
-1:	.space	CONFIG_NR_CPUS * 4
+1:	.space	HEADSMP_NR_CPUS * 4
 	.globl	shmobile_smp_fn
 shmobile_smp_fn:
-2:	.space	CONFIG_NR_CPUS * 4
+2:	.space	HEADSMP_NR_CPUS * 4
 	.globl	shmobile_smp_arg
 shmobile_smp_arg:
-3:	.space	CONFIG_NR_CPUS * 4
+3:	.space	HEADSMP_NR_CPUS * 4

From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:32:12 +0000
Subject: [PATCH 05/06] ARM: shmobile: Cleanup pm-rcar.o build using Kconfig
Message-Id: <20140820133212.808.66810.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a CONFIG_PM_RCAR entry and enable it for R-Car
Generation 1 or 2 in case CONFIG_PM or CONFIG_SMP
is set. Consolidate power management objects and
get rid of #ifdefs in the C code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig   |    5 +++++
 arch/arm/mach-shmobile/Makefile  |   10 ++++------
 arch/arm/mach-shmobile/pm-rcar.c |    4 ----
 3 files changed, 9 insertions(+), 10 deletions(-)

--- 0005/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-19 22:23:13.000000000 +0900
@@ -2,13 +2,18 @@ config ARCH_SHMOBILE
 	bool
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 
+config PM_RCAR
+	bool
+
 config ARCH_RCAR_GEN1
 	bool
+	select PM_RCAR if PM || SMP
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_RCAR_GEN2
 	bool
+	select PM_RCAR if PM || SMP
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 
--- 0005/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-08-19 22:24:59.000000000 +0900
@@ -11,9 +11,9 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
-obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o pm-r8a7791.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
@@ -48,12 +48,10 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
+obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
-obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
--- 0001/arch/arm/mach-shmobile/pm-rcar.c
+++ work/arch/arm/mach-shmobile/pm-rcar.c	2014-08-19 22:26:10.000000000 +0900
@@ -31,8 +31,6 @@
 #define SYSCISR_RETRIES 1000
 #define SYSCISR_DELAY_US 1
 
-#if defined(CONFIG_PM) || defined(CONFIG_SMP)
-
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
@@ -137,5 +135,3 @@ void __iomem *rcar_sysc_init(phys_addr_t
 
 	return rcar_sysc_base;
 }
-
-#endif /* CONFIG_PM || CONFIG_SMP */

From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 09:42:34 +0000
Subject: [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <20141217094234.7039.79623.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable sh73a0 Multiplatform support for the generic sh73a0
machine vector. No board support is enabled, and the board
code for KZM9G DT Reference is left by itself.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig        |    5 +++++
 arch/arm/mach-shmobile/Makefile       |    4 ++--
 arch/arm/mach-shmobile/setup-sh73a0.c |    5 ++++-
 arch/arm/mach-shmobile/smp-sh73a0.c   |    2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-12-16 19:11:36.000000000 +0900
@@ -52,6 +52,11 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select SYS_SUPPORTS_SH_MTU2
 
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_RMOBILE
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-12-16 19:12:19.000000000 +0900
@@ -7,7 +7,7 @@ obj-y				:= timer.o console.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o pm-sh7372.o
-obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o pm-sh73a0.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
@@ -65,7 +65,7 @@ obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
-obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
+obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o intc-sh73a0.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
 
--- 0011/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-12-16 19:13:33.000000000 +0900
@@ -764,7 +764,9 @@ void __init __weak sh73a0_register_twd(v
 void __init sh73a0_earlytimer_init(void)
 {
 	shmobile_init_delay();
+#ifndef CONFIG_COMMON_CLK
 	sh73a0_clock_init();
+#endif
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
 }
@@ -780,9 +782,10 @@ void __init sh73a0_add_early_devices(voi
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
+#ifndef CONFIG_COMMON_CLK
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
-
+#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2014-12-16 19:15:10.000000000 +0900
@@ -33,7 +33,7 @@
 
 #define SH73A0_SCU_BASE 0xf0000000
 
-#ifdef CONFIG_HAVE_ARM_TWD
+#if defined(CONFIG_HAVE_ARM_TWD) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
 void __init sh73a0_register_twd(void)
 {

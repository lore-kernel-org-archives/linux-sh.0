From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 02:28:56 +0000
Subject: [PATCH 02/03] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <20140904022856.26216.25574.sendpatchset@w520>
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
 3 files changed, 11 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-09-04 10:48:28.000000000 +0900
@@ -50,6 +50,11 @@ config ARCH_R7S72100
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
+++ work/arch/arm/mach-shmobile/Makefile	2014-09-04 10:48:28.000000000 +0900
@@ -7,7 +7,7 @@ obj-y				:= timer.o console.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o pm-sh7372.o
-obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o pm-sh73a0.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
@@ -70,7 +70,7 @@ obj-$(CONFIG_MACH_LAGER)	+= board-lager.
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
-obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
+obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o intc-sh73a0.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
 
--- 0002/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-09-04 10:59:10.000000000 +0900
@@ -757,7 +757,9 @@ void __init __weak sh73a0_register_twd(v
 void __init sh73a0_earlytimer_init(void)
 {
 	sh73a0_init_delay();
+#ifndef CONFIG_COMMON_CLK
 	sh73a0_clock_init();
+#endif
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
 }
@@ -775,9 +777,10 @@ void __init sh73a0_add_early_devices(voi
 
 void __init sh73a0_add_standard_devices_dt(void)
 {
+#ifndef CONFIG_COMMON_CLK
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
-
+#endif
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

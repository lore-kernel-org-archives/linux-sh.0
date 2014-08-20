From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:32:03 +0000
Subject: [PATCH 04/06] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen2
Message-Id: <20140820133203.808.85577.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a Kconfig entry for R-Car Generation 2 SoCs that
enables CMT timer and the IRQC interrupt driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig  |   17 +++++++++--------
 arch/arm/mach-shmobile/Makefile |   12 ++++++------
 2 files changed, 15 insertions(+), 14 deletions(-)

--- 0004/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-19 22:14:24.000000000 +0900
@@ -7,6 +7,11 @@ config ARCH_RCAR_GEN1
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
+config ARCH_RCAR_GEN2
+	bool
+	select RENESAS_IRQC
+	select SYS_SUPPORTS_SH_CMT
+
 config ARCH_RMOBILE
 	bool
 	select SYS_SUPPORTS_SH_CMT
@@ -43,13 +48,11 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
+	select ARCH_RCAR_GEN2
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
+	select ARCH_RCAR_GEN2
 
 comment "Renesas ARM SoCs Board Type"
 
@@ -123,22 +126,20 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
+	select ARCH_RCAR_GEN2
 	select ARM_GIC
 	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
+	select ARCH_RCAR_GEN2
 	select ARM_GIC
 	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 comment "Renesas ARM SoCs Board Type"
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-08-19 22:21:23.000000000 +0900
@@ -13,8 +13,7 @@ obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
@@ -33,8 +32,9 @@ endif
 
 # CPU reset vector handling objects
 cpu-y				:= platsmp.o headsmp.o
-cpu-$(CONFIG_ARCH_R8A7790)	+= platsmp-apmu.o
-cpu-$(CONFIG_ARCH_R8A7791)	+= platsmp-apmu.o
+
+# Shared SoC family objects
+obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 
 # SMP objects
 smp-y				:= $(cpu-y)
@@ -52,8 +52,8 @@ obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o $(cpu-y)
-obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o $(cpu-y)
+obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o

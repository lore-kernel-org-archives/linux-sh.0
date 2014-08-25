From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:45:50 +0000
Subject: [PATCH 02/03] ARM: shmobile: Consolidate Legacy SH_CLK_CPG Kconfig
Message-Id: <20140825034550.9316.14635.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Consolidate SH_CLK_CPG under ARCH_SHMOBILE_LEGACY so it can
be shared by the legacy ARM mach-shmobile support code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/Kconfig               |    1 +
 arch/arm/mach-shmobile/Kconfig |    8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

--- 0007/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2014-08-25 12:13:59.000000000 +0900
@@ -661,6 +661,7 @@ config ARCH_SHMOBILE_LEGACY
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
+	select SH_CLK_CPG
 	select SPARSE_IRQ
 	help
 	  Support for Renesas ARM SoC platforms using a non-multiplatform
--- 0007/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-25 12:14:51.000000000 +0900
@@ -91,7 +91,6 @@ config ARCH_SH7372
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
-	select SH_CLK_CPG
 	select SH_INTC
 
 config ARCH_SH73A0
@@ -100,7 +99,6 @@ config ARCH_SH73A0
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select I2C
-	select SH_CLK_CPG
 	select SH_INTC
 	select RENESAS_INTC_IRQPIN
 
@@ -109,7 +107,6 @@ config ARCH_R8A73A4
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select SH_CLK_CPG
 	select RENESAS_IRQC
 
 config ARCH_R8A7740
@@ -117,14 +114,12 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select SH_CLK_CPG
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select SH_CLK_CPG
 	select ARM_GIC
 
 config ARCH_R8A7779
@@ -132,7 +127,6 @@ config ARCH_R8A7779
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select SH_CLK_CPG
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
@@ -140,7 +134,6 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
-	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
@@ -149,7 +142,6 @@ config ARCH_R8A7791
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
-	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 comment "Renesas ARM SoCs Board Type"

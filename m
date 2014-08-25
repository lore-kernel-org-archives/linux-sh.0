From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:45:59 +0000
Subject: [PATCH 03/03] ARM: shmobile: Consolidate Legacy GPIOLIB Kconfig bits
Message-Id: <20140825034559.9316.68303.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Consolidate ARCH_WANT_OPTIONAL_GPIOLIB under ARCH_SHMOBILE_LEGACY
so it can be shared by the legacy ARM mach-shmobile code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/Kconfig               |    1 +
 arch/arm/mach-shmobile/Kconfig |    8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

--- 0008/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2014-08-25 12:16:25.000000000 +0900
@@ -648,6 +648,7 @@ config ARCH_MSM
 config ARCH_SHMOBILE_LEGACY
 	bool "Renesas ARM SoCs (non-multiplatform)"
 	select ARCH_SHMOBILE
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_PATCH_PHYS_VIRT if MMU
 	select CLKDEV_LOOKUP
 	select CPU_V7
--- 0008/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-25 12:17:10.000000000 +0900
@@ -89,14 +89,12 @@ comment "Renesas ARM SoCs System Type"
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
 	select ARCH_RMOBILE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
 	select SH_INTC
 
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
 	select ARCH_RMOBILE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select I2C
 	select SH_INTC
@@ -105,33 +103,28 @@ config ARCH_SH73A0
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
 	select ARCH_RMOBILE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select RENESAS_IRQC
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
 	select ARCH_RMOBILE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_RCAR_GEN1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select ARCH_RCAR_GEN2
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
@@ -139,7 +132,6 @@ config ARCH_R8A7790
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select ARCH_RCAR_GEN2
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE

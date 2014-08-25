From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:45:41 +0000
Subject: [PATCH 01/03] ARM: shmobile: Consolidate Legacy CPU_V7 Kconfig
Message-Id: <20140825034541.9316.31816.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Consolidate CPU_V7 under ARCH_SHMOBILE_LEGACY so it can
be shared by the legacy ARM mach-shmobile support code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/Kconfig               |    1 +
 arch/arm/mach-shmobile/Kconfig |    8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

--- 0001/arch/arm/Kconfig
+++ work/arch/arm/Kconfig	2014-08-25 12:12:10.000000000 +0900
@@ -650,6 +650,7 @@ config ARCH_SHMOBILE_LEGACY
 	select ARCH_SHMOBILE
 	select ARM_PATCH_PHYS_VIRT if MMU
 	select CLKDEV_LOOKUP
+	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
--- 0006/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-25 12:12:37.000000000 +0900
@@ -91,7 +91,6 @@ config ARCH_SH7372
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
-	select CPU_V7
 	select SH_CLK_CPG
 	select SH_INTC
 
@@ -100,7 +99,6 @@ config ARCH_SH73A0
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select I2C
 	select SH_CLK_CPG
 	select SH_INTC
@@ -111,7 +109,6 @@ config ARCH_R8A73A4
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
@@ -120,7 +117,6 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_INTC_IRQPIN
 
@@ -128,7 +124,6 @@ config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
 
@@ -137,7 +132,6 @@ config ARCH_R8A7779
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select SH_CLK_CPG
 
 config ARCH_R8A7790
@@ -145,7 +139,6 @@ config ARCH_R8A7790
 	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
@@ -155,7 +148,6 @@ config ARCH_R8A7791
 	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE

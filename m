From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:31:34 +0000
Subject: [PATCH 01/06] ARM: shmobile: Consolidate GPIOLIB Kconfig bits
Message-Id: <20140820133134.808.38907.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Consolidate ARCH_WANT_OPTIONAL_GPIOLIB under ARCH_SHMOBILE
so it can be shared by Legacy and Multiplatform.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-19 21:46:43.000000000 +0900
@@ -1,5 +1,6 @@
 config ARCH_SHMOBILE
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 menuconfig ARCH_SHMOBILE_MULTI
 	bool "Renesas ARM SoCs" if ARCH_MULTI_V7
@@ -67,7 +68,6 @@ comment "Renesas ARM SoCs System Type"
 
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
 	select CPU_V7
 	select SH_CLK_CPG
@@ -76,7 +76,6 @@ config ARCH_SH7372
 
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select I2C
@@ -87,7 +86,6 @@ config ARCH_SH73A0
 
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
@@ -97,7 +95,6 @@ config ARCH_R8A73A4
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
@@ -107,7 +104,6 @@ config ARCH_R8A7740
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
@@ -116,7 +112,6 @@ config ARCH_R8A7778
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
@@ -125,7 +120,6 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select MIGHT_HAVE_PCI
@@ -136,7 +130,6 @@ config ARCH_R8A7790
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select MIGHT_HAVE_PCI

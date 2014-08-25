From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:03:34 +0000
Subject: [PATCH v2 02/05] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen1
Message-Id: <20140825030334.1936.26302.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a Kconfig entry for R-Car Generation 1 SoCs that
enables TMU timer and the INTC IRQPIN driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 Changes since V1:
 - Removed dependency of "ARM: shmobile: Consolidate GPIOLIB Kconfig bits"

 arch/arm/mach-shmobile/Kconfig |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- 0002/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-25 11:30:27.000000000 +0900
@@ -1,6 +1,11 @@
 config ARCH_SHMOBILE
 	bool
 
+config ARCH_RCAR_GEN1
+	bool
+	select RENESAS_INTC_IRQPIN
+	select SYS_SUPPORTS_SH_TMU
+
 config ARCH_RMOBILE
 	bool
 	select SYS_SUPPORTS_SH_CMT
@@ -33,8 +38,7 @@ config ARCH_R7S72100
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
-	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_TMU
+	select ARCH_RCAR_GEN1
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
@@ -110,21 +114,19 @@ config ARCH_R8A7740
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
-	select SYS_SUPPORTS_SH_TMU
-	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
+	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
-	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"

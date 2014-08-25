From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:03:25 +0000
Subject: [PATCH v2 01/05] ARM: shmobile: Introduce a Kconfig entry for R-Mobile
Message-Id: <20140825030325.1936.4365.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a Kconfig entry for R-Mobile SoCs that enables
both CMT and TMU timers. Interrupt controller varies
with SoC version so it is excluded.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 Changes since V1:
 - Removed dependency of "ARM: shmobile: Consolidate GPIOLIB Kconfig bits"

 arch/arm/mach-shmobile/Kconfig |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-25 11:28:15.000000000 +0900
@@ -1,6 +1,11 @@
 config ARCH_SHMOBILE
 	bool
 
+config ARCH_RMOBILE
+	bool
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
+
 menuconfig ARCH_SHMOBILE_MULTI
 	bool "Renesas ARM SoCs" if ARCH_MULTI_V7
 	depends on MMU
@@ -67,16 +72,16 @@ comment "Renesas ARM SoCs System Type"
 
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
+	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
 	select CPU_V7
 	select SH_CLK_CPG
 	select SH_INTC
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_SH73A0
 	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
@@ -84,28 +89,24 @@ config ARCH_SH73A0
 	select SH_CLK_CPG
 	select SH_INTC
 	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
+	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_CMT
-	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Jul 2012 13:17:42 +0000
Subject: [PATCH] ARM: mach-shmobile: select the fixed regulator driver on several boards
Message-Id: <Pine.LNX.4.64.1207051515190.30191@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On systems, using regulators to supply power to devices, if the REGULATOR
Kconfig option is disabled, regulator API stubs will be used, which often
suffices to bring a default configuration up. If REGULATOR is enabled but
respective regulator drivers are inactive, the real regulator API calls
will be used, which in the absence of drivers will fail to provide
services. This patch prevents such a problem on sh-mobile boards by
forcing REGULATOR_FIXED_VOLTAGE on if REGULATOR is selected.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a2045dc..4a0d632 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -58,6 +58,7 @@ config MACH_G4EVM
 	bool "G4EVM board"
 	depends on ARCH_SH7377
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_AP4EVB
 	bool "AP4EVB board"
@@ -65,6 +66,7 @@ config MACH_AP4EVB
 	select ARCH_REQUIRE_GPIOLIB
 	select SH_LCD_MIPI_DSI
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 choice
 	prompt "AP4EVB LCD panel selection"
@@ -83,6 +85,7 @@ config MACH_AG5EVM
 	bool "AG5EVM board"
 	select ARCH_REQUIRE_GPIOLIB
 	select SH_LCD_MIPI_DSI
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on ARCH_SH73A0
 
 config MACH_MACKEREL
@@ -90,15 +93,18 @@ config MACH_MACKEREL
 	depends on ARCH_SH7372
 	select ARCH_REQUIRE_GPIOLIB
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_KOTA2
 	bool "KOTA2 board"
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on ARCH_SH73A0
 
 config MACH_BONITO
 	bool "bonito board"
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on ARCH_R8A7740
 
 config MACH_ARMADILLO800EVA
@@ -107,16 +113,19 @@ config MACH_ARMADILLO800EVA
 	select ARCH_REQUIRE_GPIOLIB
 	select USE_OF
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
 	select USE_OF
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config MACH_KZM9G
 	bool "KZM-A9-GT board"
@@ -124,6 +133,7 @@ config MACH_KZM9G
 	select ARCH_REQUIRE_GPIOLIB
 	select USE_OF
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 comment "SH-Mobile System Configuration"
 
-- 
1.7.2.5


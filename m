From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 Jul 2012 13:18:50 +0000
Subject: [PATCH] sh: select the fixed regulator driver on several boards
Message-Id: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
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
 arch/sh/boards/Kconfig |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 7048c03..fb58057 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -57,6 +57,7 @@ config SH_7724_SOLUTION_ENGINE
 	depends on CPU_SUBTYPE_SH7724
 	select ARCH_REQUIRE_GPIOLIB
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select 7724 SolutionEngine if configuring for a Hitachi SH7724
 	  evaluation board.
@@ -140,6 +141,7 @@ config SH_RSK
 	bool "Renesas Starter Kit"
 	depends on CPU_SUBTYPE_SH7201 || CPU_SUBTYPE_SH7203 || \
 	  CPU_SUBTYPE_SH7264 || CPU_SUBTYPE_SH7269
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	 Select this option if configuring for any of the RSK+ MCU
 	 evaluation platforms.
@@ -159,6 +161,7 @@ config SH_SDK7786
 	select NO_IOPORT if !PCI
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select HAVE_SRAM_POOL
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select SDK7786 if configuring for a Renesas Technology Europe
 	  SH7786-65nm board.
@@ -173,6 +176,7 @@ config SH_SH7757LCR
 	bool "SH7757LCR"
 	depends on CPU_SUBTYPE_SH7757
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config SH_SH7785LCR
 	bool "SH7785LCR"
@@ -206,6 +210,7 @@ config SH_MIGOR
 	bool "Migo-R"
 	depends on CPU_SUBTYPE_SH7722
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
           by Renesas System Solutions Asia Pte. Ltd.
@@ -214,6 +219,7 @@ config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Renesas "AP-325RXA" support.
 	  Compatible with ALGO SYSTEM CO.,LTD. "AP-320A"
@@ -222,6 +228,7 @@ config SH_KFR2R09
 	bool "KFR2R09"
 	depends on CPU_SUBTYPE_SH7724
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  "Kit For R2R for 2009" support.
 
@@ -230,6 +237,7 @@ config SH_ECOVEC
 	depends on CPU_SUBTYPE_SH7724
 	select ARCH_REQUIRE_GPIOLIB
 	select SND_SOC_DA7210 if SND_SIMPLE_CARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Renesas "R0P7724LC0011/21RL (EcoVec)" support.
 
@@ -305,6 +313,7 @@ config SH_MAGIC_PANEL_R2
 	bool "Magic Panel R2"
 	depends on CPU_SUBTYPE_SH7720
 	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Magic Panel R2 if configuring for Magic Panel R2.
 
@@ -316,6 +325,7 @@ config SH_CAYMAN
 config SH_POLARIS
 	bool "SMSC Polaris"
 	select CPU_HAS_IPR_IRQ
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on CPU_SUBTYPE_SH7709
 	help
 	  Select if configuring for an SMSC Polaris development board
@@ -323,6 +333,7 @@ config SH_POLARIS
 config SH_SH2007
 	bool "SH-2007 board"
 	select NO_IOPORT
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on CPU_SUBTYPE_SH7780
 	help
 	  SH-2007 is a single-board computer based around SH7780 chip
@@ -334,6 +345,7 @@ config SH_SH2007
 config SH_APSH4A3A
 	bool "AP-SH4A-3A"
 	select SH_ALPHA_BOARD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on CPU_SUBTYPE_SH7785
 	help
 	  Select AP-SH4A-3A if configuring for an ALPHAPROJECT AP-SH4A-3A.
@@ -342,6 +354,7 @@ config SH_APSH4AD0A
 	bool "AP-SH4AD-0A"
 	select SH_ALPHA_BOARD
 	select SYS_SUPPORTS_PCI
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	depends on CPU_SUBTYPE_SH7786
 	help
 	  Select AP-SH4AD-0A if configuring for an ALPHAPROJECT AP-SH4AD-0A.
-- 
1.7.2.5


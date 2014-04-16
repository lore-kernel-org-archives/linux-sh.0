From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Apr 2014 06:03:51 +0000
Subject: [PATCH 8/8] ARM: shmobile: r8a7778/bockw: Move "select RENESAS_INTC_IRQPIN" under SoC
Message-Id: <e35db38d66d1e4007cfc1bb90a05e11b4aaee2a8.1397627619.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Move the "select RENESAS_INTC_IRQPIN" from the two bockw-specific sections
to the one r8a7778-specific section, like is done for the other SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
[horms+renesas@verge.net.au: Resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ad0c6bc..58bc6db 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -108,6 +108,7 @@ config ARCH_R8A7778
 	select SH_CLK_CPG
 	select ARM_GIC
 	select SYS_SUPPORTS_SH_TMU
+	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
@@ -206,7 +207,6 @@ config MACH_BOCKW
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select RENESAS_INTC_IRQPIN
 	select SND_SOC_AK4554 if SND_SIMPLE_CARD
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
@@ -215,7 +215,6 @@ config MACH_BOCKW_REFERENCE
 	bool "BOCK-W  - Reference Device Tree Implementation"
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
-	select RENESAS_INTC_IRQPIN
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 	---help---
-- 
1.8.5.2


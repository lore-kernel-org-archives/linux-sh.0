From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 08:28:09 +0000
Subject: [PATCH] ARM: shmobile: r8a7791 is now called "R-Car M2-W"
Message-Id: <1409214489-6458-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As per recent revisions of the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
All remaining references to "M2" are in DT binding documentation or Kconfig
(drivers/iommu/Kconfig only) that still needs to be updated for new R-Car Gen2
SoCs.

 arch/arm/mach-shmobile/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c1023d758eeb..112e857d2c1c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -64,7 +64,7 @@ config ARCH_R8A7790
 	select ARCH_RCAR_GEN2
 
 config ARCH_R8A7791
-	bool "R-Car M2 (R8A77910)"
+	bool "R-Car M2-W (R8A77910)"
 	select ARCH_RCAR_GEN2
 
 comment "Renesas ARM SoCs Board Type"
@@ -142,7 +142,7 @@ config ARCH_R8A7790
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
-	bool "R-Car M2 (R8A77910)"
+	bool "R-Car M2-W (R8A77910)"
 	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-- 
1.9.1


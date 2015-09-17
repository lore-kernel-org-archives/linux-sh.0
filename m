From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Sep 2015 08:59:29 +0000
Subject: [PATCH 13/21] ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
Message-Id: <993f58c32c613b7155f3cab75ed4e2e6e6b3ec64.1442478814.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Obsoleted by removal of r8a7778 legacy platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6e07e981c8ff..61a59b18e9d6 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -103,12 +103,6 @@ if ARCH_SHMOBILE_LEGACY
 
 comment "Renesas ARM SoCs System Type"
 
-config ARCH_R8A7778
-	bool "R-Car M1A (R8A77781)"
-	select ARCH_RCAR_GEN1
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_GIC
-
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_RCAR_GEN1
-- 
2.1.4


From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 14 Aug 2015 13:51:04 +0000
Subject: [PATCH 3/7] ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
Message-Id: <1439560268-4935-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Obsoleted by removal of r8a7778 legacy platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6e07e98..61a59b1 100644
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
2.4.6


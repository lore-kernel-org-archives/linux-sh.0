From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 18 Aug 2015 13:12:18 +0000
Subject: [PATCH 2/2] ARM: shmobile: Kconfig: remove unused SHMOBILE_TIMER_HZ section
Message-Id: <1439903538-19201-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Obsoleted by removal of legacy platforms.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Kconfig | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 7f2e053..88734a5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -98,23 +98,3 @@ config ARCH_SH73A0
 
 comment "Renesas ARM SoCs System Configuration"
 endif
-
-if ARCH_SHMOBILE
-
-menu "Timer and clock configuration"
-
-config SHMOBILE_TIMER_HZ
-	int "Kernel HZ (jiffies per second)"
-	range 32 1024
-	default "128"
-	help
-	  Allows the configuration of the timer frequency. It is customary
-	  to have the timer interrupt run at 1000 Hz or 100 Hz, but in the
-	  case of low timer frequencies other values may be more suitable.
-	  Renesas ARM SoC systems using a 32768 Hz RCLK for clock events may
-	  want to select a HZ value such as 128 that can evenly divide RCLK.
-	  A HZ value that does not divide evenly may cause timer drift.
-
-endmenu
-
-endif
-- 
2.4.6


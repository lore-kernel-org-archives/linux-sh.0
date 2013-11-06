From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Nov 2013 11:05:27 +0000
Subject: [PATCH v2 02/03] ARM: shmobile: Remove CMT, TMU and STI Kconfig entries
Message-Id: <20131106110527.6806.40247.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106110508.6806.48070.sendpatchset@w520>
In-Reply-To: <20131106110508.6806.48070.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Now when drivers/clocksource/Kconfig has been
updated with entires for CMT, TMU and STI
it is safe to remove these from mach-shmobile.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |   21 ---------------------
 1 file changed, 21 deletions(-)

--- 0004/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-11-05 19:55:01.000000000 +0900
@@ -283,7 +283,6 @@ source "drivers/sh/Kconfig"
 endif
 
 if ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI
-
 menu "Timer and clock configuration"
 
 config SHMOBILE_TIMER_HZ
@@ -297,25 +296,5 @@ config SHMOBILE_TIMER_HZ
 	  SH-Mobile systems using a 32768 Hz RCLK for clock events may want
 	  to select a HZ value such as 128 that can evenly divide RCLK.
 	  A HZ value that does not divide evenly may cause timer drift.
-
-config SH_TIMER_CMT
-	bool "CMT timer driver"
-	default y
-	help
-	  This enables build of the CMT timer driver.
-
-config SH_TIMER_TMU
-	bool "TMU timer driver"
-	default y
-	help
-	  This enables build of the TMU timer driver.
-
-config EM_TIMER_STI
-	bool "STI timer driver"
-	default y
-	help
-	  This enables build of the STI timer driver.
-
 endmenu
-
 endif

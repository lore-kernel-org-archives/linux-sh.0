From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Nov 2013 11:05:37 +0000
Subject: [PATCH v2 03/03] sh: Remove Kconfig entries for TMU, CMT and MTU2
Message-Id: <20131106110537.6806.52245.sendpatchset@w520>
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
updated with entires for CMT, TMU and MTU2
it is safe to remove these from SH.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Kconfig |   21 ---------------------
 1 file changed, 21 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2013-11-05 21:03:10.000000000 +0900
@@ -565,27 +565,6 @@ source "arch/sh/boards/Kconfig"
 
 menu "Timer and clock configuration"
 
-config SH_TIMER_TMU
-	bool "TMU timer driver"
-	depends on SYS_SUPPORTS_TMU
-	default y
-	help
-	  This enables the build of the TMU timer driver.
-
-config SH_TIMER_CMT
-	bool "CMT timer driver"
-	depends on SYS_SUPPORTS_CMT
-	default y
-	help
-	  This enables build of the CMT timer driver.
-
-config SH_TIMER_MTU2
-	bool "MTU2 timer driver"
-	depends on SYS_SUPPORTS_MTU2
-	default y
-	help
-	  This enables build of the MTU2 timer driver.
-
 config SH_PCLK_FREQ
 	int "Peripheral clock frequency (in Hz)"
 	depends on SH_CLK_CPG_LEGACY

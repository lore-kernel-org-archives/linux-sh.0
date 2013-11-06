From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Nov 2013 11:05:18 +0000
Subject: [PATCH v2 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <20131106110518.6806.79333.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106110508.6806.48070.sendpatchset@w520>
In-Reply-To: <20131106110508.6806.48070.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Add Kconfig entries for CMT, MTU2, TMU and STI to
drivers/clocksource/Kconfig. This will allow us to
get rid of duplicated entires in architecture code
such as arch/sh and arch/arm/mach-shmobile.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/Kconfig |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- 0001/drivers/clocksource/Kconfig
+++ work/drivers/clocksource/Kconfig	2013-11-05 19:49:47.000000000 +0900
@@ -110,3 +110,33 @@ config VF_PIT_TIMER
 	bool
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
+
+if COMPILE_TEST || ARM || SUPERH
+menu "Timer drivers"
+
+config SH_TIMER_CMT
+	bool "CMT timer driver"
+	default y if ARM || (SUPERH && SYS_SUPPORTS_CMT)
+	help
+	  This enables build of the CMT timer driver.
+
+config SH_TIMER_MTU2
+	bool "MTU2 timer driver"
+	default y if ARM || (SUPERH && SYS_SUPPORTS_MTU2)
+	help
+	  This enables build of the MTU2 timer driver.
+
+config SH_TIMER_TMU
+	bool "TMU timer driver"
+	default y if ARM || (SUPERH && SYS_SUPPORTS_TMU)
+	help
+	  This enables build of the TMU timer driver.
+
+config EM_TIMER_STI
+	bool "STI timer driver"
+	default y if ARM
+	help
+	  This enables build of the STI timer driver.
+
+endmenu
+endif

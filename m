From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Dec 2013 10:12:22 +0000
Subject: [PATCH v5 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
Message-Id: <20131217101222.17491.98178.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217101212.17491.56898.sendpatchset@w520>
In-Reply-To: <20131217101212.17491.56898.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, john.stultz@linaro.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm@opensource.se>

Add Kconfig entries for CMT, MTU2, TMU and STI to
drivers/clocksource/Kconfig. This will allow us to
get rid of duplicated entires in architecture code
such as arch/sh and arch/arm/mach-shmobile.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/Kconfig |   44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- 0001/drivers/clocksource/Kconfig
+++ work/drivers/clocksource/Kconfig	2013-12-17 18:50:30.000000000 +0900
@@ -135,3 +135,47 @@ config VF_PIT_TIMER
 	bool
 	help
 	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
+
+config SYS_SUPPORTS_SH_CMT
+        bool
+
+config SYS_SUPPORTS_SH_MTU2
+        bool
+
+config SYS_SUPPORTS_SH_TMU
+        bool
+
+config SYS_SUPPORTS_EM_STI
+        bool
+
+config SH_TIMER_CMT
+	bool "Renesas CMT timer driver" if COMPILE_TEST
+	default SYS_SUPPORTS_SH_CMT
+	help
+	  This enables build of a clocksource and clockevent driver for
+	  the Compare Match Timer (CMT) hardware available in 16/32/48-bit
+	  variants on a wide range of Mobile and Automotive SoCs from Renesas.
+
+config SH_TIMER_MTU2
+	bool "Renesas MTU2 timer driver" if COMPILE_TEST
+	default SYS_SUPPORTS_SH_MTU2
+	help
+	  This enables build of a clockevent driver for the Multi-Function
+	  Timer Pulse Unit 2 (TMU2) hardware available on SoCs from Renesas.
+	  This hardware comes with 16 bit-timer registers.
+
+config SH_TIMER_TMU
+	bool "Renesas TMU timer driver" if COMPILE_TEST
+	default SYS_SUPPORTS_SH_TMU
+	help
+	  This enables build of a clocksource and clockevent driver for
+	  the 32-bit Timer Unit (TMU) hardware available on a wide range
+	  SoCs from Renesas.
+
+config EM_TIMER_STI
+	bool "Renesas STI timer driver" if COMPILE_TEST
+	default SYS_SUPPORTS_EM_STI
+	help
+	  This enables build of a clocksource and clockevent driver for
+	  the 48-bit System Timer (STI) hardware available on a SoCs
+	  such as EMEV2 from former NEC Electronics.

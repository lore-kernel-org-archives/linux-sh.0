From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 May 2009 10:48:13 +0000
Subject: [PATCH] sh: sh7785lcr clock fixes
Message-Id: <20090507104813.31966.8510.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the sh7785lcr board defconfigs to fix
PCLK values and add mode4 run time check.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-sh7785lcr.c          |   10 ++++++++++
 arch/sh/configs/sh7785lcr_32bit_defconfig |    2 +-
 arch/sh/configs/sh7785lcr_defconfig       |    2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

--- 0001/arch/sh/boards/board-sh7785lcr.c
+++ work/arch/sh/boards/board-sh7785lcr.c	2009-05-07 18:34:15.000000000 +0900
@@ -289,6 +289,9 @@ static void sh7785lcr_power_off(void)
 		cpu_relax();
 }
 
+#define PNCR 0xffe70018
+#define PNDR 0xffe70038
+
 /* Initialize the board */
 static void __init sh7785lcr_setup(char **cmdline_p)
 {
@@ -301,6 +304,13 @@ static void __init sh7785lcr_setup(char 
 	/* sm501 DRAM configuration */
 	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
 	writel(0x000307c2, sm501_reg);
+
+	/* read PN5 pin to get MODE4/PLL configuration for clock code */
+	ctrl_outw(ctrl_inw(PNCR) | 0x0c00, PNCR);
+	if (ctrl_inb(PNDR) & 0x20)
+		parse_early_options("mode4_pin=high");
+	else
+		parse_early_options("mode4_pin=low");
 }
 
 /*
--- 0001/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ work/arch/sh/configs/sh7785lcr_32bit_defconfig	2009-05-07 18:34:23.000000000 +0900
@@ -258,7 +258,7 @@ CONFIG_SH_SH7785LCR=y
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ(
-CONFIG_SH_PCLK_FREQP000000
+CONFIG_SH_PCLK_FREQ3333333
 CONFIG_TICK_ONESHOT=y
 # CONFIG_NO_HZ is not set
 CONFIG_HIGH_RES_TIMERS=y
--- 0001/arch/sh/configs/sh7785lcr_defconfig
+++ work/arch/sh/configs/sh7785lcr_defconfig	2009-05-07 18:34:23.000000000 +0900
@@ -252,7 +252,7 @@ CONFIG_SH_SH7785LCR_29BIT_PHYSMAPS=y
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ(
-CONFIG_SH_PCLK_FREQP000000
+CONFIG_SH_PCLK_FREQ3333333
 CONFIG_TICK_ONESHOT=y
 # CONFIG_NO_HZ is not set
 CONFIG_HIGH_RES_TIMERS=y

From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 May 2009 10:44:55 +0000
Subject: [PATCH] sh: r7785 highlander clock fixes
Message-Id: <20090507104455.31927.89479.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the r7785 highlander defconfig to fix
PCLK value and that mode4 is set high.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/r7785rp_defconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/configs/r7785rp_defconfig
+++ work/arch/sh/configs/r7785rp_defconfig	2009-05-07 18:23:02.000000000 +0900
@@ -269,7 +269,7 @@ CONFIG_SH_R7785RP=y
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ(
-CONFIG_SH_PCLK_FREQP000000
+CONFIG_SH_PCLK_FREQ3333333
 CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -333,7 +333,7 @@ CONFIG_GUSA=y
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"
+CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1 mode4_pin=high"
 
 #
 # Bus options

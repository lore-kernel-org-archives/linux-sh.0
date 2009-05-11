From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 11:34:16 +0000
Subject: [PATCH] sh: r7780 highlander clock fixes
Message-Id: <20090511113416.12454.62526.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the r7780 highlander defconfig to fix
PCLK value, while at it fix cmdline on r7785.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/r7780mp_defconfig |    2 +-
 arch/sh/configs/r7785rp_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/configs/r7780mp_defconfig
+++ work/arch/sh/configs/r7780mp_defconfig	2009-05-11 20:06:47.000000000 +0900
@@ -260,7 +260,7 @@ CONFIG_SH_R7780MP=y
 #
 CONFIG_SH_TMU=y
 CONFIG_SH_TIMER_IRQ(
-CONFIG_SH_PCLK_FREQ2000000
+CONFIG_SH_PCLK_FREQ3333333
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
--- 0001/arch/sh/configs/r7785rp_defconfig
+++ work/arch/sh/configs/r7785rp_defconfig	2009-05-11 20:07:02.000000000 +0900
@@ -333,7 +333,7 @@ CONFIG_GUSA=y
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1 mode4_pin=high"
+CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda1"
 
 #
 # Bus options

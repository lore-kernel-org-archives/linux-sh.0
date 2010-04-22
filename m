From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 06:06:04 +0000
Subject: [PATCH] sh: Fix maximum number of SCIF ports in R2D defconfigs
Message-Id: <20100422060604.8151.71593.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the R2D defconfigs to bump up the maximum
number of SCIF ports on the system.

Fixes a broken serial console regression added
by cd5f107628ab89c5dec5ad923f1c27f4cba41972.

Reported-by: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Alexandre Courbot <alex@dcl.info.waseda.ac.jp>
---

 arch/sh/configs/rts7751r2d1_defconfig    |    2 +-
 arch/sh/configs/rts7751r2dplus_defconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/configs/rts7751r2d1_defconfig
+++ work/arch/sh/configs/rts7751r2d1_defconfig	2010-04-22 13:07:12.000000000 +0900
@@ -877,7 +877,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_SH_SCI=y
-CONFIG_SERIAL_SH_SCI_NR_UARTS=1
+CONFIG_SERIAL_SH_SCI_NR_UARTS=2
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
--- 0001/arch/sh/configs/rts7751r2dplus_defconfig
+++ work/arch/sh/configs/rts7751r2dplus_defconfig	2010-04-22 13:07:21.000000000 +0900
@@ -963,7 +963,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 #
 # CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_SH_SCI=y
-CONFIG_SERIAL_SH_SCI_NR_UARTS=1
+CONFIG_SERIAL_SH_SCI_NR_UARTS=2
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y

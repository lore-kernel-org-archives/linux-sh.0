From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 28 Sep 2011 07:49:14 +0000
Subject: [PATCH] sh: modify the asm/sh_eth.h to linux/sh_eth.h in some boards
Message-Id: <4E82D17A.7050108@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 - This patch depends on the following patch:
  - net: sh_eth: move the asm/sh_eth.h to include/linux/
 - This patch doesn't contain board-sh7757lcr.c, because
   it needs more modification.

 arch/sh/boards/board-espt.c           |    2 +-
 arch/sh/boards/mach-ecovec24/setup.c  |    2 +-
 arch/sh/boards/mach-se/7724/setup.c   |    2 +-
 arch/sh/boards/mach-sh7763rdp/setup.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
index 9da92ac..b3ae9d3 100644
--- a/arch/sh/boards/board-espt.c
+++ b/arch/sh/boards/board-espt.c
@@ -13,9 +13,9 @@
 #include <linux/interrupt.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
+#include <linux/sh_eth.h>
 #include <asm/machvec.h>
 #include <asm/sizes.h>
-#include <asm/sh_eth.h>

 /* NOR Flash */
 static struct mtd_partition espt_nor_flash_partitions[] = {
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index b24d69d..7f74985 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -28,13 +28,13 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/sh_eth.h>
 #include <video/sh_mobile_lcdc.h>
 #include <sound/sh_fsi.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/tw9910.h>
 #include <media/mt9t112.h>
 #include <asm/heartbeat.h>
-#include <asm/sh_eth.h>
 #include <asm/clock.h>
 #include <asm/suspend.h>
 #include <cpu/sh7724.h>
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index d007567..b747c0a 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -23,12 +23,12 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
+#include <linux/sh_eth.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <sound/sh_fsi.h>
 #include <asm/io.h>
 #include <asm/heartbeat.h>
-#include <asm/sh_eth.h>
 #include <asm/clock.h>
 #include <asm/suspend.h>
 #include <cpu/sh7724.h>
diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh7763rdp/setup.c
index f3d828f..dd036f1 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -17,8 +17,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/fb.h>
 #include <linux/io.h>
+#include <linux/sh_eth.h>
 #include <mach/sh7763rdp.h>
-#include <asm/sh_eth.h>
 #include <asm/sh7760fb.h>

 /* NOR Flash */
-- 
1.7.1

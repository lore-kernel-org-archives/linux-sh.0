From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 06 Dec 2013 02:09:30 +0000
Subject: [PATCH] ARM: shmobile: r8a7778: camera-rcar header cleanup
Message-Id: <87ob4uybl4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

<linux/platform_data/camera-rcar.h> is needed on BockW,
not setup-r8a7778.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index eb5b54f..afb3f68 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index b497f93..f64969e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,7 +20,6 @@
 #define __ASM_R8A7778_H__
 
 #include <linux/sh_eth.h>
-#include <linux/platform_data/camera-rcar.h>
 
 /* HPB-DMA slave IDs */
 enum {
-- 
1.7.9.5


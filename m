From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 01:00:03 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7779: camera-rcar header cleanup
Message-Id: <8761sdym0f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

<linux/platform_data/camera-rcar.h> is needed on Marzen,
not setup-r8a7779.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-marzen.c         |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fa102f7..4f9e3ec 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -29,6 +29,7 @@
 #include <linux/leds.h>
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-phy.h>
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 905420a..1cab247 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -4,7 +4,6 @@
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
 #include <linux/sh_eth.h>
-#include <linux/platform_data/camera-rcar.h>
 
 /* HPB-DMA slave IDs */
 enum {
-- 
1.7.9.5


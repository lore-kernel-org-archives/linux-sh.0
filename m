From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:59:40 +0000
Subject: [PATCH] ARM: shmobile: armadillo800eva: Sort includes
Message-Id: <f4115f25c11790646351df243dae070a7cf80163.1414557660.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1414557660.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1414557660.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Sorted includes seems to be the done thing these days.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 40 +++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e709835..f19459a 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -22,43 +22,43 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/input.h>
-#include <linux/platform_data/st1232_pdata.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/regulator/driver.h>
+#include <linux/i2c-gpio.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/st1232_pdata.h>
+#include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
+#include <linux/reboot.h>
+#include <linux/regulator/driver.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
-#include <linux/videodev2.h>
 #include <linux/usb/renesas_usbhs.h>
-#include <linux/mfd/tmio.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/i2c-gpio.h>
-#include <linux/reboot.h>
+#include <linux/videodev2.h>
 
-#include <media/mt9t112.h>
-#include <media/sh_mobile_ceu.h>
-#include <media/soc_camera.h>
-#include <asm/page.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/cache-l2x0.h>
-#include <video/sh_mobile_lcdc.h>
-#include <video/sh_mobile_hdmi.h>
+#include <asm/page.h>
+#include <media/mt9t112.h>
+#include <media/sh_mobile_ceu.h>
+#include <media/soc_camera.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
+#include <video/sh_mobile_hdmi.h>
+#include <video/sh_mobile_lcdc.h>
 
 #include "common.h"
 #include "irqs.h"
-- 
2.1.1


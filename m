From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:34 +0000
Subject: [PATCH 05/11] ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
Message-Id: <1340179300-16452-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On armadillo800eva provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 9e37026..d11abcd 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
 #include <linux/videodev2.h>
 #include <linux/usb/renesas_usbhs.h>
@@ -44,6 +45,7 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/r8a7740.h>
+#include <mach/regulator.h>
 #include <video/sh_mobile_lcdc.h>
 
 /*
@@ -407,6 +409,19 @@ static struct platform_device gpio_keys_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0, SDHI1, MMCIF */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
 /* SDHI0 */
 /*
  * FIXME
@@ -544,6 +559,7 @@ static struct i2c_board_info i2c0_devices[] = {
  * board devices
  */
 static struct platform_device *eva_devices[] __initdata = {
+	&fixed_power_0,
 	&lcdc0_device,
 	&gpio_keys_device,
 	&sh_eth_device,
-- 
1.7.2.5


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:32:26 +0000
Subject: [PATCH 04/10 v3] ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
Message-Id: <1340749952-8534-5-git-send-email-g.liakhovetski@gmx.de>
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
index 9e37026..819cee5 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -28,6 +28,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
 #include <linux/videodev2.h>
 #include <linux/usb/renesas_usbhs.h>
@@ -407,6 +409,17 @@ static struct platform_device gpio_keys_device = {
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
 /* SDHI0 */
 /*
  * FIXME
@@ -584,6 +597,9 @@ clock_error:
  */
 static void __init eva_init(void)
 {
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+
 	eva_clock_init();
 
 	r8a7740_pinmux_init();
-- 
1.7.2.5


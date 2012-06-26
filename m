From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:32:31 +0000
Subject: [PATCH 09/10 v3] ARM: mach-shmobile: add fixed voltage regulators to kzm9g
Message-Id: <1340749952-8534-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kzm9g provide 1.8V and 2.8V supplies for its SD/MMC-card interfaces
and a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index d8e33b6..4f75a18 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -30,6 +30,8 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/videodev2.h>
@@ -54,6 +56,12 @@
 #define GPIO_PCF8575_PORT15	(GPIO_NR + 13)
 #define GPIO_PCF8575_PORT16	(GPIO_NR + 14)
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 /* SMSC 9221 */
 static struct resource smsc9221_resources[] = {
 	[0] = {
@@ -166,6 +174,13 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+/* Fixed 1.8V regulator to be used by MMCIF */
+static struct regulator_consumer_supply fixed1v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
 /* MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -200,6 +215,13 @@ static struct platform_device mmc_device = {
 	.resource	= sh_mmcif_resources,
 };
 
+/* Fixed 2.8V regulators to be used by SDHI0 */
+static struct regulator_consumer_supply fixed2v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
@@ -350,6 +372,12 @@ device_initcall(as3711_enable_lcdc_backlight);
 
 static void __init kzm_init(void)
 {
+	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
+				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
+	regulator_register_always_on(1, "fixed-2.8V", fixed2v8_power_consumers,
+				     ARRAY_SIZE(fixed2v8_power_consumers), 2800000);
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	sh73a0_pinmux_init();
 
 	/* enable SCIFA4 */
-- 
1.7.2.5


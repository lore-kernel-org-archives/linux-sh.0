From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:39 +0000
Subject: [PATCH 10/11] ARM: mach-shmobile: add fixed voltage regulators to kzm9g
Message-Id: <1340179300-16452-11-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kzm9g provide 1.8V and 2.8V supplies for its SD/MMC-card interfaces
and a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index f847a92..9a3741b 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -30,11 +30,14 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/videodev2.h>
 #include <mach/irqs.h>
+#include <mach/regulator.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -55,6 +58,12 @@
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
@@ -312,6 +321,15 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+/* Fixed 1.8V regulator to be used by MMCIF */
+static struct regulator_consumer_supply fixed1v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
+REGULATOR_FIXED(fixed1v8_power_consumers, 0, 1800000);
+
 /* MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -348,6 +366,17 @@ static struct platform_device mmc_device = {
 	.resource	= sh_mmcif_resources,
 };
 
+/* Fixed 2.8V regulators to be used by SDHI0, SDHI2 */
+static struct regulator_consumer_supply fixed2v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
+};
+
+REGULATOR_FIXED(fixed2v8_power_consumers, 1, 2800000);
+
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
@@ -479,6 +508,8 @@ static struct i2c_board_info i2c3_devices[] = {
 };
 
 static struct platform_device *kzm_devices[] __initdata = {
+	&fixed_power_0,
+	&fixed_power_1,
 	&smsc_device,
 	&usb_host_device,
 	&usbhs_device,
@@ -544,6 +575,8 @@ device_initcall(as3711_enable_lcdc_backlight);
 
 static void __init kzm_init(void)
 {
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	sh73a0_pinmux_init();
 
 	/* enable SCIFA4 */
-- 
1.7.2.5


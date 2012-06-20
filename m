From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:37 +0000
Subject: [PATCH 08/11] ARM: mach-shmobile: add fixed voltage regulators to kota2
Message-Id: <1340179300-16452-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kota2 provide 1.8V and 3.3V supplies for its SD/MMC-card interfaces
and a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kota2.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 200dcd4..fff8c16 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -27,6 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
@@ -40,6 +42,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/regulator.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -49,6 +52,12 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 /* SMSC 9220 */
 static struct resource smsc9220_resources[] = {
 	[0] = {
@@ -288,6 +297,15 @@ static struct platform_device leds_tpu30_device = {
 	.resource	= tpu30_resources,
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
 static struct resource mmcif_resources[] = {
 	[0] = {
@@ -321,6 +339,17 @@ static struct platform_device mmcif_device = {
 	.resource       = mmcif_resources,
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0 and SDHI1 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 1, 3300000);
+
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps      = MMC_CAP_SD_HIGHSPEED,
@@ -396,6 +425,8 @@ static struct platform_device sdhi1_device = {
 };
 
 static struct platform_device *kota2_devices[] __initdata = {
+	&fixed_power_0,
+	&fixed_power_1,
 	&eth_device,
 	&keysc_device,
 	&gpio_keys_device,
@@ -411,6 +442,8 @@ static struct platform_device *kota2_devices[] __initdata = {
 
 static void __init kota2_init(void)
 {
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	sh73a0_pinmux_init();
 
 	/* SCIFA2 (UART2) */
-- 
1.7.2.5


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:32:29 +0000
Subject: [PATCH 07/10 v3] ARM: mach-shmobile: add fixed voltage regulators to kota2
Message-Id: <1340749952-8534-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kota2 provide 1.8V and 3.3V supplies for its SD/MMC-card interfaces
and a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kota2.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index f60f1b2..21dbe54 100644
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
@@ -49,6 +51,12 @@
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
@@ -288,6 +296,13 @@ static struct platform_device leds_tpu30_device = {
 	.resource	= tpu30_resources,
 };
 
+/* Fixed 1.8V regulator to be used by MMCIF */
+static struct regulator_consumer_supply fixed1v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
 /* MMCIF */
 static struct resource mmcif_resources[] = {
 	[0] = {
@@ -321,6 +336,15 @@ static struct platform_device mmcif_device = {
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
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps      = MMC_CAP_SD_HIGHSPEED,
@@ -411,6 +435,12 @@ static struct platform_device *kota2_devices[] __initdata = {
 
 static void __init kota2_init(void)
 {
+	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
+				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	sh73a0_pinmux_init();
 
 	/* SCIFA2 (UART2) */
-- 
1.7.2.5


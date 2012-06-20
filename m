From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 14:33:53 +0000
Subject: [PATCH 03/11 v2] ARM: mach-shmobile: add fixed voltage regulators to ag5evm
Message-Id: <Pine.LNX.4.64.1206201630170.20254@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On ag5evm provide 1.8V, 2.8V, and 3.3V supplies for its SD/MMC-card
interfaces and a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: use IS_ENABLED() instead of config_enabled() and don't leave the 
CONFIG_ prefix out

 arch/arm/mach-shmobile/board-ag5evm.c |   66 +++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 0891ec6..29f1822 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -27,6 +28,8 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/serial_sci.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
@@ -44,6 +47,7 @@
 #include <sound/sh_fsi.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/regulator.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -52,6 +56,12 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 static struct resource smsc9220_resources[] = {
 	[0] = {
 		.start		= 0x14000000,
@@ -142,6 +152,15 @@ static struct platform_device fsi_device = {
 	.resource	= fsi_resources,
 };
 
+/* Fixed 1.8V regulator to be used by MMCIF */
+static struct regulator_consumer_supply fixed1v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
+REGULATOR_FIXED(fixed1v8_power_consumers, 0, 1800000);
+
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "MMCIF",
@@ -364,6 +383,15 @@ static struct platform_device mipidsi0_device = {
 	},
 };
 
+/* Fixed 2.8V regulators to be used by SDHI0 */
+static struct regulator_consumer_supply fixed2v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
+REGULATOR_FIXED(fixed2v8_power_consumers, 1, 2800000);
+
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
@@ -408,6 +436,37 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI1 */
+static struct regulator_consumer_supply cn4_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+};
+
+static struct regulator_init_data cn4_power_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(cn4_power_consumers),
+	.consumer_supplies      = cn4_power_consumers,
+};
+
+static struct fixed_voltage_config cn4_power_info = {
+	.supply_name = "CN4 SD/MMC Vdd",
+	.microvolts = 3300000,
+	.gpio = GPIO_PORT114,
+	.enable_high = 1,
+	.init_data = &cn4_power_init_data,
+};
+
+static struct platform_device cn4_power = {
+	.name = "reg-fixed-voltage",
+	.id   = 2,
+	.dev  = {
+		.platform_data = &cn4_power_info,
+	},
+};
+
 void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
 {
 	gpio_set_value(GPIO_PORT114, state);
@@ -455,6 +514,9 @@ static struct platform_device sdhi1_device = {
 };
 
 static struct platform_device *ag5evm_devices[] __initdata = {
+	&fixed_power_0,
+	&fixed_power_1,
+	&cn4_power,
 	&eth_device,
 	&keysc_device,
 	&fsi_device,
@@ -468,6 +530,8 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 
 static void __init ag5evm_init(void)
 {
+	regulator_register_fixed(3, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	sh73a0_pinmux_init();
 
 	/* enable SCIFA2 */
@@ -562,9 +626,10 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_SDHID1_2_PU, NULL);
 	gpio_request(GPIO_FN_SDHID1_1_PU, NULL);
 	gpio_request(GPIO_FN_SDHID1_0_PU, NULL);
+#if !IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
 	gpio_request(GPIO_PORT114, "sdhi1_power");
 	gpio_direction_output(GPIO_PORT114, 0);
+#endif
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
-- 
1.7.2.5


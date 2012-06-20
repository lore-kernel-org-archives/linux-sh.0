From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:10 +0000
Subject: [PATCH 02/14] sh: ecovec: switch MMC power control to regulators
Message-Id: <1340205142-32606-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Power on the CN11 and CN12 SD/MMC slots on ecovec is controlled by GPIOs,
which makes it possible to use the fixed voltage regulator driver to switch
card power on and off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ecovec24/setup.c |   73 ++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index dbedfda..80f40d8 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -10,6 +10,7 @@
 
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/kconfig.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
@@ -19,6 +20,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/i2c.h>
@@ -518,8 +521,70 @@ static struct i2c_board_info ts_i2c_clients = {
 	.irq		= IRQ0,
 };
 
+static struct regulator_consumer_supply cn12_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+};
+
+static struct regulator_init_data cn12_power_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(cn12_power_consumers),
+	.consumer_supplies      = cn12_power_consumers,
+};
+
+static struct fixed_voltage_config cn12_power_info = {
+	.supply_name = "CN12 SD/MMC Vdd",
+	.microvolts = 3300000,
+	.gpio = GPIO_PTB7,
+	.enable_high = 1,
+	.init_data = &cn12_power_init_data,
+};
+
+static struct platform_device cn12_power = {
+	.name = "reg-fixed-voltage",
+	.id   = 0,
+	.dev  = {
+		.platform_data = &cn12_power_info,
+	},
+};
+
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
 /* SDHI0 */
+static struct regulator_consumer_supply sdhi0_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
+static struct regulator_init_data sdhi0_power_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = ARRAY_SIZE(sdhi0_power_consumers),
+	.consumer_supplies      = sdhi0_power_consumers,
+};
+
+static struct fixed_voltage_config sdhi0_power_info = {
+	.supply_name = "CN11 SD/MMC Vdd",
+	.microvolts = 3300000,
+	.gpio = GPIO_PTB6,
+	.enable_high = 1,
+	.init_data = &sdhi0_power_init_data,
+};
+
+static struct platform_device sdhi0_power = {
+	.name = "reg-fixed-voltage",
+	.id   = 1,
+	.dev  = {
+		.platform_data = &sdhi0_power_info,
+	},
+};
+
 static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 {
 	gpio_set_value(GPIO_PTB6, state);
@@ -954,7 +1019,9 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
+	&cn12_power,
 #if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
+	&sdhi0_power,
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
@@ -1252,8 +1319,10 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI0D2,  NULL);
 	gpio_request(GPIO_FN_SDHI0D1,  NULL);
 	gpio_request(GPIO_FN_SDHI0D0,  NULL);
+#if !IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
 	gpio_request(GPIO_PTB6, NULL);
 	gpio_direction_output(GPIO_PTB6, 0);
+#endif
 #else
 	/* enable MSIOF0 on CN11 (needs DS2.4 set to OFF) */
 	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
@@ -1282,8 +1351,10 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_MMC_D0, NULL);
 	gpio_request(GPIO_FN_MMC_CLK, NULL);
 	gpio_request(GPIO_FN_MMC_CMD, NULL);
+#if !IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
 	gpio_request(GPIO_PTB7, NULL);
 	gpio_direction_output(GPIO_PTB7, 0);
+#endif
 
 	cn12_enabled = true;
 #elif defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
@@ -1295,8 +1366,10 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI1D2,  NULL);
 	gpio_request(GPIO_FN_SDHI1D1,  NULL);
 	gpio_request(GPIO_FN_SDHI1D0,  NULL);
+#if !IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
 	gpio_request(GPIO_PTB7, NULL);
 	gpio_direction_output(GPIO_PTB7, 0);
+#endif
 
 	/* Card-detect, used on CN12 with SDHI1 */
 	gpio_request(GPIO_PTW7, NULL);
-- 
1.7.2.5


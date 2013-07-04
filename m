From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Jul 2013 20:38:51 +0000
Subject: [PATCH 3/6] ARM: shmobile: APE6EVM: add SDHI interfaces
Message-Id: <1372970334-21485-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for SDHI0 and SDHI1 on APE6EVM in PIO mode only.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |   47 +++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 05f8557..a0311d9 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -21,8 +21,10 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
@@ -56,10 +58,12 @@ static const struct smsc911x_platform_config lan9220_data = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
 };
 
-/* Fixed 3.3V regulator to be used by MMCIF */
+/* Fixed 3.3V regulator to be used by MMCIF and SDHI */
 static struct regulator_consumer_supply fixed3v3_power_consumers[]  {
 	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
 };
 
 /* MMCIF */
@@ -74,6 +78,29 @@ static struct resource mmcif0_resources[] = {
 	DEFINE_RES_IRQ(gic_spi(169)),
 };
 
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi0_pdata = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+};
+
+static struct resource sdhi0_resources[] = {
+	DEFINE_RES_MEM_NAMED(0xee100000, 0x100, "SDHI0"),
+	DEFINE_RES_IRQ(gic_spi(165)),
+};
+
+/* SDHI1 */
+static struct sh_mobile_sdhi_info sdhi1_pdata = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_NEEDS_POLL,
+};
+
+static struct resource sdhi1_resources[] = {
+	DEFINE_RES_MEM_NAMED(0xee120000, 0x100, "SDHI1"),
+	DEFINE_RES_IRQ(gic_spi(166)),
+};
+
 static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SCIFA0 console */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
@@ -86,6 +113,18 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 				  "mmc0_data8", "mmc0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
 				  "mmc0_ctrl", "mmc0"),
+	/* SDHI0: uSD: no WP */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
+				  "sdhi0_cd", "sdhi0"),
+	/* SDHI1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
+				  "sdhi1_ctrl", "sdhi1"),
 };
 
 static void __init ape6evm_add_standard_devices(void)
@@ -123,6 +162,12 @@ static void __init ape6evm_add_standard_devices(void)
 	platform_device_register_resndata(&platform_bus, "sh_mmcif", 0,
 					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
 					  &mmcif0_pdata, sizeof(mmcif0_pdata));
+	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
+					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
+					  &sdhi0_pdata, sizeof(sdhi0_pdata));
+	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 1,
+					  sdhi1_resources, ARRAY_SIZE(sdhi1_resources),
+					  &sdhi1_pdata, sizeof(sdhi1_pdata));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.7.2.5


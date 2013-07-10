From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 10 Jul 2013 08:13:08 +0000
Subject: [PATCH v4 2/7] ARM: shmobile: ape6evm: add MMCIF support
Message-Id: <Pine.LNX.4.64.1307101003340.6609@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add MMCIF support to the APE6EVM board in PIO mode only. Power supply is
fixed for now, eventually support for the tps80032 regulator, also
supplying both VDD and VccQ to the MMCIF slot should be added to APE6EVM.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
---

v4: dropped DMA support

Hi Simon, this patch is again for the APE6EVM state before the "ARM: 
shmobile: ape6evm: add SDHI interfaces" patch. As discussed with you, you 
prefer to regenerate your tree with this patch applied first, and the 
"SDHI" one on top, to fix the regulator issue, that emerged due to the 
reversed commit order. After this patch applied, the original SDHI patch 
version should be used.
Thanks
Guennadi

 arch/arm/mach-shmobile/board-ape6evm.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index af6dd39..8c7529c 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -21,6 +21,8 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
@@ -54,6 +56,25 @@ static const struct smsc911x_platform_config lan9220_data = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
 };
 
+/*
+ * On APE6EVM power is supplied to MMCIF by a tps80032 regulator. For now we
+ * model a VDD supply to MMCIF, using a fixed 3.3V regulator.
+ */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+};
+
+/* MMCIF */
+static struct sh_mmcif_plat_data mmcif0_pdata = {
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+};
+
+static struct resource mmcif0_resources[] = {
+	DEFINE_RES_MEM_NAMED(0xee200000, 0x100, "MMCIF0"),
+	DEFINE_RES_IRQ(gic_spi(169)),
+};
+
 static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SCIFA0 console */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
@@ -61,6 +82,11 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
 				  "irqc_irq40", "irqc"),
+	/* MMCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
+				  "mmc0_data8", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
+				  "mmc0_ctrl", "mmc0"),
 };
 
 static void __init ape6evm_add_standard_devices(void)
@@ -93,6 +119,11 @@ static void __init ape6evm_add_standard_devices(void)
 	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
 					  lan9220_res, ARRAY_SIZE(lan9220_res),
 					  &lan9220_data, sizeof(lan9220_data));
+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+	platform_device_register_resndata(&platform_bus, "sh_mmcif", 0,
+					  mmcif0_resources, ARRAY_SIZE(mmcif0_resources),
+					  &mmcif0_pdata, sizeof(mmcif0_pdata));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.7.2.5


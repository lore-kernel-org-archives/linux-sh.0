From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 15:25:28 +0000
Subject: [PATCH v2 2/6] ARM: shmobile: APE6EVM: add MMCIF support
Message-Id: <1373037932-19918-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add MMCIF support to the APE6EVM board in both PIO and DMA modes, depending
on the DMAC driver availability. Power supply is fixed for now, eventually
support for the tps80032 regulator, also supplying both VDD and VccQ to the
MMCIF slot should be added to APE6EVM.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
---

v2: Added a comment about a regulator, supplying power to eMMC on APE6EVM.

 arch/arm/mach-shmobile/board-ape6evm.c |   33 ++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index af6dd39..ab33030 100644
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
@@ -54,6 +56,27 @@ static const struct smsc911x_platform_config lan9220_data = {
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
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
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
@@ -61,6 +84,11 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
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
@@ -93,6 +121,11 @@ static void __init ape6evm_add_standard_devices(void)
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


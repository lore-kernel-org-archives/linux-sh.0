From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 May 2013 07:15:56 +0000
Subject: [PATCH 08/12] ARM: shmobile: bockw: add SPI FLASH support
Message-Id: <877gizwg2g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

HSPI0 Spansion S25FL008K chip

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 632717e..769069e 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -20,11 +20,14 @@
 
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7778.h>
@@ -70,7 +73,37 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 };
 
+/* HSPI*/
+static struct mtd_partition m25p80_spi_flash_partitions[] = {
+	{
+		.name	= "data(spi)",
+		.size	= 0x0100000,
+		.offset	= 0,
+	},
+};
+
+static struct flash_platform_data spi_flash_data = {
+	.name		= "m25p80",
+	.type		= "s25fl008k",
+	.parts		= m25p80_spi_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(m25p80_spi_flash_partitions),
+};
+
+static struct spi_board_info spi_board_info[] __initdata = {
+	{
+		.modalias	= "m25p80",
+		.max_speed_hz	= 104000000,
+		.chip_select	= 0,
+		.bus_num	= 0,
+		.mode		= SPI_MODE_0,
+		.platform_data	= &spi_flash_data,
+	},
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* HSPI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7778",
+				  "hspi0_a", "hspi0"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
@@ -99,10 +132,14 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_i2c_device(0);
+	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
 
+	spi_register_board_info(spi_board_info,
+				ARRAY_SIZE(spi_board_info));
+
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
-- 
1.7.9.5


From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 15 Oct 2013 09:08:24 +0000
Subject: [PATCH 2/2] ARM: shmobile: Lager: add SPI FLASH support
Message-Id: <1381828104-31302-3-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

This patch enables Spansion S25FL512SAGMFIG11 chip on QSPI

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
---
 arch/arm/mach-shmobile/board-lager.c |   55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index ffb6f0a..f48c514 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -37,6 +37,11 @@
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/rspi.h>
+#include <linux/spi/spi.h>
 
 /* LEDS */
 static struct gpio_led lager_leds[] = {
@@ -105,6 +110,53 @@ static struct resource ether_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
 
+/* SPI Flash memory (Spansion S25FL512SAGMFIG11 64Mb) */
+static struct mtd_partition spi_flash_part[] = {
+	/* Reserved for user loader program, read-only */
+	{
+		.name = "loader",
+		.offset = 0,
+		.size = SZ_256K,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	/* Reserved for user program, read-only */
+	{
+		.name = "user",
+		.offset = MTDPART_OFS_APPEND,
+		.size = SZ_4M,
+		.mask_flags = MTD_WRITEABLE,
+	},
+	/* All else is writable (e.g. JFFS2) */
+	{
+		.name = "flash",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
+		.mask_flags = 0,
+	},
+};
+
+static struct flash_platform_data spi_flash_data = {
+	.name           = "m25p80",
+	.parts          = spi_flash_part,
+	.nr_parts       = ARRAY_SIZE(spi_flash_part),
+	.type           = "s25fl512s",
+};
+
+static struct rspi_plat_data qspi_pdata = {
+	.num_chipselect	= 1,
+};
+
+static struct spi_board_info spi_info[] __initdata = {
+	{
+		.modalias               = "m25p80",
+		.platform_data          = &spi_flash_data,
+		.mode                   = SPI_MODE_0,
+		.max_speed_hz           = 30000000,
+		.bus_num                = 0,
+		.chip_select            = 0,
+	},
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -153,6 +205,9 @@ static void __init lager_add_standard_devices(void)
 					  ether_resources,
 					  ARRAY_SIZE(ether_resources),
 					  &ether_pdata, sizeof(ether_pdata));
+
+	r8a7790_add_qspi_device(&qspi_pdata);
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.7.9.5


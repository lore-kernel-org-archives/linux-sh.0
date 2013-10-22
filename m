From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 22 Oct 2013 02:21:12 +0000
Subject: [PATCH 2/2 v4] ARM: shmobile: Lager:add SPI FLASH support on QSPI
Message-Id: <1382408472-20315-3-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

This patch enables Spansion S25FL512SAGMFIG11 chip on QSPI,
Add support for the QSPI interface on Lager.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
---
 arch/arm/mach-shmobile/board-lager.c |   64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 78a31b6..9a601eb 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -39,6 +39,11 @@
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/mtd.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/rspi.h>
+#include <linux/spi/spi.h>
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
@@ -165,6 +170,59 @@ static const struct resource ether_resources[] __initconst = {
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
+static const struct rspi_plat_data qspi_pdata __initconst = {
+	.num_chipselect	= 1,
+};
+
+static const struct spi_board_info spi_info[] __initconst = {
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
+/* QSPI resource */
+static const struct resource qspi_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6b10000, 0x1000),
+	DEFINE_RES_IRQ(gic_spi(184)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -222,6 +280,12 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 
 	lager_add_du_device();
+
+	platform_device_register_resndata(&platform_bus, "qspi", 0,
+					  qspi_resources,
+					  ARRAY_SIZE(qspi_resources),
+					  &qspi_pdata, sizeof(qspi_pdata));
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
 /*
-- 
1.7.9.5


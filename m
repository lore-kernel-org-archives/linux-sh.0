From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Jun 2013 02:12:06 +0000
Subject: [PATCH 3/3 v4] ARM: shmobile: bockw: add MMCIF support
Message-Id: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables CN26 MMCIF

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - based on renesas-next-20130611v2

 arch/arm/mach-shmobile/board-bockw.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index f0f9eaa..75ba061 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -41,6 +41,23 @@
  * SW41		SCIF	RCAN
  */
 
+/*
+ * MMC (CN26) pin
+ *
+ * SW6	(D2)	3 pin
+ * SW7	(D5)	ON
+ * SW8	(D3)	3 pin
+ * SW10	(D4)	1 pin
+ * SW12	(CLK)	1 pin
+ * SW13	(D6)	3 pin
+ * SW14	(CMD)	ON
+ * SW15	(D6)	1 pin
+ * SW16	(D0)	ON
+ * SW17	(D1)	ON
+ * SW18	(D7)	3 pin
+ * SW19	(MMC)	1 pin
+ */
+
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vddvario", "smsc911x"),
@@ -103,10 +120,24 @@ static struct spi_board_info spi_board_info[] __initdata = {
 	},
 };
 
+/* MMC */
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
+	.sup_pclk	= 0,
+	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
+	.caps		= MMC_CAP_4_BIT_DATA |
+			  MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NEEDS_POLL,
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7778",
 				  "hspi0_a", "hspi0"),
+	/* MMC */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif", "pfc-r8a7778",
+				  "mmc_data8", "mmc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif", "pfc-r8a7778",
+				  "mmc_ctrl", "mmc"),
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
 				  "scif0_data_a", "scif0"),
@@ -135,6 +166,7 @@ static void __init bockw_init(void)
 	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
+	r8a7778_add_mmc_device(&sh_mmcif_plat);
 
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
-- 
1.7.9.5


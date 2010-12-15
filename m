From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Wed, 15 Dec 2010 08:31:04 +0000
Subject: [PATCH v2] ARM: mach-shmobile: mackerel: Add mmcif support
Message-Id: <4D087CC8.6020803@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

v2
 Add comment of J22 and OCR field.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   67 ++++++++++++++++++++++++++++++-
 1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f62f9b9..fd46f06 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -34,6 +34,7 @@
 #include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -153,10 +154,14 @@
  * I/O voltage : 1.8v
  *
  * Power voltage : 1.8v or 3.3v
- *  J22 : select power voltage
+ *  J22 : select power voltage *1
  *	1-2 pin : 1.8v
  *	2-3 pin : 3.3v
  *
+ * *1
+ * Please change J22 depends the card to be used.
+ * MMC's OCR field set to support either voltage for the card inserted.
+ *
  *	SW1	|	SW33
  *		| bit1 | bit2 | bit3 | bit4
  * -------------+------+------+------+-------
@@ -481,6 +486,7 @@ static struct platform_device sdhi0_device = {
 	},
 };

+#if !defined(CONFIG_MMC_SH_MMCIF)
 /* SDHI1 */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
@@ -514,6 +520,7 @@ static struct platform_device sdhi1_device = {
 		.platform_data	= &sdhi1_info,
 	},
 };
+#endif

 /* SDHI2 */
 static struct sh_mobile_sdhi_info sdhi2_info = {
@@ -547,6 +554,47 @@ static struct platform_device sdhi2_device = {
 	},
 };

+/* SH_MMCIF */
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.name	= "MMCIF",
+		.start	= 0xE6BD0000,
+		.end	= 0xE6BD00FF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* MMC ERR */
+		.start	= evt2irq(0x1ac0),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* MMC NOR */
+		.start	= evt2irq(0x1ae0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
+	.sup_pclk	= 0,
+	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
+	.caps		= MMC_CAP_4_BIT_DATA |
+			  MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NEEDS_POLL,
+	.get_cd		= slot_cn7_get_cd,
+};
+
+static struct platform_device sh_mmcif_device = {
+	.name		= "sh_mmcif",
+	.id		= 0,
+	.dev		= {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &sh_mmcif_plat,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -556,8 +604,11 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_device,
 	&fsi_ak4643_device,
 	&sdhi0_device,
+#if !defined(CONFIG_MMC_SH_MMCIF)
 	&sdhi1_device,
+#endif
 	&sdhi2_device,
+	&sh_mmcif_device,
 };

 /* Keypad Initialization */
@@ -723,6 +774,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);

+#if !defined(CONFIG_MMC_SH_MMCIF)
 	/* enable SDHI1 */
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
@@ -730,6 +782,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID1_2, NULL);
 	gpio_request(GPIO_FN_SDHID1_1, NULL);
 	gpio_request(GPIO_FN_SDHID1_0, NULL);
+#endif
 	/* card detect pin for MMC slot (CN7) */
 	gpio_request(GPIO_PORT41, NULL);
 	gpio_direction_input(GPIO_PORT41);
@@ -742,6 +795,18 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID2_1, NULL);
 	gpio_request(GPIO_FN_SDHID2_0, NULL);

+	/* MMCIF */
+	gpio_request(GPIO_FN_MMCD0_0, NULL);
+	gpio_request(GPIO_FN_MMCD0_1, NULL);
+	gpio_request(GPIO_FN_MMCD0_2, NULL);
+	gpio_request(GPIO_FN_MMCD0_3, NULL);
+	gpio_request(GPIO_FN_MMCD0_4, NULL);
+	gpio_request(GPIO_FN_MMCD0_5, NULL);
+	gpio_request(GPIO_FN_MMCD0_6, NULL);
+	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_FN_MMCCMD0, NULL);
+	gpio_request(GPIO_FN_MMCCLK0, NULL);
+
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
 	i2c_register_board_info(1, i2c1_devices,
-- 
1.5.6.5



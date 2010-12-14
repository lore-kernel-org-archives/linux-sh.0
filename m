From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Tue, 14 Dec 2010 05:18:03 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add sdhi support
Message-Id: <4D06FE0B.3080809@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |  175 +++++++++++++++++++++++++++++++
 1 files changed, 175 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3e30a52..f62f9b9 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -31,6 +31,9 @@
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -139,6 +142,38 @@
  */

 /*
+ * SDHI0 (CN12)
+ *
+ * SW56 : OFF
+ *
+ */
+
+/* MMC /SDHI1 (CN7)
+ *
+ * I/O voltage : 1.8v
+ *
+ * Power voltage : 1.8v or 3.3v
+ *  J22 : select power voltage
+ *	1-2 pin : 1.8v
+ *	2-3 pin : 3.3v
+ *
+ *	SW1	|	SW33
+ *		| bit1 | bit2 | bit3 | bit4
+ * -------------+------+------+------+-------
+ * MMC0	  OFF	|  OFF |  ON  |  ON  |  X
+ * MMC1	  ON	|  OFF |  ON  |  X   | ON
+ * SDHI1  OFF	|  ON  |   X  |  OFF | ON
+ *
+ */
+
+/*
+ * SDHI2 (CN23)
+ *
+ * microSD card sloct
+ *
+ */
+
+/*
  * FIXME !!
  *
  * gpio_no_direction
@@ -404,6 +439,114 @@ static struct platform_device fsi_ak4643_device = {
 	.name		= "sh_fsi2_a_ak4643",
 };

+/*
+ * The card detect pin of the top SD/MMC slot (CN7) is active low and is
+ * connected to GPIO A22 of SH7372 (GPIO_PORT41).
+ */
+static int slot_cn7_get_cd(struct platform_device *pdev)
+{
+	if (gpio_is_valid(GPIO_PORT41))
+		return !gpio_get_value(GPIO_PORT41);
+	else
+		return -ENXIO;
+}
+
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+};
+
+static struct resource sdhi0_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start	= 0xe6850000,
+		.end	= 0xe68501ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x0e00) /* SDHI0 */,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name		= "sh_mobile_sdhi",
+	.num_resources	= ARRAY_SIZE(sdhi0_resources),
+	.resource	= sdhi0_resources,
+	.id		= 0,
+	.dev	= {
+		.platform_data	= &sdhi0_info,
+	},
+};
+
+/* SDHI1 */
+static struct sh_mobile_sdhi_info sdhi1_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.tmio_ocr_mask	= MMC_VDD_165_195,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED |
+			  MMC_CAP_NEEDS_POLL,
+	.get_cd		= slot_cn7_get_cd,
+};
+
+static struct resource sdhi1_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start	= 0xe6860000,
+		.end	= 0xe68601ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x0e80),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name		= "sh_mobile_sdhi",
+	.num_resources	= ARRAY_SIZE(sdhi1_resources),
+	.resource	= sdhi1_resources,
+	.id		= 1,
+	.dev	= {
+		.platform_data	= &sdhi1_info,
+	},
+};
+
+/* SDHI2 */
+static struct sh_mobile_sdhi_info sdhi2_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED |
+			  MMC_CAP_NEEDS_POLL,
+};
+
+static struct resource sdhi2_resources[] = {
+	[0] = {
+		.name	= "SDHI2",
+		.start	= 0xe6870000,
+		.end	= 0xe68701ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x1200),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi2_device = {
+	.name	= "sh_mobile_sdhi",
+	.num_resources	= ARRAY_SIZE(sdhi2_resources),
+	.resource	= sdhi2_resources,
+	.id		= 2,
+	.dev	= {
+		.platform_data	= &sdhi2_info,
+	},
+};
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -412,6 +555,9 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&leds_device,
 	&fsi_device,
 	&fsi_ak4643_device,
+	&sdhi0_device,
+	&sdhi1_device,
+	&sdhi2_device,
 };

 /* Keypad Initialization */
@@ -567,6 +713,35 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ21,	NULL);
 	set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);

+	/* enable SDHI0 */
+	gpio_request(GPIO_FN_SDHICD0, NULL);
+	gpio_request(GPIO_FN_SDHIWP0, NULL);
+	gpio_request(GPIO_FN_SDHICMD0, NULL);
+	gpio_request(GPIO_FN_SDHICLK0, NULL);
+	gpio_request(GPIO_FN_SDHID0_3, NULL);
+	gpio_request(GPIO_FN_SDHID0_2, NULL);
+	gpio_request(GPIO_FN_SDHID0_1, NULL);
+	gpio_request(GPIO_FN_SDHID0_0, NULL);
+
+	/* enable SDHI1 */
+	gpio_request(GPIO_FN_SDHICMD1, NULL);
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHID1_3, NULL);
+	gpio_request(GPIO_FN_SDHID1_2, NULL);
+	gpio_request(GPIO_FN_SDHID1_1, NULL);
+	gpio_request(GPIO_FN_SDHID1_0, NULL);
+	/* card detect pin for MMC slot (CN7) */
+	gpio_request(GPIO_PORT41, NULL);
+	gpio_direction_input(GPIO_PORT41);
+
+	/* enable SDHI2 */
+	gpio_request(GPIO_FN_SDHICMD2, NULL);
+	gpio_request(GPIO_FN_SDHICLK2, NULL);
+	gpio_request(GPIO_FN_SDHID2_3, NULL);
+	gpio_request(GPIO_FN_SDHID2_2, NULL);
+	gpio_request(GPIO_FN_SDHID2_1, NULL);
+	gpio_request(GPIO_FN_SDHID2_0, NULL);
+
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
 	i2c_register_board_info(1, i2c1_devices,
-- 
1.5.6.5



From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Dec 2010 06:35:30 +0000
Subject: [PATCH] ARM: mach-shmobile: Add eMMC support through MMCIF on AG5EVM
Message-Id: <20101222063530.2276.98098.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi YOSHII <takashi.yoshii.zj@renesas.com>

Adding platform resources, PFC setting and release
reset pin for eMMC on ag5evm.

[damm@opensource.se: Add MSTP code for MMCIF]
Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |   54 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 +-
 2 files changed, 56 insertions(+), 2 deletions(-)

--- 0004/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2010-12-22 14:41:48.000000000 +0900
@@ -32,6 +32,8 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 
 #include <sound/sh_fsi.h>
 
@@ -146,10 +148,46 @@ static struct platform_device fsi_device
 	},
 };
 
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.name	= "MMCIF",
+		.start	= 0xe6bd0000,
+		.end	= 0xe6bd00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(141),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= gic_spi(140),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_mmcif_plat_data sh_mmcif_platdata = {
+	.sup_pclk	= 0,
+	.ocr		= MMC_VDD_165_195,
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+};
+
+static struct platform_device mmc_device = {
+	.name		= "sh_mmcif",
+	.id		= 0,
+	.dev		= {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &sh_mmcif_platdata,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
 	&fsi_device,
+	&mmc_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
@@ -216,12 +254,26 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_KEYOUT8, NULL);
 	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
 
-	/* enable IC2 2 and 3 */
+	/* enable I2C channel 2 and 3 */
 	gpio_request(GPIO_FN_PORT236_I2C_SDA2, NULL);
 	gpio_request(GPIO_FN_PORT237_I2C_SCL2, NULL);
 	gpio_request(GPIO_FN_PORT248_I2C_SCL3, NULL);
 	gpio_request(GPIO_FN_PORT249_I2C_SDA3, NULL);
 
+	/* enable MMCIF */
+	gpio_request(GPIO_FN_MMCCLK0, NULL);
+	gpio_request(GPIO_FN_MMCCMD0_PU, NULL);
+	gpio_request(GPIO_FN_MMCD0_0, NULL);
+	gpio_request(GPIO_FN_MMCD0_1, NULL);
+	gpio_request(GPIO_FN_MMCD0_2, NULL);
+	gpio_request(GPIO_FN_MMCD0_3, NULL);
+	gpio_request(GPIO_FN_MMCD0_4, NULL);
+	gpio_request(GPIO_FN_MMCD0_5, NULL);
+	gpio_request(GPIO_FN_MMCD0_6, NULL);
+	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_PORT208, NULL); /* Reset */
+	gpio_direction_output(GPIO_PORT208, 1);
+
 	/* enable SMSC911X */
 	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
 	gpio_direction_input(GPIO_PORT144);
--- 0005/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2010-12-22 14:38:28.000000000 +0900
@@ -258,7 +258,7 @@ enum { MSTP001,
 	MSTP125, MSTP116,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329, MSTP323,
+	MSTP331, MSTP329, MSTP323, MSTP312,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
@@ -280,6 +280,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP331] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 31, 0), /* SCIFA6 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
 };
@@ -307,6 +308,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC0 */

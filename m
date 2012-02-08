From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 08 Feb 2012 12:16:51 +0000
Subject: [PATCH 7/7] ARM: mach-shmobile: mackerel: Add the flash controller flctl
Message-Id: <1328703411-3452-7-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com

Add board and clock setup code for the SH Mobile flctl controller.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   71 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7372.c   |    4 +-
 2 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 9c5e598..136b3cb 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -39,6 +39,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/sh_flctl.h>
 #include <linux/pm_clock.h>
 #include <linux/smsc911x.h>
 #include <linux/sh_intc.h>
@@ -994,6 +995,50 @@ static struct platform_device fsi_ak4643_device = {
 	.name		= "sh_fsi2_a_ak4643",
 };
 
+/* FLCTL */
+static struct mtd_partition nand_partition_info[] = {
+	{
+		.name	= "system",
+		.offset	= 0,
+		.size	= 128 * 1024 * 1024,
+	},
+	{
+		.name	= "userdata",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= 256 * 1024 * 1024,
+	},
+	{
+		.name	= "cache",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= 128 * 1024 * 1024,
+	},
+};
+
+static struct resource nand_flash_resources[] = {
+	[0] = {
+		.start	= 0xe6a30000,
+		.end	= 0xe6a3009b,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct sh_flctl_platform_data nand_flash_data = {
+	.parts		= nand_partition_info,
+	.nr_parts	= ARRAY_SIZE(nand_partition_info),
+	.flcmncr_val	= CLK_16_BIT_12HP_LOW_4HP_HIGH | TYPESEL_SET
+			| SHBUSSEL | SEL_16BIT | SNAND_E,
+	.use_holden	= 1,
+};
+
+static struct platform_device nand_flash_device = {
+	.name		= "sh_flctl",
+	.resource	= nand_flash_resources,
+	.num_resources	= ARRAY_SIZE(nand_flash_resources),
+	.dev		= {
+		.platform_data = &nand_flash_data,
+	},
+};
+
 /*
  * The card detect pin of the top SD/MMC slot (CN7) is active low and is
  * connected to GPIO A22 of SH7372 (GPIO_PORT41).
@@ -1306,6 +1351,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_device,
 	&fsi_ak4643_device,
 	&fsi_hdmi_device,
+	&nand_flash_device,
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
@@ -1558,6 +1604,30 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_MMCCMD0, NULL);
 	gpio_request(GPIO_FN_MMCCLK0, NULL);
 
+	/* FLCTL */
+	gpio_request(GPIO_FN_D0_NAF0, NULL);
+	gpio_request(GPIO_FN_D1_NAF1, NULL);
+	gpio_request(GPIO_FN_D2_NAF2, NULL);
+	gpio_request(GPIO_FN_D3_NAF3, NULL);
+	gpio_request(GPIO_FN_D4_NAF4, NULL);
+	gpio_request(GPIO_FN_D5_NAF5, NULL);
+	gpio_request(GPIO_FN_D6_NAF6, NULL);
+	gpio_request(GPIO_FN_D7_NAF7, NULL);
+	gpio_request(GPIO_FN_D8_NAF8, NULL);
+	gpio_request(GPIO_FN_D9_NAF9, NULL);
+	gpio_request(GPIO_FN_D10_NAF10, NULL);
+	gpio_request(GPIO_FN_D11_NAF11, NULL);
+	gpio_request(GPIO_FN_D12_NAF12, NULL);
+	gpio_request(GPIO_FN_D13_NAF13, NULL);
+	gpio_request(GPIO_FN_D14_NAF14, NULL);
+	gpio_request(GPIO_FN_D15_NAF15, NULL);
+	gpio_request(GPIO_FN_FCE0, NULL);
+	gpio_request(GPIO_FN_WE0_FWE, NULL);
+	gpio_request(GPIO_FN_FRB, NULL);
+	gpio_request(GPIO_FN_A4_FOE, NULL);
+	gpio_request(GPIO_FN_A5_FCDE, NULL);
+	gpio_request(GPIO_FN_RD_FSC, NULL);
+
 	/* enable GPS module (GT-720F) */
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
@@ -1602,6 +1672,7 @@ static void __init mackerel_init(void)
 	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &usbhs0_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &usbhs1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &nand_flash_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 995a9c3..99dd283 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -511,7 +511,7 @@ enum { MSTP001, MSTP000,
        MSTP223,
        MSTP218, MSTP217, MSTP216, MSTP214, MSTP208, MSTP207,
        MSTP206, MSTP205, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-       MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
+	MSTP328, MSTP323, MSTP322, MSTP315, MSTP314, MSTP313, MSTP312,
        MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP407, MSTP406,
        MSTP405, MSTP404, MSTP403, MSTP400,
        MSTP_NR };
@@ -553,6 +553,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, 0), /* FSI2 */
 	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
+	[MSTP315] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 15, 0), /* FLCTL*/
 	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMC */
@@ -653,6 +654,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP322]), /* USB0 */
+	CLKDEV_DEV_ID("sh_flctl.0", &mstp_clks[MSTP315]), /* FLCTL */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
-- 
1.7.5.4


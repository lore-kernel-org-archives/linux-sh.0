From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 28 Jul 2009 08:06:49 +0000
Subject: [PATCH] SH: Switch Migo-R to use the tmio MMC driver instead of SPI
Message-Id: <Pine.LNX.4.64.0907280951220.4943@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Allow tmio_mmc driver to be used on SuperH systems and add platform bindngs to
the SH7722 Migo-R platform.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Depends on my previous two patches for tmio_mmc:

http://marc.info/?l=linux-kernel&m4876748530957&w=2
http://marc.info/?l=linux-kernel&m4782904228865&w=2

 arch/sh/boards/mach-migor/setup.c |   48 ++++++++++++++++++++++++++++++-------
 drivers/mmc/host/Kconfig          |    4 +-
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f70f464..fafa88e 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -30,6 +30,8 @@
 #include <asm/sh_keysc.h>
 #include <mach/migor.h>
 #include <cpu/sh7722.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/tmio.h>
 
 /* Address     IRQ  Size  Bus  Description
  * 0x00000000       64MB  16   NOR Flash (SP29PL256N)
@@ -381,17 +383,35 @@ static struct platform_device migor_ceu_device = {
 	},
 };
 
-struct spi_gpio_platform_data sdcard_cn9_platform_data = {
-	.sck = GPIO_PTD0,
-	.mosi = GPIO_PTD1,
-	.miso = GPIO_PTD2,
-	.num_chipselect = 1,
+static struct resource sdhi_cn9_resources[] = {
+	[0] = {
+		.name	= "MMC",
+		.start	= 0x04ce0000,
+		.end	= 0x04ce01ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 101,
+		.end	= 101,
+		.flags  = IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device sdcard_cn9_device = {
-	.name		= "spi_gpio",
+static struct tmio_mmc_data sdhi_cn9_driver_data = {
+	.hclk = 24000000,
+	.clk_name = "sdhi0",
+};
+
+struct mfd_cell sdhi_cn9_platform_data = {
+	.driver_data = &sdhi_cn9_driver_data,
+};
+
+static struct platform_device sdhi_cn9_device = {
+	.name		= "tmio-mmc",
+	.num_resources	= ARRAY_SIZE(sdhi_cn9_resources),
+	.resource	= sdhi_cn9_resources,
 	.dev	= {
-		.platform_data	= &sdcard_cn9_platform_data,
+		.platform_data	= &sdhi_cn9_platform_data,
 	},
 };
 
@@ -458,7 +478,7 @@ static struct platform_device *migor_devices[] __initdata = {
 	&migor_ceu_device,
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
-	&sdcard_cn9_device,
+	&sdhi_cn9_device,
 	&migor_camera[0],
 	&migor_camera[1],
 };
@@ -516,6 +536,16 @@ static int __init migor_devices_setup(void)
 	gpio_request(GPIO_PTA1, NULL);
 	gpio_direction_input(GPIO_PTA1);
 
+	/* SDHI */
+	gpio_request(GPIO_FN_SDHICD, NULL);
+	gpio_request(GPIO_FN_SDHIWP, NULL);
+	gpio_request(GPIO_FN_SDHID3, NULL);
+	gpio_request(GPIO_FN_SDHID2, NULL);
+	gpio_request(GPIO_FN_SDHID1, NULL);
+	gpio_request(GPIO_FN_SDHID0, NULL);
+	gpio_request(GPIO_FN_SDHICMD, NULL);
+	gpio_request(GPIO_FN_SDHICLK, NULL);
+
 	/* Touch Panel */
 	gpio_request(GPIO_FN_IRQ6, NULL);
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 891ef18..6d36132 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -273,10 +273,10 @@ config MMC_SDRICOH_CS
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3
+	depends on MFD_TMIO || MFD_ASIC3 || SUPERH
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
-	  T7L66XB and also HTC ASIC3
+	  T7L66XB, HTC ASIC3 and also SuperH
 
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
-- 
1.6.2.4


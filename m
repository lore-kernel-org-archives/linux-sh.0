From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:40:27 +0000
Subject: [PATCH 6/7] sh: add platform_device of tmio_mmc and sh_mmcif to
Message-Id: <4D675CEB.70100@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |   73 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index be5f5cf..80e502c 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -15,6 +15,9 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/io.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <cpu/sh7757.h>
 #include <asm/sh_eth.h>
 #include <asm/heartbeat.h>
@@ -98,10 +101,80 @@ static struct platform_device sh7757_eth1_device = {
 	},
 };

+/* SH_MMCIF */
+static struct resource sh_mmcif_resources[] = {
+	[0] = {
+		.start	= 0xffcb0000,
+		.end	= 0xffcb00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 211,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= 212,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_mmcif_dma sh7757lcr_mmcif_dma = {
+	.chan_priv_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.chan_priv_rx	= SHDMA_SLAVE_MMCIF_RX,
+};
+
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
+	.dma		= &sh7757lcr_mmcif_dma,
+	.sup_pclk	= 0x0f,
+	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+	.ocr		= MMC_VDD_32_33 | MMC_VDD_33_34,
+};
+
+static struct platform_device sh_mmcif_device = {
+	.name		= "sh_mmcif",
+	.id		= 0,
+	.dev		= {
+		.platform_data		= &sh_mmcif_plat,
+	},
+	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
+	.resource	= sh_mmcif_resources,
+};
+
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI_RX,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+};
+
+static struct resource sdhi_resources[] = {
+	[0] = {
+		.start  = 0xffe50000,
+		.end    = 0xffe501ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 20,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi_resources),
+	.resource       = sdhi_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &sdhi_info,
+	},
+};
+
 static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&heartbeat_device,
 	&sh7757_eth0_device,
 	&sh7757_eth1_device,
+	&sh_mmcif_device,
+	&sdhi_device,
 };

 static struct flash_platform_data spi_flash_data = {
-- 
1.7.1

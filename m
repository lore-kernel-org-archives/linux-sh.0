From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 01 Jul 2011 01:01:02 +0000
Subject: [PATCH] sh: add for i2c-riic driver in board-sh7757lcr
Message-Id: <4E0D1C4E.5000803@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the platform_device of i2c-riic driver and
the i2c_board_info for the board.
This patch also adds the enabling the DMAC for RIIC (DMAER2).
This register is contained in the SH7757 only. the dmaengine
doesn't handle it. So, it is enabled on the board initialize.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |   87 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index fa2a208..00bfcc6 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -18,6 +18,9 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/i2c.h>
+#include <linux/i2c/riic.h>
+#include <linux/i2c/at24.h>
 #include <cpu/sh7757.h>
 #include <asm/sh_eth.h>
 #include <asm/heartbeat.h>
@@ -260,6 +263,60 @@ static struct platform_device sdhi_device = {
 	},
 };

+struct riic_platform_data riic2_pdata = {
+	.clock = 400,
+	.dma_tx = {
+		.slave_id = SHDMA_SLAVE_RIIC2_TX,
+	},
+	.dma_rx = {
+		.slave_id = SHDMA_SLAVE_RIIC2_RX,
+	},
+};
+
+static struct resource riic2_resources[] = {
+	{
+		.start  = 0xfe520000,
+		.end    = 0xfe5200ff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = 160,
+		.flags  = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device riic2_device = {
+	.name		= "i2c-riic",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(riic2_resources),
+	.resource	= riic2_resources,
+	.dev		= {
+		.platform_data = &riic2_pdata,
+	},
+};
+
+/* We don't use DMA on the channel because LM75 donen't use large data. */
+struct riic_platform_data riic3_pdata = {
+	.clock = 400,
+};
+
+static struct resource riic3_resources[] = {
+	{
+		.start  = 0xfe530000,
+		.end    = 0xfe5300ff,
+		.flags  = IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device riic3_device = {
+	.name		= "i2c-riic",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(riic3_resources),
+	.resource	= riic3_resources,
+	.dev		= {
+		.platform_data = &riic3_pdata,
+	},
+};
+
 static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&heartbeat_device,
 	&sh7757_eth0_device,
@@ -268,6 +325,8 @@ static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&sh7757_eth_giga1_device,
 	&sh_mmcif_device,
 	&sdhi_device,
+	&riic2_device,
+	&riic3_device,
 };

 static struct flash_platform_data spi_flash_data = {
@@ -285,6 +344,26 @@ static struct spi_board_info spi_board_info[] = {
 	},
 };

+static struct at24_platform_data sh7757_at24_platdata = {
+	.byte_len	= 8192,
+	.page_size	= 64,
+	.flags		= AT24_FLAG_ADDR16,
+};
+
+static struct i2c_board_info __initdata riic2_board_devices[] = {
+	{
+		I2C_BOARD_INFO("24c64", 0x50),
+		.platform_data = &sh7757_at24_platdata,
+	},
+};
+
+static struct i2c_board_info __initdata riic3_board_devices[] = {
+	{
+		I2C_BOARD_INFO("lm75", 0x4f),
+	},
+};
+
+#define DMAER2	0xfffa0000
 static int __init sh7757lcr_devices_setup(void)
 {
 	/* RGMII (PTA) */
@@ -517,6 +596,14 @@ static int __init sh7757lcr_devices_setup(void)
 	spi_register_board_info(spi_board_info,
 				ARRAY_SIZE(spi_board_info));

+	i2c_register_board_info(2, riic2_board_devices,
+				ARRAY_SIZE(riic2_board_devices));
+	i2c_register_board_info(3, riic3_board_devices,
+				ARRAY_SIZE(riic3_board_devices));
+
+	/* Enable RIIC's DMA */
+	__raw_writel(0x000003ff, DMAER2);
+
 	/* General platform */
 	return platform_add_devices(sh7757lcr_devices,
 				    ARRAY_SIZE(sh7757lcr_devices));
-- 
1.7.1

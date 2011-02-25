From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:39:32 +0000
Subject: [PATCH 3/7] sh: add spi_board_info in sh7757lcr
Message-Id: <4D675CB4.80409@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index c475f10..be5f5cf 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -104,6 +104,21 @@ static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&sh7757_eth1_device,
 };

+static struct flash_platform_data spi_flash_data = {
+	.name = "m25p80",
+	.type = "m25px64",
+};
+
+static struct spi_board_info spi_board_info[] = {
+	{
+		.modalias = "m25p80",
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.platform_data = &spi_flash_data,
+	},
+};
+
 static int __init sh7757lcr_devices_setup(void)
 {
 	/* RGMII (PTA) */
@@ -332,6 +347,10 @@ static int __init sh7757lcr_devices_setup(void)
 	gpio_request(GPIO_PTT5, NULL);		/* eMMC_PRST# */
 	gpio_direction_output(GPIO_PTT5, 1);

+	/* register SPI device information */
+	spi_register_board_info(spi_board_info,
+				ARRAY_SIZE(spi_board_info));
+
 	/* General platform */
 	return platform_add_devices(sh7757lcr_devices,
 				    ARRAY_SIZE(sh7757lcr_devices));
-- 
1.7.1

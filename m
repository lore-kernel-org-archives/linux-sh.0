From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:50:03 +0000
Subject: [PATCH 07/13 v2] sh: add fixed voltage regulators to sh7757lcr
Message-Id: <1340751009-18663-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On sh7757lcr provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-sh7757lcr.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 5087f8b..41f8670 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -12,6 +12,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/irq.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/io.h>
@@ -199,6 +201,15 @@ static struct platform_device sh7757_eth_giga1_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0, MMCIF */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -329,6 +340,9 @@ static struct spi_board_info spi_board_info[] = {
 
 static int __init sh7757lcr_devices_setup(void)
 {
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+
 	/* RGMII (PTA) */
 	gpio_request(GPIO_FN_ET0_MDC, NULL);
 	gpio_request(GPIO_FN_ET0_MDIO, NULL);
-- 
1.7.2.5


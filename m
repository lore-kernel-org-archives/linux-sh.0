From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:36 +0000
Subject: [PATCH 07/11] ARM: mach-shmobile: add fixed voltage regulators to g4evm
Message-Id: <1340179300-16452-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On g4evm provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-g4evm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 0e5a39c..e28bfb3 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/regulator/machine.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/io.h>
 #include <linux/input.h>
@@ -35,6 +36,7 @@
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
 #include <mach/irqs.h>
+#include <mach/regulator.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -196,6 +198,17 @@ static struct platform_device keysc_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0 and SDHI1 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps	= MMC_CAP_SDIO_IRQ,
@@ -252,6 +265,7 @@ static struct platform_device sdhi1_device = {
 };
 
 static struct platform_device *g4evm_devices[] __initdata = {
+	&fixed_power_0,
 	&nor_flash_device,
 	&usb_host_device,
 	&keysc_device,
-- 
1.7.2.5


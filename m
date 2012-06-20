From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:16 +0000
Subject: [PATCH 08/14] sh: add fixed voltage regulators to sh7757lcr
Message-Id: <1340205142-32606-9-git-send-email-g.liakhovetski@gmx.de>
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
index 5087f8b..dc3a036 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/irq.h>
+#include <linux/regulator/machine.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/io.h>
@@ -21,6 +22,7 @@
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/usb/renesas_usbhs.h>
+#include <mach/regulator.h>
 #include <cpu/sh7757.h>
 #include <asm/heartbeat.h>
 
@@ -199,6 +201,17 @@ static struct platform_device sh7757_eth_giga1_device = {
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
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
 /* SH_MMCIF */
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
@@ -302,6 +315,7 @@ static struct platform_device usb0_device = {
 };
 
 static struct platform_device *sh7757lcr_devices[] __initdata = {
+	&fixed_power_0,
 	&heartbeat_device,
 	&sh7757_eth0_device,
 	&sh7757_eth1_device,
-- 
1.7.2.5


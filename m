From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:22 +0000
Subject: [PATCH 14/14] sh: add fixed voltage regulators to se7724
Message-Id: <1340205142-32606-15-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On se7724 provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-se/7724/setup.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index ffbf5bc..df54c90 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -18,6 +18,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
+#include <linux/regulator/machine.h>
 #include <linux/smc91x.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
@@ -36,6 +37,7 @@
 #include <asm/suspend.h>
 #include <cpu/sh7724.h>
 #include <mach-se/mach/se7724.h>
+#include <mach/regulator.h>
 
 /*
  * SWx    1234 5678
@@ -454,6 +456,17 @@ static struct platform_device sh7724_usb1_gadget_device = {
 	.resource	= sh7724_usb1_gadget_resources,
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0, SDHI1 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
 static struct resource sdhi0_cn7_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -575,6 +588,7 @@ static struct platform_device vou_device = {
 };
 
 static struct platform_device *ms7724se_devices[] __initdata = {
+	&fixed_power_0,
 	&heartbeat_device,
 	&smc91x_eth_device,
 	&lcdc_device,
-- 
1.7.2.5


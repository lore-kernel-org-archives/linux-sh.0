From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:17 +0000
Subject: [PATCH 09/14] sh: add fixed voltage regulators to ap325rxa
Message-Id: <1340205142-32606-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On ap325rxa provide a 3.3V supply for its SD/MMC-card interfaces and a
dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ap325rxa/setup.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index f33ebf4..6a89aec 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -20,6 +20,8 @@
 #include <linux/mtd/sh_flctl.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
 #include <linux/videodev2.h>
@@ -33,6 +35,13 @@
 #include <asm/clock.h>
 #include <asm/suspend.h>
 #include <cpu/sh7723.h>
+#include <mach/regulator.h>
+
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
 
 static struct smsc911x_platform_config smsc911x_config = {
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
@@ -423,6 +432,17 @@ static struct platform_device ceu_device = {
 	},
 };
 
+/* Fixed 3.3V regulators to be used by SDHI0, SDHI1 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
 static struct resource sdhi0_cn3_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -519,6 +539,7 @@ static struct platform_device ap325rxa_camera[] = {
 };
 
 static struct platform_device *ap325rxa_devices[] __initdata = {
+	&fixed_power_0,
 	&smsc9118_device,
 	&ap325rxa_nor_flash_device,
 	&lcdc_device,
@@ -544,6 +565,8 @@ static int __init ap325rxa_devices_setup(void)
 					&ap325rxa_sdram_leave_start,
 					&ap325rxa_sdram_leave_end);
 
+	regulator_register_fixed(1, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	/* LD3 and LD4 LEDs */
 	gpio_request(GPIO_PTX5, NULL); /* RUN */
 	gpio_direction_output(GPIO_PTX5, 1);
-- 
1.7.2.5


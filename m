From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:33 +0000
Subject: [PATCH 04/11] ARM: mach-shmobile: add fixed voltage regulators to ap4evb
Message-Id: <1340179300-16452-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On ap4evb provide 1.8V and 3.3V supplies for its SD/MMC-card interfaces
and a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 0c3caeba..fb86eff 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -34,6 +34,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/io.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_clk.h>
@@ -57,6 +59,7 @@
 
 #include <mach/common.h>
 #include <mach/irqs.h>
+#include <mach/regulator.h>
 #include <mach/sh7372.h>
 
 #include <asm/mach-types.h>
@@ -158,6 +161,30 @@
  * CN12: 3.3v
  */
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
+static struct regulator_consumer_supply fixed1v8_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
+REGULATOR_FIXED(fixed1v8_power_consumers, 1, 1800000);
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -1030,6 +1057,8 @@ static struct platform_device ceu_device = {
 };
 
 static struct platform_device *ap4evb_devices[] __initdata = {
+	&fixed_power_0,
+	&fixed_power_1,
 	&leds_device,
 	&nor_flash_device,
 	&smc911x_device,
@@ -1197,6 +1226,8 @@ static void __init ap4evb_init(void)
 	u32 srcr4;
 	struct clk *clk;
 
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 
-- 
1.7.2.5


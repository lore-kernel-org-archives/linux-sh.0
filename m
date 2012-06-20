From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:31 +0000
Subject: [PATCH 02/11] ARM: mach-shmobile: add 3.3V and 1.8V fixed regulators to mackerel
Message-Id: <1340179300-16452-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Drivers for several devices on mackerel, including all SDHI instances, the
MMCIF controller and the SMSC9220 ethernet chip use regulators to control
power supply to their devices. MMC drivers need to be able to at least
retrieve voltage values from supplying regulators, whereas the smsc911x
driver only enables and disables chip power supplies without further looking
at them. This patch adds two fixed voltage regulators to describe 1.8V and
3.3V supplies on the board and a dummy regulator for SMSC9220.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   34 +++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index aae2e24..6147386 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -41,6 +41,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
 #include <linux/pm_clock.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/sh_intc.h>
 #include <linux/tca6416_keypad.h>
@@ -56,6 +58,7 @@
 
 #include <mach/common.h>
 #include <mach/irqs.h>
+#include <mach/regulator.h>
 #include <mach/sh7372.h>
 
 #include <asm/mach/arch.h>
@@ -228,6 +231,33 @@ static void __init gpio_pull_down(u32 addr)
 	__raw_writeb(data, addr);
 }
 
+/* Fixed 3.3V and 1.8V regulators to be used by multiple devices */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
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
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -1292,6 +1322,8 @@ static struct platform_device mackerel_camera = {
 };
 
 static struct platform_device *mackerel_devices[] __initdata = {
+	&fixed_power_0,
+	&fixed_power_1,
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
@@ -1382,6 +1414,8 @@ static void __init mackerel_init(void)
 	u32 srcr4;
 	struct clk *clk;
 
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 
-- 
1.7.2.5


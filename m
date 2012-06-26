From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:32:23 +0000
Subject: [PATCH 01/10 v3] ARM: mach-shmobile: add 3.3V and 1.8V fixed regulators to mackerel
Message-Id: <1340749952-8534-2-git-send-email-g.liakhovetski@gmx.de>
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

v3: added comment about the J22 Vdd jumper

 arch/arm/mach-shmobile/board-mackerel.c |   35 +++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b577f7c..5b89dc8 100644
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
@@ -229,6 +231,33 @@ static void __init gpio_pull_down(u32 addr)
 	__raw_writeb(data, addr);
 }
 
+/* Fixed 3.3V and 1.8V regulators to be used by multiple devices */
+static struct regulator_consumer_supply fixed1v8_power_consumers[] +{
+	/*
+	 * J22 on mackerel switches mmcif.0 and sdhi.1 between 1.8V and 3.3V
+	 * Since we cannot support both voltages, we support the default 1.8V
+	 */
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.1"),
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif.0"),
+};
+
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.2"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.2"),
+};
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
@@ -1409,6 +1438,12 @@ static void __init mackerel_init(void)
 	u32 srcr4;
 	struct clk *clk;
 
+	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
+				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 
-- 
1.7.2.5


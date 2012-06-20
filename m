From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:19 +0000
Subject: [PATCH 11/14] sh: add fixed voltage regulators to migor
Message-Id: <1340205142-32606-12-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On migor provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-migor/setup.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index a8a1ca7..1d11633 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
+#include <linux/regulator/machine.h>
 #include <linux/smc91x.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
@@ -33,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/suspend.h>
 #include <mach/migor.h>
+#include <mach/regulator.h>
 #include <cpu/sh7722.h>
 
 /* Address     IRQ  Size  Bus  Description
@@ -386,6 +388,15 @@ static struct platform_device migor_ceu_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
+REGULATOR_FIXED(fixed3v3_power_consumers, 0, 3300000);
+
 static struct resource sdhi_cn9_resources[] = {
 	[0] = {
 		.name	= "SDHI",
@@ -474,6 +485,7 @@ static struct platform_device migor_camera[] = {
 };
 
 static struct platform_device *migor_devices[] __initdata = {
+	&fixed_power_0,
 	&smc91x_eth_device,
 	&sh_keysc_device,
 	&migor_lcdc_device,
-- 
1.7.2.5


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:50:06 +0000
Subject: [PATCH 10/13 v2] sh: add fixed voltage regulators to migor
Message-Id: <1340751009-18663-11-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On migor provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-migor/setup.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index a8a1ca7..8b73194e 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -17,6 +17,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smc91x.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
@@ -386,6 +388,13 @@ static struct platform_device migor_ceu_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+};
+
 static struct resource sdhi_cn9_resources[] = {
 	[0] = {
 		.name	= "SDHI",
@@ -498,6 +507,10 @@ static int __init migor_devices_setup(void)
 					&migor_sdram_enter_end,
 					&migor_sdram_leave_start,
 					&migor_sdram_leave_end);
+
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+
 	/* Let D11 LED show STATUS0 */
 	gpio_request(GPIO_FN_STATUS0, NULL);
 
-- 
1.7.2.5


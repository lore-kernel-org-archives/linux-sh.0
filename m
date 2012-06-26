From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:50:09 +0000
Subject: [PATCH 13/13 v2] sh: add fixed voltage regulators to se7724
Message-Id: <1340751009-18663-14-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On se7724 provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-se/7724/setup.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index ffbf5bc..35f6efa 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -18,6 +18,8 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smc91x.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
@@ -454,6 +456,15 @@ static struct platform_device sh7724_usb1_gadget_device = {
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
 static struct resource sdhi0_cn7_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -684,6 +695,10 @@ static int __init devices_setup(void)
 					&ms7724se_sdram_enter_end,
 					&ms7724se_sdram_leave_start,
 					&ms7724se_sdram_leave_end);
+
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+
 	/* Reset Release */
 	fpga_out = __raw_readw(FPGA_OUT);
 	/* bit4: NTSC_PDN, bit5: NTSC_RESET */
-- 
1.7.2.5


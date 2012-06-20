From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:18 +0000
Subject: [PATCH 10/14] sh: add fixed voltage regulators to kfr2r09
Message-Id: <1340205142-32606-11-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kfr2r09 provide a 3.3V supply for its SD/MMC-card interfaces.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-kfr2r09/setup.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 158c917..b87a98f 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -21,6 +21,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/i2c.h>
+#include <linux/regulator/machine.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/videodev2.h>
 #include <linux/sh_intc.h>
@@ -34,6 +35,7 @@
 #include <asm/io.h>
 #include <cpu/sh7724.h>
 #include <mach/kfr2r09.h>
+#include <mach/regulator.h>
 
 static struct mtd_partition kfr2r09_nor_flash_partitions[]  {
@@ -341,6 +343,15 @@ static struct platform_device kfr2r09_camera = {
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
 static struct resource kfr2r09_sh_sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -371,6 +382,7 @@ static struct platform_device kfr2r09_sh_sdhi0_device = {
 };
 
 static struct platform_device *kfr2r09_devices[] __initdata = {
+	&fixed_power_0,
 	&kfr2r09_nor_flash_device,
 	&kfr2r09_nand_flash_device,
 	&kfr2r09_sh_keysc_device,
-- 
1.7.2.5


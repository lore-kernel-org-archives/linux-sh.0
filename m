From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:38 +0000
Subject: [PATCH 09/11] ARM: mach-shmobile: add fixed voltage regulators to kzm9d
Message-Id: <1340179300-16452-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On kzm9d provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9d.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index 7bc5e7d..21ddd12 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -21,6 +21,8 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
@@ -28,6 +30,12 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 /* Ether */
 static struct resource smsc911x_resources[] = {
 	[0] = {
@@ -63,6 +71,8 @@ static struct platform_device *kzm9d_devices[] __initdata = {
 
 void __init kzm9d_add_standard_devices(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	emev2_add_standard_devices();
 
 	platform_add_devices(kzm9d_devices, ARRAY_SIZE(kzm9d_devices));
-- 
1.7.2.5


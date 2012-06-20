From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:15 +0000
Subject: [PATCH 07/14] sh: add fixed voltage regulators to sh2007
Message-Id: <1340205142-32606-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On sh2007 provide a dummy regulator for the smsc911x driver for the two
SMSC 9118 devices.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-sh2007.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh2007.c b/arch/sh/boards/board-sh2007.c
index b90b78f..1980bb7 100644
--- a/arch/sh/boards/board-sh2007.c
+++ b/arch/sh/boards/board-sh2007.c
@@ -6,6 +6,8 @@
  */
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
@@ -13,6 +15,14 @@
 #include <asm/machvec.h>
 #include <mach/sh2007.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x.1"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.1"),
+};
+
 struct smsc911x_platform_config smc911x_info = {
 	.flags		= SMSC911X_USE_32BIT,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
@@ -98,6 +108,8 @@ static struct platform_device *sh2007_devices[] __initdata = {
 
 static int __init sh2007_io_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	platform_add_devices(sh2007_devices, ARRAY_SIZE(sh2007_devices));
 	return 0;
 }
-- 
1.7.2.5


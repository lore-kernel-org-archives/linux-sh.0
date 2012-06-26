From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:50:07 +0000
Subject: [PATCH 11/13 v2] sh: add fixed voltage regulators to rsk
Message-Id: <1340751009-18663-12-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On rsk devices provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-rsk/setup.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/setup.c b/arch/sh/boards/mach-rsk/setup.c
index 895f030..2685ea0 100644
--- a/arch/sh/boards/mach-rsk/setup.c
+++ b/arch/sh/boards/mach-rsk/setup.c
@@ -16,9 +16,17 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/map.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 static const char *part_probes[] = { "cmdlinepart", NULL };
 
 static struct mtd_partition rsk_partitions[] = {
@@ -67,6 +75,8 @@ static struct platform_device *rsk_devices[] __initdata = {
 
 static int __init rsk_devices_setup(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	return platform_add_devices(rsk_devices,
 				    ARRAY_SIZE(rsk_devices));
 }
-- 
1.7.2.5


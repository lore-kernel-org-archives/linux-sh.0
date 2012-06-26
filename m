From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:50:00 +0000
Subject: [PATCH 04/13 v2] sh: add fixed voltage regulators to magicpanelr2
Message-Id: <1340751009-18663-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On magicpanelr2 provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-magicpanelr2.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-magicpanelr2.c b/arch/sh/boards/board-magicpanelr2.c
index 90568f9..2050085 100644
--- a/arch/sh/boards/board-magicpanelr2.c
+++ b/arch/sh/boards/board-magicpanelr2.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -24,6 +26,12 @@
 #include <asm/heartbeat.h>
 #include <cpu/sh7720.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 #define LAN9115_READY	(__raw_readl(0xA8000084UL) & 0x00000001UL)
 
 /* Wait until reset finished. Timeout is 100ms. */
@@ -348,6 +356,8 @@ static struct platform_device *mpr2_devices[] __initdata = {
 
 static int __init mpr2_devices_setup(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	return platform_add_devices(mpr2_devices, ARRAY_SIZE(mpr2_devices));
 }
 device_initcall(mpr2_devices_setup);
-- 
1.7.2.5


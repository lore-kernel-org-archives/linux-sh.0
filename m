From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:49:58 +0000
Subject: [PATCH 02/13 v2] sh: add fixed voltage regulators to apsh4a3a
Message-Id: <1340751009-18663-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On apsh4a3a provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-apsh4a3a.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-apsh4a3a.c b/arch/sh/boards/board-apsh4a3a.c
index 2823619..0a39c24 100644
--- a/arch/sh/boards/board-apsh4a3a.c
+++ b/arch/sh/boards/board-apsh4a3a.c
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/mtd/physmap.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
@@ -66,6 +68,12 @@ static struct platform_device nor_flash_device = {
 	.resource	= nor_flash_resources,
 };
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 static struct resource smsc911x_resources[] = {
 	[0] = {
 		.name		= "smsc911x-memory",
@@ -105,6 +113,8 @@ static struct platform_device *apsh4a3a_devices[] __initdata = {
 
 static int __init apsh4a3a_devices_setup(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	return platform_add_devices(apsh4a3a_devices,
 				    ARRAY_SIZE(apsh4a3a_devices));
 }
-- 
1.7.2.5


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:49:59 +0000
Subject: [PATCH 03/13 v2] sh: add fixed voltage regulators to apsh4ad0a
Message-Id: <1340751009-18663-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On apsh4ad0a provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-apsh4ad0a.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-apsh4ad0a.c b/arch/sh/boards/board-apsh4ad0a.c
index b4d6292..92eac3a 100644
--- a/arch/sh/boards/board-apsh4ad0a.c
+++ b/arch/sh/boards/board-apsh4ad0a.c
@@ -12,12 +12,20 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <asm/machvec.h>
 #include <asm/sizes.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 static struct resource smsc911x_resources[] = {
 	[0] = {
 		.name		= "smsc911x-memory",
@@ -56,6 +64,8 @@ static struct platform_device *apsh4ad0a_devices[] __initdata = {
 
 static int __init apsh4ad0a_devices_setup(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	return platform_add_devices(apsh4ad0a_devices,
 				    ARRAY_SIZE(apsh4ad0a_devices));
 }
-- 
1.7.2.5


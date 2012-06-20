From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:21 +0000
Subject: [PATCH 13/14] sh: add fixed voltage regulators to sdk7786
Message-Id: <1340205142-32606-14-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On sdk7786 provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-sdk7786/setup.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-sdk7786/setup.c b/arch/sh/boards/mach-sdk7786/setup.c
index 27a2314..c29268b 100644
--- a/arch/sh/boards/mach-sdk7786/setup.c
+++ b/arch/sh/boards/mach-sdk7786/setup.c
@@ -11,6 +11,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
@@ -38,6 +40,12 @@ static struct platform_device heartbeat_device = {
 	.resource	= &heartbeat_resource,
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
@@ -236,6 +244,8 @@ static void __init sdk7786_setup(char **cmdline_p)
 {
 	pr_info("Renesas Technology Europe SDK7786 support:\n");
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	sdk7786_fpga_init();
 	sdk7786_nmi_init();
 
-- 
1.7.2.5


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:14 +0000
Subject: [PATCH 06/14] sh: add fixed voltage regulators to polaris
Message-Id: <1340205142-32606-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On polaris provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/board-polaris.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-polaris.c b/arch/sh/boards/board-polaris.c
index 37d03c0..758f432 100644
--- a/arch/sh/boards/board-polaris.c
+++ b/arch/sh/boards/board-polaris.c
@@ -9,6 +9,8 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/io.h>
 #include <asm/irq.h>
@@ -22,6 +24,12 @@
 #define AREA5_WAIT_CTRL	(0x1C00)
 #define WAIT_STATES_10	(0x7)
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
 static struct resource smsc911x_resources[] = {
 	[0] = {
 		.name		= "smsc911x-memory",
@@ -88,6 +96,8 @@ static int __init polaris_initialise(void)
 
 	printk(KERN_INFO "Configuring Polaris external bus\n");
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	/* Configure area 5 with 2 wait states */
 	wcr = __raw_readw(WCR2);
 	wcr &= (~AREA5_WAIT_CTRL);
-- 
1.7.2.5


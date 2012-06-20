From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:40 +0000
Subject: [PATCH 11/11] ARM: mach-shmobile: add fixed voltage regulators to marzen
Message-Id: <1340179300-16452-12-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On marzen provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-marzen.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index ef0e13b..bc12cbc 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -27,6 +27,8 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
@@ -37,6 +39,12 @@
 #include <asm/hardware/gic.h>
 #include <asm/traps.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 /* SMSC LAN89218 */
 static struct resource smsc911x_resources[] = {
 	[0] = {
@@ -73,6 +81,8 @@ static struct platform_device *marzen_devices[] __initdata = {
 
 static void __init marzen_init(void)
 {
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	r8a7779_pinmux_init();
 
 	/* SCIF2 (CN18: DEBUG0) */
-- 
1.7.2.5


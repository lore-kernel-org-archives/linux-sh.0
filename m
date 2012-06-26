From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:32:27 +0000
Subject: [PATCH 05/10 v3] ARM: mach-shmobile: add fixed voltage regulators to bonito
Message-Id: <1340749952-8534-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On bonito provide a dummy regulator for the smsc911x driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-bonito.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index e9b32cf..4129008 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -26,6 +26,8 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/videodev2.h>
 #include <mach/common.h>
@@ -75,6 +77,12 @@
  * S38.2 = OFF
  */
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+};
+
 /*
  * FPGA
  */
@@ -360,6 +368,8 @@ static void __init bonito_init(void)
 {
 	u16 val;
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	r8a7740_pinmux_init();
 	bonito_fpga_init();
 
-- 
1.7.2.5


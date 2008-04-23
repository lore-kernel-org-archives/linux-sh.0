From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 11:13:59 +0000
Subject: [PATCH] sh: update smc91x platform data for MigoR
Message-Id: <20080423111359.3386.28006.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Select smc91x bus width and irg flags using platform data for MigoR
now when the smc91x header file is in place.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-04-22 17:23:12.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
+#include <linux/smc91x.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
@@ -27,6 +28,11 @@
  * 0x18000000       8GB    8   NAND Flash (K9K8G08U0A)
  */
 
+static struct smc91x_platdata smc91x_info = {
+	.flags = SMC91X_USE_16BIT,
+	.irq_flags = IRQF_TRIGGER_HIGH,
+};
+
 static struct resource smc91x_eth_resources[] = {
 	[0] = {
 		.name   = "SMC91C111" ,
@@ -36,7 +42,7 @@ static struct resource smc91x_eth_resour
 	},
 	[1] = {
 		.start  = 32, /* IRQ0 */
-		.flags  = IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
+		.flags  = IORESOURCE_IRQ,
 	},
 };
 
@@ -44,6 +50,9 @@ static struct platform_device smc91x_eth
 	.name           = "smc91x",
 	.num_resources  = ARRAY_SIZE(smc91x_eth_resources),
 	.resource       = smc91x_eth_resources,
+	.dev	= {
+		.platform_data	= &smc91x_info,
+	},
 };
 
 static struct sh_keysc_info sh_keysc_info = {

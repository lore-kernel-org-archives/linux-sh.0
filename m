From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Feb 2008 10:51:32 +0000
Subject: [PATCH] sh: smc91x platform data for the migor board
Message-Id: <20080220105132.7184.40411.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds smc91x platform data to the MigoR board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Depends on smc91x patches recently sent to netdev:
  http://marc.info/?l=linux-netdev&m0350178921242&w=2

 arch/sh/boards/renesas/migor/setup.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-02-20 15:48:27.000000000 +0900
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/smc91x.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 
@@ -21,6 +22,11 @@
  * 0x18000000       8GB    8   NAND Flash (K9K8G08U0A)
  */
 
+static struct smc91x_platdata smc91x_info = {
+	.flags = SMC91X_USE_16BIT,
+	.irq_flags = IRQF_TRIGGER_HIGH,
+};
+
 static struct resource smc91x_eth_resources[] = {
 	[0] = {
 		.name   = "smc91x-regs" ,
@@ -30,7 +36,7 @@ static struct resource smc91x_eth_resour
 	},
 	[1] = {
 		.start  = 32, /* IRQ0 */
-		.flags  = IORESOURCE_IRQ | IRQF_TRIGGER_HIGH,
+		.flags  = IORESOURCE_IRQ,
 	},
 };
 
@@ -38,6 +44,9 @@ static struct platform_device smc91x_eth
 	.name           = "smc91x",
 	.num_resources  = ARRAY_SIZE(smc91x_eth_resources),
 	.resource       = smc91x_eth_resources,
+	.dev	= {
+		.platform_data	= &smc91x_info,
+	},
 };
 
 static struct platform_device *migor_devices[] __initdata = {

From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Jul 2008 10:11:07 +0000
Subject: [PATCH] sh: Update smc911x platform data for AP325RXA
Message-Id: <20080728101107.18291.82164.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Pass board specific smc911x parameters using struct smc911x_platdata.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/ap325rxa/setup.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0004/arch/sh/boards/renesas/ap325rxa/setup.c
+++ work/arch/sh/boards/renesas/ap325rxa/setup.c	2008-07-28 18:56:20.000000000 +0900
@@ -12,15 +12,22 @@
 
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/smc911x.h>
 #include <asm/sh_mobile_lcdc.h>
 #include <asm/io.h>
 #include <asm/clock.h>
 
+static struct smc911x_platdata smc911x_info = {
+	.flags = SMC911X_USE_32BIT,
+	.irq_flags = IRQF_TRIGGER_LOW,
+};
+
 static struct resource smc9118_resources[] = {
 	[0] = {
 		.start	= 0xb6080000,
@@ -39,6 +46,9 @@ static struct platform_device smc9118_de
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(smc9118_resources),
 	.resource	= smc9118_resources,
+	.dev		= {
+		.platform_data = &smc911x_info,
+	},
 };
 
 static struct mtd_partition ap325rxa_nor_flash_partitions[] = {

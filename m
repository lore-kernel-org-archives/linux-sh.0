From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 11:18:04 +0000
Subject: [PATCH] sh: update smc91x platform data for se7722
Message-Id: <20080423111804.3816.74432.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080423111359.3386.28006.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080423111359.3386.28006.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Select smc91x bus width using platform data for se7722 now when the
smc91x header file is in place.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/se/7722/setup.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/sh/boards/se/7722/setup.c
+++ work/arch/sh/boards/se/7722/setup.c	2008-04-23 19:18:46.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/input.h>
+#include <linux/smc91x.h>
 #include <asm/machvec.h>
 #include <asm/se7722.h>
 #include <asm/io.h>
@@ -44,6 +45,10 @@ static struct platform_device heartbeat_
 };
 
 /* SMC91x */
+static struct smc91x_platdata smc91x_info = {
+	.flags = SMC91X_USE_16BIT,
+};
+
 static struct resource smc91x_eth_resources[] = {
 	[0] = {
 		.name   = "smc91x-regs" ,
@@ -64,6 +69,7 @@ static struct platform_device smc91x_eth
 	.dev = {
 		.dma_mask               = NULL,         /* don't use dma */
 		.coherent_dma_mask      = 0xffffffff,
+		.platform_data	= &smc91x_info,
 	},
 	.num_resources  = ARRAY_SIZE(smc91x_eth_resources),
 	.resource       = smc91x_eth_resources,

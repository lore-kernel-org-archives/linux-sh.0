From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 03:16:40 +0000
Subject: [PATCH] sh: x3proto: add platform data for r8a66597-hcd
Message-Id: <4A1B5F18.1090903@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

and remove redundant parameter for r8a66597-hcd

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 This patch depends on the following patch.
 http://marc.info/?l=linux-usb&m4330739812843&w=2

 arch/sh/boards/mach-x3proto/setup.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3proto/setup.c
index a340492..35508c9 100644
--- a/arch/sh/boards/mach-x3proto/setup.c
+++ b/arch/sh/boards/mach-x3proto/setup.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/smc91x.h>
 #include <linux/irq.h>
+#include <linux/usb/r8a66597.h>
 #include <asm/ilsel.h>

 static struct resource heartbeat_resources[] = {
@@ -58,17 +59,21 @@ static struct platform_device smc91x_device = {
 	},
 };

+static struct r8a66597_platdata r8a66597_data = {
+	.xtal = R8A66597_PLATDATA_XTAL_12MHZ,
+	.vif = 1,
+	.irq_sense = 1,
+};
+
 static struct resource r8a66597_usb_host_resources[] = {
 	[0] = {
-		.name	= "r8a66597_hcd",
 		.start	= 0x18040000,
 		.end	= 0x18080000 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.name	= "r8a66597_hcd",
 		/* Filled in by ilsel */
-		.flags	= IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };

@@ -78,6 +83,7 @@ static struct platform_device r8a66597_usb_host_device = {
 	.dev = {
 		.dma_mask		= NULL,		/* don't use dma */
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &r8a66597_data,
 	},
 	.num_resources	= ARRAY_SIZE(r8a66597_usb_host_resources),
 	.resource	= r8a66597_usb_host_resources,
-- 
1.5.5




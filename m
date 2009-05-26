From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 09:33:02 +0000
Subject: [PATCH v2] sh: sh7785lcr: add platform data for r8a66597-hcd
Message-Id: <4A1BB74E.5070907@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

and remove redundant parameter for r8a66597-hcd.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 This patch depends on the following patch.
 http://marc.info/?l=linux-usb&m4332990308291&w=2

 arch/sh/boards/board-sh7785lcr.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 6f94f17..e2c2903 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -19,6 +19,8 @@
 #include <linux/i2c-pca-platform.h>
 #include <linux/i2c-algo-pca.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/usb/r8a66597.h>
 #include <asm/heartbeat.h>
 #include <mach/sh7785lcr.h>

@@ -94,18 +96,21 @@ static struct platform_device nor_flash_device = {
 	.resource	= nor_flash_resources,
 };

+static struct r8a66597_platdata r8a66597_data = {
+	.xtal = R8A66597_PLATDATA_XTAL_12MHZ,
+	.vif = 1,
+};
+
 static struct resource r8a66597_usb_host_resources[] = {
 	[0] = {
-		.name	= "r8a66597_hcd",
 		.start	= R8A66597_ADDR,
 		.end	= R8A66597_ADDR + R8A66597_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.name	= "r8a66597_hcd",
 		.start	= 2,
 		.end	= 2,
-		.flags	= IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };

@@ -115,6 +120,7 @@ static struct platform_device r8a66597_usb_host_device = {
 	.dev = {
 		.dma_mask		= NULL,
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &r8a66597_data,
 	},
 	.num_resources	= ARRAY_SIZE(r8a66597_usb_host_resources),
 	.resource	= r8a66597_usb_host_resources,
-- 
1.5.5



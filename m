From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 09:33:05 +0000
Subject: [PATCH v2] sh: highlander: add platform data for r8a66597-hcd
Message-Id: <4A1BB751.1080100@renesas.com>
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

 arch/sh/boards/mach-highlander/setup.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index 20fe72c..920ea76 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -19,6 +19,8 @@
 #include <linux/types.h>
 #include <linux/i2c.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/usb/r8a66597.h>
 #include <net/ax88796.h>
 #include <asm/machvec.h>
 #include <mach/highlander.h>
@@ -27,18 +29,21 @@
 #include <asm/io.h>
 #include <asm/io_trapped.h>

+static struct r8a66597_platdata r8a66597_data = {
+	.xtal = R8A66597_PLATDATA_XTAL_12MHZ,
+	.vif = 1,
+};
+
 static struct resource r8a66597_usb_host_resources[] = {
 	[0] = {
-		.name	= "r8a66597_hcd",
 		.start	= 0xA4200000,
 		.end	= 0xA42000FF,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.name	= "r8a66597_hcd",
 		.start	= IRQ_EXT1,		/* irq number */
 		.end	= IRQ_EXT1,
-		.flags	= IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };

@@ -48,6 +53,7 @@ static struct platform_device r8a66597_usb_host_device = {
 	.dev = {
 		.dma_mask		= NULL,		/* don't use dma */
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &r8a66597_data,
 	},
 	.num_resources	= ARRAY_SIZE(r8a66597_usb_host_resources),
 	.resource	= r8a66597_usb_host_resources,
-- 
1.5.5



From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 09:33:11 +0000
Subject: [PATCH v2] sh: add platform data for r8a66597-hcd in setup-sh7366
Message-Id: <4A1BB757.6080001@renesas.com>
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

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 93ecf8e..bdc95f0 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -15,6 +15,7 @@
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
 #include <linux/sh_cmt.h>
+#include <linux/usb/r8a66597.h>
 #include <asm/clock.h>

 static struct resource iic_resources[] = {
@@ -38,18 +39,20 @@ static struct platform_device iic_device = {
 	.resource       = iic_resources,
 };

+static struct r8a66597_platdata r8a66597_data = {
+	/* This set zero to all members */
+};
+
 static struct resource usb_host_resources[] = {
 	[0] = {
-		.name   = "r8a66597_hcd",
 		.start  = 0xa4d80000,
 		.end    = 0xa4d800ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.name   = "r8a66597_hcd",
 		.start  = 65,
 		.end    = 65,
-		.flags  = IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };

@@ -59,6 +62,7 @@ static struct platform_device usb_host_device = {
 	.dev = {
 		.dma_mask		= NULL,
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &r8a66597_data,
 	},
 	.num_resources	= ARRAY_SIZE(usb_host_resources),
 	.resource	= usb_host_resources,
-- 
1.5.5




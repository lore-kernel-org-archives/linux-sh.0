From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 09:33:14 +0000
Subject: [PATCH v2] sh: add platform data for r8a66597-hcd in setup-sh7723
Message-Id: <4A1BB75A.70506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A1BB757.6080001@renesas.com>
In-Reply-To: <4A1BB757.6080001@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

and remove redundant parameter for r8a66597-hcd.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 This patch depends on the following patch.
 http://marc.info/?l=linux-usb&m4332990308291&w=2

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index a800466..6341915 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -14,6 +14,7 @@
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
 #include <linux/sh_cmt.h>
+#include <linux/usb/r8a66597.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>

@@ -207,9 +208,12 @@ static struct platform_device rtc_device = {
 	.resource	= rtc_resources,
 };

+static struct r8a66597_platdata r8a66597_data = {
+	/* This set zero to all members */
+};
+
 static struct resource sh7723_usb_host_resources[] = {
 	[0] = {
-		.name	= "r8a66597_hcd",
 		.start	= 0xa4d80000,
 		.end	= 0xa4d800ff,
 		.flags	= IORESOURCE_MEM,
@@ -217,7 +221,7 @@ static struct resource sh7723_usb_host_resources[] = {
 	[1] = {
 		.start	= 65,
 		.end	= 65,
-		.flags	= IORESOURCE_IRQ,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
 	},
 };

@@ -227,6 +231,7 @@ static struct platform_device sh7723_usb_host_device = {
 	.dev = {
 		.dma_mask		= NULL,         /*  not use dma */
 		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &r8a66597_data,
 	},
 	.num_resources	= ARRAY_SIZE(sh7723_usb_host_resources),
 	.resource	= sh7723_usb_host_resources,
-- 
1.5.5



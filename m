From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 26 Sep 2011 08:43:35 +0000
Subject: [PATCH 2/2] sh: add platform_device for USB function in board-sh7757lcr
Message-Id: <4E803B37.5040909@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch depends on the following patch:
  - usb: r8a66597-udc: add support for SUDMAC

 arch/sh/boards/board-sh7757lcr.c |   39 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 8e6f9d7..dd2c8c6 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -18,6 +18,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/usb/r8a66597.h>
 #include <cpu/sh7757.h>
 #include <asm/sh_eth.h>
 #include <asm/heartbeat.h>
@@ -317,6 +318,43 @@ static struct platform_device riic3_device = {
 	},
 };

+static struct r8a66597_platdata usb0_data = {
+	.on_chip = 1,
+	.buswait = 5,
+	.sudmac = 1,
+};
+
+static struct resource usb0_resources[] = {
+	[0] = {
+		.start	= 0xfe450000,
+		.end	= 0xfe4501ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 50,
+		.end	= 50,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name	= "sudmac",
+		.start	= 0xfe451000,
+		.end	= 0xfe4517ff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device usb0_device = {
+	.name		= "r8a66597_udc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &usb0_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb0_resources),
+	.resource	= usb0_resources,
+};
+
 static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&heartbeat_device,
 	&sh7757_eth0_device,
@@ -327,6 +365,7 @@ static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&sdhi_device,
 	&riic2_device,
 	&riic3_device,
+	&usb0_device,
 };

 static struct flash_platform_data spi_flash_data = {
-- 
1.7.1

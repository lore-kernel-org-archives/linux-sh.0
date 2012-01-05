From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Jan 2012 05:08:12 +0000
Subject: [PATCH] sh: add platform_device for renesas_usbhs in board-sh7757lcr
Message-Id: <4F05303C.9070505@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |   39 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 895e337..0838154 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -19,6 +19,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
+#include <linux/usb/renesas_usbhs.h>
 #include <cpu/sh7757.h>
 #include <asm/heartbeat.h>

@@ -264,6 +265,43 @@ static struct platform_device sdhi_device = {
 	},
 };

+static int usbhs0_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+static struct renesas_usbhs_platform_info usb0_data = {
+	.platform_callback = {
+		.get_id = usbhs0_get_id,
+	},
+	.driver_param = {
+		.buswait_bwait = 5,
+	}
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
+};
+
+static struct platform_device usb0_device = {
+	.name		= "renesas_usbhs",
+	.id		= 0,
+	.dev = {
+		.platform_data		= &usb0_data,
+	},
+	.num_resources	= ARRAY_SIZE(usb0_resources),
+	.resource	= usb0_resources,
+};
+
 static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&heartbeat_device,
 	&sh7757_eth0_device,
@@ -272,6 +310,7 @@ static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&sh7757_eth_giga1_device,
 	&sh_mmcif_device,
 	&sdhi_device,
+	&usb0_device,
 };

 static struct flash_platform_data spi_flash_data = {
-- 
1.7.1

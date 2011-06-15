From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 15 Jun 2011 06:16:35 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: tidyup usbhs driver settings
Message-Id: <w3p8vt362m4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

- usb0 pipe is same as default. own pipe config is not needed
- usb1 lost get_id function

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1037bd2..7e1d375 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -629,19 +629,6 @@ static void usbhs0_hardware_exit(struct platform_device *pdev)
 	cancel_delayed_work_sync(&priv->work);
 }
 
-static u32 usbhs0_pipe_cfg[] = {
-	USB_ENDPOINT_XFER_CONTROL,
-	USB_ENDPOINT_XFER_ISOC,
-	USB_ENDPOINT_XFER_ISOC,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_INT,
-	USB_ENDPOINT_XFER_INT,
-	USB_ENDPOINT_XFER_INT,
-	USB_ENDPOINT_XFER_BULK,
-};
-
 static struct usbhs_private usbhs0_private = {
 	.usbcrcaddr	= 0xe605810c,		/* USBCR2 */
 	.info = {
@@ -654,8 +641,6 @@ static struct usbhs_private usbhs0_private = {
 		},
 		.driver_param = {
 			.buswait_bwait	= 4,
-			.pipe_type	= usbhs0_pipe_cfg,
-			.pipe_size	= ARRAY_SIZE(usbhs0_pipe_cfg),
 		},
 	},
 };
@@ -786,6 +771,11 @@ static void usbhs1_hardware_exit(struct platform_device *pdev)
 	free_irq(IRQ8, pdev);
 }
 
+static int usbhs1_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
 static u32 usbhs1_pipe_cfg[] = {
 	USB_ENDPOINT_XFER_CONTROL,
 	USB_ENDPOINT_XFER_ISOC,
@@ -812,6 +802,7 @@ static struct usbhs_private usbhs1_private = {
 		.platform_callback = {
 			.hardware_init	= usbhs1_hardware_init,
 			.hardware_exit	= usbhs1_hardware_exit,
+			.get_id		= usbhs1_get_id,
 			.phy_reset	= usbhs_phy_reset,
 			.get_vbus	= usbhs_get_vbus,
 		},
-- 
1.7.4.1


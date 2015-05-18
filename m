From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 18 May 2015 11:04:14 +0000
Subject: [PATCH v2 1/2] usb: renesas_usbhs: Change USBHS_TYPE_R8A779x to USBHS_TYPE_RCAR_GEN2
Message-Id: <1431947055-4324-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431947055-4324-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1431947055-4324-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the HSUSB controllers of R-Car Gen2 are the same specification
(they have 16 pipes and usb-dmac), this patch changes USBHS_TYPE_R8A7790
and USBHS_TYPE_R8A7791 to USBHS_TYPE_RCAR_GEN2.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 15 ++++-----------
 include/linux/usb/renesas_usbhs.h  |  3 +--
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 0f7e850..b56bb9d 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -466,11 +466,11 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
 static const struct of_device_id usbhs_of_match[] = {
 	{
 		.compatible = "renesas,usbhs-r8a7790",
-		.data = (void *)USBHS_TYPE_R8A7790,
+		.data = (void *)USBHS_TYPE_RCAR_GEN2,
 	},
 	{
 		.compatible = "renesas,usbhs-r8a7791",
-		.data = (void *)USBHS_TYPE_R8A7791,
+		.data = (void *)USBHS_TYPE_RCAR_GEN2,
 	},
 	{ },
 };
@@ -497,14 +497,8 @@ static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
 	if (gpio > 0)
 		dparam->enable_gpio = gpio;
 
-	switch (dparam->type) {
-	case USBHS_TYPE_R8A7790:
-	case USBHS_TYPE_R8A7791:
+	if (dparam->type = USBHS_TYPE_RCAR_GEN2)
 		dparam->has_usb_dmac = 1;
-		break;
-	default:
-		break;
-	}
 
 	return info;
 }
@@ -559,8 +553,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	       sizeof(struct renesas_usbhs_driver_param));
 
 	switch (priv->dparam.type) {
-	case USBHS_TYPE_R8A7790:
-	case USBHS_TYPE_R8A7791:
+	case USBHS_TYPE_RCAR_GEN2:
 		priv->pfunc = usbhs_rcar2_ops;
 		if (!priv->dparam.pipe_type) {
 			priv->dparam.pipe_type = usbhsc_new_pipe_type;
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index f06529c..3dd5a78 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -169,8 +169,7 @@ struct renesas_usbhs_driver_param {
 #define USBHS_USB_DMAC_XFER_SIZE	32	/* hardcode the xfer size */
 };
 
-#define USBHS_TYPE_R8A7790 1
-#define USBHS_TYPE_R8A7791 2
+#define USBHS_TYPE_RCAR_GEN2	1
 
 /*
  * option:
-- 
1.9.1


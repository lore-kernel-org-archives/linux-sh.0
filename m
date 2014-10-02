From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Oct 2014 08:02:32 +0000
Subject: [PATCH 1/2] usb: renesas_usbhs: rename phy to usb_phy in usbhs_priv
Message-Id: <1412236953-1084-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To support a generic phy driver in this driver later, this patch
renames "struct usb_phy *phy" to "struct usb_phy *usb_phy".

This patch also cleans up this code.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.h |    2 +-
 drivers/usb/renesas_usbhs/rcar2.c  |   48 +++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index a7996da..e0d53c5 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -269,7 +269,7 @@ struct usbhs_priv {
 	 */
 	struct usbhs_fifo_info fifo_info;
 
-	struct usb_phy *phy;
+	struct usb_phy *usb_phy;
 };
 
 /*
diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
index e6b9dcc..485b889 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -20,25 +20,28 @@
 static int usbhs_rcar2_hardware_init(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
-	struct usb_phy *phy;
 
-	phy = usb_get_phy_dev(&pdev->dev, 0);
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
+	if (IS_ENABLED(CONFIG_USB_PHY)) {
+		struct usb_phy *usb_phy = usb_get_phy_dev(&pdev->dev, 0);
 
-	priv->phy = phy;
-	return 0;
+		if (IS_ERR(usb_phy))
+			return PTR_ERR(usb_phy);
+
+		priv->usb_phy = usb_phy;
+		return 0;
+	}
+
+	return -ENXIO;
 }
 
 static int usbhs_rcar2_hardware_exit(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
-	if (!priv->phy)
-		return 0;
-
-	usb_put_phy(priv->phy);
-	priv->phy = NULL;
+	if (priv->usb_phy) {
+		usb_put_phy(priv->usb_phy);
+		priv->usb_phy = NULL;
+	}
 
 	return 0;
 }
@@ -47,21 +50,22 @@ static int usbhs_rcar2_power_ctrl(struct platform_device *pdev,
 				void __iomem *base, int enable)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
+	int retval = -ENODEV;
 
-	if (!priv->phy)
-		return -ENODEV;
+	if (priv->usb_phy) {
+		if (enable) {
+			retval = usb_phy_init(priv->usb_phy);
 
-	if (enable) {
-		int retval = usb_phy_init(priv->phy);
-
-		if (!retval)
-			retval = usb_phy_set_suspend(priv->phy, 0);
-		return retval;
+			if (!retval)
+				retval = usb_phy_set_suspend(priv->usb_phy, 0);
+		} else {
+			usb_phy_set_suspend(priv->usb_phy, 1);
+			usb_phy_shutdown(priv->usb_phy);
+			retval = 0;
+		}
 	}
 
-	usb_phy_set_suspend(priv->phy, 1);
-	usb_phy_shutdown(priv->phy);
-	return 0;
+	return retval;
 }
 
 static int usbhs_rcar2_get_id(struct platform_device *pdev)
-- 
1.7.9.5


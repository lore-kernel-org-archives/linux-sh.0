From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 03:43:04 +0000
Subject: [PATCH v2 1/3] usb: renesas_usbhs: rename phy to usb_phy in usbhs_priv
Message-Id: <1412653386-5856-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To support a generic phy driver in this driver later, this patch
renames "struct usb_phy *phy" to "struct usb_phy *usb_phy".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.h |    2 +-
 drivers/usb/renesas_usbhs/rcar2.c  |   26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

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
index e6b9dcc..f264cad 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -20,13 +20,13 @@
 static int usbhs_rcar2_hardware_init(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
-	struct usb_phy *phy;
+	struct usb_phy *usb_phy;
 
-	phy = usb_get_phy_dev(&pdev->dev, 0);
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
+	usb_phy = usb_get_phy_dev(&pdev->dev, 0);
+	if (IS_ERR(usb_phy))
+		return PTR_ERR(usb_phy);
 
-	priv->phy = phy;
+	priv->usb_phy = usb_phy;
 	return 0;
 }
 
@@ -34,11 +34,11 @@ static int usbhs_rcar2_hardware_exit(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
-	if (!priv->phy)
+	if (!priv->usb_phy)
 		return 0;
 
-	usb_put_phy(priv->phy);
-	priv->phy = NULL;
+	usb_put_phy(priv->usb_phy);
+	priv->usb_phy = NULL;
 
 	return 0;
 }
@@ -48,19 +48,19 @@ static int usbhs_rcar2_power_ctrl(struct platform_device *pdev,
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
-	if (!priv->phy)
+	if (!priv->usb_phy)
 		return -ENODEV;
 
 	if (enable) {
-		int retval = usb_phy_init(priv->phy);
+		int retval = usb_phy_init(priv->usb_phy);
 
 		if (!retval)
-			retval = usb_phy_set_suspend(priv->phy, 0);
+			retval = usb_phy_set_suspend(priv->usb_phy, 0);
 		return retval;
 	}
 
-	usb_phy_set_suspend(priv->phy, 1);
-	usb_phy_shutdown(priv->phy);
+	usb_phy_set_suspend(priv->usb_phy, 1);
+	usb_phy_shutdown(priv->usb_phy);
 	return 0;
 }
 
-- 
1.7.9.5


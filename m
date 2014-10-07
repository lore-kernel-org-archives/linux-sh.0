From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 03:43:05 +0000
Subject: [PATCH v2 2/3] usb: renesas_usbhs: clean up rcar2.c to support a generic PHY
Message-Id: <1412653386-5856-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To support both usb PHY and generic PHY, this patch cleans up rcar2.c.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/rcar2.c |   48 ++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
index f264cad..485b889 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -20,25 +20,28 @@
 static int usbhs_rcar2_hardware_init(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
-	struct usb_phy *usb_phy;
 
-	usb_phy = usb_get_phy_dev(&pdev->dev, 0);
-	if (IS_ERR(usb_phy))
-		return PTR_ERR(usb_phy);
+	if (IS_ENABLED(CONFIG_USB_PHY)) {
+		struct usb_phy *usb_phy = usb_get_phy_dev(&pdev->dev, 0);
 
-	priv->usb_phy = usb_phy;
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
 
-	if (!priv->usb_phy)
-		return 0;
-
-	usb_put_phy(priv->usb_phy);
-	priv->usb_phy = NULL;
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
 
-	if (!priv->usb_phy)
-		return -ENODEV;
+	if (priv->usb_phy) {
+		if (enable) {
+			retval = usb_phy_init(priv->usb_phy);
 
-	if (enable) {
-		int retval = usb_phy_init(priv->usb_phy);
-
-		if (!retval)
-			retval = usb_phy_set_suspend(priv->usb_phy, 0);
-		return retval;
+			if (!retval)
+				retval = usb_phy_set_suspend(priv->usb_phy, 0);
+		} else {
+			usb_phy_set_suspend(priv->usb_phy, 1);
+			usb_phy_shutdown(priv->usb_phy);
+			retval = 0;
+		}
 	}
 
-	usb_phy_set_suspend(priv->usb_phy, 1);
-	usb_phy_shutdown(priv->usb_phy);
-	return 0;
+	return retval;
 }
 
 static int usbhs_rcar2_get_id(struct platform_device *pdev)
-- 
1.7.9.5


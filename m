From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 20 Nov 2013 17:38:05 +0000
Subject: [PATCH 8/9] usb: phy: rcar-gen2: register using usb_add_phy_dev()
Message-Id: <1384969086-8920-9-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Allows binding of PCI USB host controllers to this phy.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index a99a695..25fdd91 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -212,8 +212,9 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 	priv->phy.init = rcar_gen2_usb_phy_init;
 	priv->phy.shutdown = rcar_gen2_usb_phy_shutdown;
 	priv->phy.set_suspend = rcar_gen2_usb_phy_set_suspend;
+	priv->phy.type = USB_PHY_TYPE_USB2;
 
-	retval = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
+	retval = usb_add_phy_dev(&priv->phy);
 	if (retval < 0) {
 		dev_err(dev, "Failed to add USB phy\n");
 		return retval;
-- 
1.8.4


From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sat, 18 Jan 2014 15:03:38 +0000
Subject: [PATCH 4/6] phy-rcar-usb-gen2: add device tree support
Message-Id: <1390057420-13226-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, "open list:USB PHY LAYER" <linux-usb@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>

Add support for the phy-rcar-gen2-usb driver to be probed from device tree.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: linux-usb@vger.kernel.org (open list:USB PHY LAYER)
Cc: linux-sh@vger.kernel.org (open list:ARM/SHMOBILE ARM...)
Cc: Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM...)
Cc: Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...)
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index db3ab34..906b74b 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/spinlock.h>
 #include <linux/usb/otg.h>
 
@@ -167,8 +168,15 @@ out:
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
+	{ .compatible = "renesas,usb-phy-r8a7790", },
+	{ .compatible = "renesas,rcar-gen2-usb-phy", },
+	{ },
+};
+
 static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct rcar_gen2_phy_platform_data *pdata;
 	struct rcar_gen2_usb_phy_priv *priv;
@@ -177,8 +185,9 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int retval;
 
+	of_id = of_match_device(rcar_gen2_usb_phy_ofmatch, &pdev->dev);
 	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
+	if (!pdata && !of_id) {
 		dev_err(dev, "No platform data\n");
 		return -EINVAL;
 	}
@@ -203,16 +212,31 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->lock);
 	priv->clk = clk;
 	priv->base = base;
-	priv->ugctrl2 = pdata->chan0_pci ?
-			USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
-	priv->ugctrl2 |= pdata->chan2_pci ?
-			USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
 	priv->phy.dev = dev;
 	priv->phy.label = dev_name(dev);
 	priv->phy.init = rcar_gen2_usb_phy_init;
 	priv->phy.shutdown = rcar_gen2_usb_phy_shutdown;
 	priv->phy.set_suspend = rcar_gen2_usb_phy_set_suspend;
 
+	if (of_id) {
+		int len = 0;
+
+		if (of_get_property(dev->of_node, "renesas,usb0-hs", &len))
+			priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
+		else
+			priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
+
+		if (of_get_property(dev->of_node, "renesas,usb2-ss", &len))
+			priv->ugctrl2 |= USBHS_UGCTRL2_USB2_SS;
+		else
+			priv->ugctrl2 |= USBHS_UGCTRL2_USB2_PCI;
+	} else {
+		priv->ugctrl2 = pdata->chan0_pci ?
+			USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
+		priv->ugctrl2 |= pdata->chan2_pci ?
+			USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
+	}
+
 	retval = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
 	if (retval < 0) {
 		dev_err(dev, "Failed to add USB phy\n");
@@ -236,6 +260,7 @@ static int rcar_gen2_usb_phy_remove(struct platform_device *pdev)
 static struct platform_driver rcar_gen2_usb_phy_driver = {
 	.driver = {
 		.name = "usb_phy_rcar_gen2",
+		.of_match_table = rcar_gen2_usb_phy_ofmatch,
 	},
 	.probe = rcar_gen2_usb_phy_probe,
 	.remove = rcar_gen2_usb_phy_remove,
-- 
1.8.5.2


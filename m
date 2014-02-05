From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:08 +0000
Subject: [PATCH 05/11] phy-rcar-usb-gen2: add device tree support
Message-Id: <1391595554-20640-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the phy-rcar-gen2-usb driver to be probed from device tree.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Fixes from v2:
	- fix missing of_if patch
(I clearly should not be let near git-rebase when hungry)

Fixes from v1:
	- use of_property_reasd-bool()
	- remove unused of_id variable

Cc: linux-usb@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: devicetree@vger.kernel.org

Conflicts:
	drivers/usb/phy/phy-rcar-gen2-usb.c
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index 551e0a6..9594f1b 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/spinlock.h>
 #include <linux/usb/otg.h>
 
@@ -167,6 +168,12 @@ out:
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
 	struct device *dev = &pdev->dev;
@@ -178,7 +185,7 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 	int retval;
 
 	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
+	if (!pdata && !dev->of_node) {
 		dev_err(dev, "No platform data\n");
 		return -EINVAL;
 	}
@@ -203,16 +210,29 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
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
 
+	if (dev->of_node) {
+		if (of_property_read_bool(dev->of_node, "renesas,usb0-hs"))
+			priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
+		else
+			priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
+
+		if (of_property_read_bool(dev->of_node, "renesas,usb2-ss"))
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
 	retval = usb_add_phy_dev(&priv->phy);
 	if (retval < 0) {
 		dev_err(dev, "Failed to add USB phy\n");
@@ -236,6 +256,7 @@ static int rcar_gen2_usb_phy_remove(struct platform_device *pdev)
 static struct platform_driver rcar_gen2_usb_phy_driver = {
 	.driver = {
 		.name = "usb_phy_rcar_gen2",
+		.of_match_table = rcar_gen2_usb_phy_ofmatch,
 	},
 	.probe = rcar_gen2_usb_phy_probe,
 	.remove = rcar_gen2_usb_phy_remove,
-- 
1.8.5.3


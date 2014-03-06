From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:01:22 +0000
Subject: [PATCH 4/9] usb: phy: check for of_node when getting phy
Message-Id: <1394128887-4197-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If the PHY is specified by usb-phy handle in the device tree, then
usb_get_phy_dev() should use the device tree specified PHY. This
fixes the issue where device-tree booted Renesas SoCs fail to find
the PHY for the USB controllers.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-usb@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/phy/phy.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 8afa813..92b3c09 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -224,6 +224,29 @@ struct usb_phy *usb_get_phy_dev(struct device *dev, u8 index)
 	struct usb_phy	*phy = NULL;
 	unsigned long	flags;
 
+	if (dev->of_node) {
+		struct device_node *node;
+
+		node = of_parse_phandle(dev->of_node, "usb-phy", index);
+		if (!node) {
+			dev_dbg(dev, "failed to get %s phandle\n",
+				dev->of_node->full_name);
+			return ERR_PTR(-ENODEV);
+		}
+
+		spin_lock_irqsave(&phy_lock, flags);
+
+		phy = __of_usb_find_phy(node);
+		if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
+			phy = ERR_PTR(-EPROBE_DEFER);
+			of_node_put(node);
+			goto err0;
+		}
+
+		get_device(phy->dev);
+		goto err0;
+	}
+
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __usb_find_phy_dev(dev, &phy_bind_list, index);
-- 
1.9.0


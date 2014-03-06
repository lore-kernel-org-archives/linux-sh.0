From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:01:21 +0000
Subject: [PATCH 3/9] phy-rcar-usb-gen2: add device tree support
Message-Id: <1394128887-4197-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, sergei.shtylyov@cogentembedded.com, magnus.damn@opensource.se, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>, Felipe Balbi <balbi@ti.com>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org

Add support for the phy-rcar-gen2-usb driver to be probed from device tree.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Fixes from v2:
	- fix missed of_match_ptr()
	- fix names of channel selection booleans
	- updated and merged documentation for dt entries

Fixes from v2:
	- fix missing of_if patch

Fixes from v1:
	- use of_property_reasd-bool()
	- remove unused of_id variable

Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: devicetree@vger.kernel.org

Conflicts:
	drivers/usb/phy/phy-rcar-gen2-usb.c
---
 .../bindings/usb/renesas,rcar-gen2-usb-phy.txt     | 36 ++++++++++++++++++++++
 drivers/pci/host/pci-rcar-gen2.c                   |  1 +
 drivers/usb/phy/phy-rcar-gen2-usb.c                | 34 +++++++++++++++++---
 3 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
new file mode 100644
index 0000000..5351a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
@@ -0,0 +1,36 @@
+Renesas RCar gen2 USB PHY bindings
+----------------------------------
+
+Bindings for the USB PHY block used in some Renesas SoCs.
+
+Required properties:
+ - compatible:  "renesas,usb-phy-r8a7790" for the R8A7790 SoC
+		"renesas,usb-phy-r8a7791" for the R8A7791 SoC
+ - reg : A single region to access device registers
+ - clocks : The reference to the clock to use for this block
+ - clock-names : The name for the clock at index 0 (must be "usbhs")
+
+Optional properties:
+
+ - renesas,usb0-device: boolean, if present USB0 is connected to HS device
+			otherwise the USB0 is connected to OHCI/EHCI host.
+ - renesas,usb2-xhci: boolean, if present USB2 is connected to XHCI controller
+		      otherwise the USB2 is connected to OHCI/EHCI host.
+
+
+Example device node for SoC dtsi file:
+
+	usbphy: usbphy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clock-names = "usbhs";
+		reg = < 0x0 0xe6590100 0x0 0x100>;
+		status = "disabled";
+	};
+
+Example board file:
+
+&usbphy {
+	status = "okay";
+};
+
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 1216784..2595078 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index 388d89f..8006c3c 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/spinlock.h>
 #include <linux/usb/otg.h>
 
@@ -167,6 +168,15 @@ out:
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id rcar_gen2_usb_phy_ofmatch[] = {
+	{ .compatible = "renesas,usb-phy-r8a7790", },
+	{ .compatible = "renesas,usb-phy-r8a7791", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rcar_gen2_usb_phy_ofmatch);
+#endif
+
 static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -178,7 +188,7 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 	int retval;
 
 	pdata = dev_get_platdata(dev);
-	if (!pdata) {
+	if (!pdata && !dev->of_node) {
 		dev_err(dev, "No platform data\n");
 		return -EINVAL;
 	}
@@ -203,16 +213,29 @@ static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
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
+		if (of_property_read_bool(dev->of_node, "renesas,usb0-device"))
+			priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
+		else
+			priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
+
+		if (of_property_read_bool(dev->of_node, "renesas,usb2-xhci"))
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
@@ -236,6 +259,7 @@ static int rcar_gen2_usb_phy_remove(struct platform_device *pdev)
 static struct platform_driver rcar_gen2_usb_phy_driver = {
 	.driver = {
 		.name = "usb_phy_rcar_gen2",
+		.of_match_table = of_match_ptr(rcar_gen2_usb_phy_ofmatch),
 	},
 	.probe = rcar_gen2_usb_phy_probe,
 	.remove = rcar_gen2_usb_phy_remove,
-- 
1.9.0


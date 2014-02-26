From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 26 Feb 2014 23:13:02 +0000
Subject: [PATCH] phy-rcar-gen2-usb: add device tree support
Message-Id: <201402270312.51588.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: balbi@ti.com, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-sh@vger.kernel.org, valentine.barshak@cogentembedded.com, rob@landley.net, linux-doc@vger.kernel.org

Add support of the device tree probing for the Renesas R-Car generation 2 SoCs
documenting the device tree binding as necessary.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.

 Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt |   29 +++++++
 drivers/usb/phy/phy-rcar-gen2-usb.c                     |   64 ++++++++++++++--
 2 files changed, 85 insertions(+), 8 deletions(-)

Index: usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
=================================--- /dev/null
+++ usb/Documentation/devicetree/bindings/usb/rcar-gen2-phy.txt
@@ -0,0 +1,29 @@
+* Renesas R-Car generation 2 USB PHY
+
+This file provides information on what the device node for the R-Car generation
+2 USB PHY contains.
+
+Required properties:
+- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
+	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
+- reg: offset and length of the register block.
+- clocks: clock phandle and specifier pair.
+- clock-names: string, clock input name, must be "usbhs".
+
+Optional properties:
+- renesas,channel0-pci: boolean, specify when USB channel 0 should be connected
+			to PCI EHCI/OHCI; otherwise, it will be connected to the
+			USBHS controller.
+- renesas,channel2-pci: boolean, specify when USB channel 2 should be connected
+			to PCI EHCI/OHCI; otherwise, it will be connected to the
+			USBSS controller (xHCI).
+
+Example (Lager board):
+
+	usb-phy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7790";
+		reg = <0 0xe6590100 0 0x100>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clock-names = "usbhs";
+		renesas,channel2-pci;
+	};
Index: usb/drivers/usb/phy/phy-rcar-gen2-usb.c
=================================--- usb.orig/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ usb/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -1,8 +1,8 @@
 /*
  * Renesas R-Car Gen2 USB phy driver
  *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Copyright (C) 2013 Cogent Embedded, Inc.
+ * Copyright (C) 2013-2014 Renesas Solutions Corp.
+ * Copyright (C) 2013-2014 Cogent Embedded, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -167,9 +168,41 @@ out:
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+#ifdef CONFIG_OF
+static struct rcar_gen2_phy_platform_data *
+rcar_gen2_usb_phy_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct rcar_gen2_phy_platform_data *pdata;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	pdata->chan0_pci = of_property_read_bool(np, "renesas,channel0-pci");
+	pdata->chan2_pci = of_property_read_bool(np, "renesas,channel2-pci");
+
+	return pdata;
+}
+
+static const struct of_device_id rcar_gen2_usb_phy_match_table[] = {
+	{ .compatible = "renesas,usb-phy-r8a7790" },
+	{ .compatible = "renesas,usb-phy-r8a7791" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rcar_gen2_usb_phy_match_table);
+#else
+static inline struct rcar_gen2_phy_platform_data *
+rcar_gen2_usb_phy_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct rcar_gen2_phy_platform_data *pdata;
 	struct rcar_gen2_usb_phy_priv *priv;
 	struct resource *res;
@@ -177,13 +210,19 @@ static int rcar_gen2_usb_phy_probe(struc
 	struct clk *clk;
 	int retval;
 
-	pdata = dev_get_platdata(dev);
+	if (np)
+		pdata = rcar_gen2_usb_phy_parse_dt(dev);
+	else
+		pdata = dev_get_platdata(dev);
 	if (!pdata) {
 		dev_err(dev, "No platform data\n");
 		return -EINVAL;
 	}
 
-	clk = devm_clk_get(dev, "usbhs");
+	if (np)
+		clk = of_clk_get_by_name(np, "usbhs");
+	else
+		clk = clk_get(dev, "usbhs");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "Can't get the clock\n");
 		return PTR_ERR(clk);
@@ -191,13 +230,16 @@ static int rcar_gen2_usb_phy_probe(struc
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (IS_ERR(base)) {
+		retval = PTR_ERR(base);
+		goto error;
+	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(dev, "Memory allocation failed\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto error;
 	}
 
 	spin_lock_init(&priv->lock);
@@ -216,12 +258,16 @@ static int rcar_gen2_usb_phy_probe(struc
 	retval = usb_add_phy_dev(&priv->phy);
 	if (retval < 0) {
 		dev_err(dev, "Failed to add USB phy\n");
-		return retval;
+		goto error;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
 	return retval;
+
+error:
+	clk_put(clk);
+	return retval;
 }
 
 static int rcar_gen2_usb_phy_remove(struct platform_device *pdev)
@@ -229,6 +275,7 @@ static int rcar_gen2_usb_phy_remove(stru
 	struct rcar_gen2_usb_phy_priv *priv = platform_get_drvdata(pdev);
 
 	usb_remove_phy(&priv->phy);
+	clk_put(priv->clk);
 
 	return 0;
 }
@@ -236,6 +283,7 @@ static int rcar_gen2_usb_phy_remove(stru
 static struct platform_driver rcar_gen2_usb_phy_driver = {
 	.driver = {
 		.name = "usb_phy_rcar_gen2",
+		.of_match_table = of_match_ptr(rcar_gen2_usb_phy_match_table),
 	},
 	.probe = rcar_gen2_usb_phy_probe,
 	.remove = rcar_gen2_usb_phy_remove,

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Oct 2015 11:38:54 +0000
Subject: [PATCH v2 2/6] usb: host: xhci-plat: add struct xhci_plat_priv
Message-Id: <1444217938-4668-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds struct xhci_plat_priv to simplify the code to match
platform specific variables. For now, this patch adds a member "type"
in the structure.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-plat.c | 66 +++++++++++++++++++++++++++-----------------
 drivers/usb/host/xhci-plat.h | 37 +++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 25 deletions(-)
 create mode 100644 drivers/usb/host/xhci-plat.h

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 890ad9d..4a974b7 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -21,6 +21,7 @@
 #include <linux/usb/xhci_pdriver.h>
 
 #include "xhci.h"
+#include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
 
@@ -48,11 +49,9 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
-	struct device_node *of_node = hcd->self.controller->of_node;
 	int ret;
 
-	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791")) {
+	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2)) {
 		ret = xhci_rcar_init_quirk(hcd);
 		if (ret)
 			return ret;
@@ -63,19 +62,49 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 
 static int xhci_plat_start(struct usb_hcd *hcd)
 {
-	struct device_node *of_node = hcd->self.controller->of_node;
-
-	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
-	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
+	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2))
 		xhci_rcar_start(hcd);
 
 	return xhci_run(hcd);
 }
 
+#ifdef CONFIG_OF
+static const struct xhci_plat_priv xhci_plat_marvell_armada = {
+	.type = XHCI_PLAT_TYPE_MARVELL_ARMADA,
+};
+
+static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
+	.type = XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
+};
+
+static const struct of_device_id usb_xhci_of_match[] = {
+	{
+		.compatible = "generic-xhci",
+	}, {
+		.compatible = "xhci-platform",
+	}, {
+		.compatible = "marvell,armada-375-xhci",
+		.data = &xhci_plat_marvell_armada,
+	}, {
+		.compatible = "marvell,armada-380-xhci",
+		.data = &xhci_plat_marvell_armada,
+	}, {
+		.compatible = "renesas,xhci-r8a7790",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+		.compatible = "renesas,xhci-r8a7791",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
+#endif
+
 static int xhci_plat_probe(struct platform_device *pdev)
 {
 	struct device_node	*node = pdev->dev.of_node;
 	struct usb_xhci_pdata	*pdata = dev_get_platdata(&pdev->dev);
+	const struct of_device_id *match;
 	const struct hc_driver	*driver;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
@@ -127,10 +156,11 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto put_hcd;
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "marvell,armada-375-xhci") ||
-	    of_device_is_compatible(pdev->dev.of_node,
-				    "marvell,armada-380-xhci")) {
+	xhci = hcd_to_xhci(hcd);
+	match = of_match_node(usb_xhci_of_match, node);
+	xhci->priv = match ? match->data : NULL;
+
+	if (xhci_plat_type_is(hcd, XHCI_PLAT_TYPE_MARVELL_ARMADA)) {
 		ret = xhci_mvebu_mbus_init_quirk(pdev);
 		if (ret)
 			goto disable_clk;
@@ -138,7 +168,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	device_wakeup_enable(hcd->self.controller);
 
-	xhci = hcd_to_xhci(hcd);
 	xhci->clk = clk;
 	xhci->main_hcd = hcd;
 	xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
@@ -249,19 +278,6 @@ static const struct dev_pm_ops xhci_plat_pm_ops = {
 #define DEV_PM_OPS	NULL
 #endif /* CONFIG_PM */
 
-#ifdef CONFIG_OF
-static const struct of_device_id usb_xhci_of_match[] = {
-	{ .compatible = "generic-xhci" },
-	{ .compatible = "xhci-platform" },
-	{ .compatible = "marvell,armada-375-xhci"},
-	{ .compatible = "marvell,armada-380-xhci"},
-	{ .compatible = "renesas,xhci-r8a7790"},
-	{ .compatible = "renesas,xhci-r8a7791"},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
-#endif
-
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
new file mode 100644
index 0000000..4479869
--- /dev/null
+++ b/drivers/usb/host/xhci-plat.h
@@ -0,0 +1,37 @@
+/*
+ * xhci-plat.h - xHCI host controller driver platform Bus Glue.
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#ifndef _XHCI_PLAT_H
+#define _XHCI_PLAT_H
+
+#include "xhci.h"	/* for hcd_to_xhci() */
+
+enum xhci_plat_type {
+	XHCI_PLAT_TYPE_MARVELL_ARMADA,
+	XHCI_PLAT_TYPE_RENESAS_RCAR_GEN2,
+};
+
+struct xhci_plat_priv {
+	enum xhci_plat_type type;
+};
+
+#define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
+
+static inline bool xhci_plat_type_is(struct usb_hcd *hcd,
+				     enum xhci_plat_type type)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (priv && priv->type = type)
+		return true;
+	else
+		return false;
+}
+#endif	/* _XHCI_PLAT_H */
-- 
1.9.1


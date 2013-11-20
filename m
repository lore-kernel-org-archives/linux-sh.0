From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 20 Nov 2013 17:38:01 +0000
Subject: [PATCH 4/9] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <1384969086-8920-5-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds RCAR Gen2 USB phy support. The driver configures
USB channels 0/2 which are shared between PCI USB hosts and
USBHS/USBSS devices. It also controls internal USBHS phy.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/usb/phy/Kconfig                         |  13 ++
 drivers/usb/phy/Makefile                        |   1 +
 drivers/usb/phy/phy-rcar-gen2-usb.c             | 248 ++++++++++++++++++++++++
 include/linux/platform_data/usb-rcar-gen2-phy.h |  22 +++
 4 files changed, 284 insertions(+)
 create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
 create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index d5589f9..c0c8cd3 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -214,6 +214,19 @@ config USB_RCAR_PHY
 	  To compile this driver as a module, choose M here: the
 	  module will be called phy-rcar-usb.
 
+config USB_RCAR_GEN2_PHY
+	tristate "Renesas R-Car Gen2 USB PHY support"
+	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
+	select USB_PHY
+	help
+	  Say Y here to add support for the Renesas R-Car Gen2 USB PHY driver.
+	  It is typically used to control internal USB PHY for USBHS,
+	  and to configure shared USB channels 0 and 2.
+	  This driver supports R8A7790 and R8A7791.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called phy-rcar-gen2-usb.
+
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
 	depends on ARM
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 2135e85..8c5b147 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_USB_MSM_OTG)		+= phy-msm-usb.o
 obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
 obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
 obj-$(CONFIG_USB_RCAR_PHY)		+= phy-rcar-usb.o
+obj-$(CONFIG_USB_RCAR_GEN2_PHY)		+= phy-rcar-gen2-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
new file mode 100644
index 0000000..a99a695
--- /dev/null
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -0,0 +1,248 @@
+/*
+ * Renesas R-Car Gen2 USB phy driver
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Cogent Embedded, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_data/usb-rcar-gen2-phy.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/usb/otg.h>
+
+struct rcar_gen2_usb_phy_priv {
+	struct usb_phy phy;
+	void __iomem *base;
+	struct clk *clk;
+	spinlock_t lock;
+	int usecount;
+	u32 ugctrl2;
+};
+
+#define usb_phy_to_priv(p) container_of(p, struct rcar_gen2_usb_phy_priv, phy)
+
+/* Low Power Status register */
+#define USBHS_LPSTS_REG			0x02
+#define USBHS_LPSTS_SUSPM		(1 << 14)
+
+/* USB General control register */
+#define USBHS_UGCTRL_REG		0x80
+#define USBHS_UGCTRL_CONNECT		(1 << 2)
+#define USBHS_UGCTRL_PLLRESET		(1 << 0)
+
+/* USB General control register 2 */
+#define USBHS_UGCTRL2_REG		0x84
+#define USBHS_UGCTRL2_USB0_PCI		(1 << 4)
+#define USBHS_UGCTRL2_USB0_HS		(3 << 4)
+#define USBHS_UGCTRL2_USB2_PCI		(0 << 31)
+#define USBHS_UGCTRL2_USB2_SS		(1 << 31)
+
+/* USB General status register */
+#define USBHS_UGSTS_REG			0x88
+#define USBHS_UGSTS_LOCK		(3 << 8)
+
+/* Enable USBHS internal phy */
+static int __rcar_gen2_usbhs_phy_enable(void __iomem *base)
+{
+	u32 val;
+	int i;
+
+	/* USBHS PHY power on */
+	val = ioread32(base + USBHS_UGCTRL_REG);
+	val &= ~USBHS_UGCTRL_PLLRESET;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+
+	val = ioread16(base + USBHS_LPSTS_REG);
+	val |= USBHS_LPSTS_SUSPM;
+	iowrite16(val, base + USBHS_LPSTS_REG);
+
+	for (i = 0; i < 20; i++) {
+		val = ioread32(base + USBHS_UGSTS_REG);
+		if ((val & USBHS_UGSTS_LOCK) = USBHS_UGSTS_LOCK) {
+			val = ioread32(base + USBHS_UGCTRL_REG);
+			val |= USBHS_UGCTRL_CONNECT;
+			iowrite32(val, base + USBHS_UGCTRL_REG);
+			return 0;
+		}
+		udelay(1);
+	}
+
+	/* Timed out waiting for the PLL lock */
+	return -ETIMEDOUT;
+}
+
+/* Disable USBHS internal phy */
+static int __rcar_gen2_usbhs_phy_disable(void __iomem *base)
+{
+	u32 val;
+
+	/* USBHS PHY power off */
+	val = ioread32(base + USBHS_UGCTRL_REG);
+	val &= ~USBHS_UGCTRL_CONNECT;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+
+	val = ioread16(base + USBHS_LPSTS_REG);
+	val &= ~USBHS_LPSTS_SUSPM;
+	iowrite16(val, base + USBHS_LPSTS_REG);
+
+	val = ioread32(base + USBHS_UGCTRL_REG);
+	val |= USBHS_UGCTRL_PLLRESET;
+	iowrite32(val, base + USBHS_UGCTRL_REG);
+	return 0;
+}
+
+/* Setup USB channels */
+static void __rcar_gen2_usb_phy_init(struct rcar_gen2_usb_phy_priv *priv)
+{
+	u32 val;
+
+	clk_prepare_enable(priv->clk);
+
+	/* Set USB channels in the USBHS UGCTRL2 register */
+	val = ioread32(priv->base);
+	val &= ~(USBHS_UGCTRL2_USB0_HS | USBHS_UGCTRL2_USB2_SS);
+	val |= priv->ugctrl2;
+	iowrite32(val, priv->base);
+}
+
+/* Shutdown USB channels */
+static void __rcar_gen2_usb_phy_shutdown(struct rcar_gen2_usb_phy_priv *priv)
+{
+	__rcar_gen2_usbhs_phy_disable(priv->base);
+	clk_disable_unprepare(priv->clk);
+}
+
+static int rcar_gen2_usb_phy_set_suspend(struct usb_phy *phy, int suspend)
+{
+	struct rcar_gen2_usb_phy_priv *priv = usb_phy_to_priv(phy);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	retval = suspend ? __rcar_gen2_usbhs_phy_disable(priv->base) :
+			   __rcar_gen2_usbhs_phy_enable(priv->base);
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return retval;
+}
+
+static int rcar_gen2_usb_phy_init(struct usb_phy *phy)
+{
+	struct rcar_gen2_usb_phy_priv *priv = usb_phy_to_priv(phy);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	/*
+	 * Enable the clock and setup USB channels
+	 * if it's the first user
+	 */
+	if (!priv->usecount++)
+		__rcar_gen2_usb_phy_init(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return 0;
+}
+
+static void rcar_gen2_usb_phy_shutdown(struct usb_phy *phy)
+{
+	struct rcar_gen2_usb_phy_priv *priv = usb_phy_to_priv(phy);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (!priv->usecount) {
+		dev_warn(phy->dev, "Trying to disable phy with 0 usecount\n");
+		goto out;
+	}
+
+	/* Disable everything if it's the last user */
+	if (!--priv->usecount)
+		__rcar_gen2_usb_phy_shutdown(priv);
+out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen2_phy_platform_data *pdata;
+	struct rcar_gen2_usb_phy_priv *priv;
+	struct resource *res;
+	void __iomem *base;
+	struct clk *clk;
+	int retval;
+
+	pdata = dev_get_platdata(&pdev->dev);
+	if (!pdata) {
+		dev_err(dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	clk = devm_clk_get(&pdev->dev, "usbhs");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Can't get the clock\n");
+		return PTR_ERR(clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(dev, "Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&priv->lock);
+	priv->clk = clk;
+	priv->base = base;
+	priv->ugctrl2 = pdata->chan0_pci ?
+			USBHS_UGCTRL2_USB0_PCI : USBHS_UGCTRL2_USB0_HS;
+	priv->ugctrl2 |= pdata->chan2_pci ?
+			USBHS_UGCTRL2_USB2_PCI : USBHS_UGCTRL2_USB2_SS;
+	priv->phy.dev = dev;
+	priv->phy.label = dev_name(dev);
+	priv->phy.init = rcar_gen2_usb_phy_init;
+	priv->phy.shutdown = rcar_gen2_usb_phy_shutdown;
+	priv->phy.set_suspend = rcar_gen2_usb_phy_set_suspend;
+
+	retval = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
+	if (retval < 0) {
+		dev_err(dev, "Failed to add USB phy\n");
+		return retval;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return retval;
+}
+
+static int rcar_gen2_usb_phy_remove(struct platform_device *pdev)
+{
+	struct rcar_gen2_usb_phy_priv *priv = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&priv->phy);
+
+	return 0;
+}
+
+static struct platform_driver rcar_gen2_usb_phy_driver = {
+	.driver = {
+		.name = "usb_phy_rcar_gen2",
+	},
+	.probe = rcar_gen2_usb_phy_probe,
+	.remove = rcar_gen2_usb_phy_remove,
+};
+
+module_platform_driver(rcar_gen2_usb_phy_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Renesas R-Car Gen2 USB phy");
+MODULE_AUTHOR("Valentine Barshak <valentine.barshak@cogentembedded.com>");
diff --git a/include/linux/platform_data/usb-rcar-gen2-phy.h b/include/linux/platform_data/usb-rcar-gen2-phy.h
new file mode 100644
index 0000000..dd3ba46
--- /dev/null
+++ b/include/linux/platform_data/usb-rcar-gen2-phy.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Cogent Embedded, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __USB_RCAR_GEN2_PHY_H
+#define __USB_RCAR_GEN2_PHY_H
+
+#include <linux/types.h>
+
+struct rcar_gen2_phy_platform_data {
+	/* USB channel 0 configuration */
+	bool chan0_pci:1;	/* true: PCI USB host 0, false: USBHS */
+	/* USB channel 2 configuration */
+	bool chan2_pci:1;	/* true: PCI USB host 2, false: USBSS */
+};
+
+#endif
-- 
1.8.4


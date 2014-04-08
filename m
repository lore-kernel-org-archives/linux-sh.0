From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Apr 2014 21:02:02 +0000
Subject: [PATCH] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <201404090102.03074.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-doc@vger.kernel.org, rdunlap@infradead.org, grant.likely@linaro.org

This PHY, though formally being a part of Renesas USBHS controller, contains the
UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls them
channels) to the different USB controllers: channel 0 can be connected to either
PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI EHCI/OHCI
or xHCI controllers.

This is a new driver for this USB PHY currently already supported under drivers/
usb/phy/. The reason for writing the new driver was the requirement that the
multiplexing of USB channels to the controller be dynamic, depending on what
USB drivers are loaded,  rather than static as provided by the old driver.	
The infrastructure provided by drivers/phy/phy-core.c seems to fit that purpose
ideally. The new driver only supports device tree probing for now.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt |   35 +
 drivers/phy/Kconfig                                     |    7 
 drivers/phy/Makefile                                    |    1 
 drivers/phy/phy-rcar-gen2.c                             |  287 ++++++++++++++++
 4 files changed, 330 insertions(+)

Index: renesas/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
=================================--- /dev/null
+++ renesas/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -0,0 +1,35 @@
+* Renesas R-Car generation 2 USB PHY
+
+This file provides information on what the device node for the R-Car generation
+2 USB PHY contains.
+
+Required properties:
+- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
+	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
+- reg: offset and length of the register block.
+- #phy-cells: see phy-bindings.txt in the same directory, must be 2.
+- clocks: clock phandle and specifier pair.
+- clock-names: string, clock input name, must be "usbhs".
+
+The phandle's first argument in the PHY specifier identifies the USB channel,
+the second one is the USB controller selector and depends on the first:
+
++-----------+---------------+---------------+
+|\ Selector |               |               |
++ --------- +       0       |       1       |
+| Channel  \|               |               |
++-----------+---------------+---------------+
+| 0         | PCI EHCI/OHCI | HS-USB        |
+| 1         | PCI EHCI/OHCI | PCI EHCI/OHCI |
+| 2         | PCI EHCI/OHCI | xHCI          |
++-----------+---------------+---------------+
+
+Example (Lager board):
+
+	usb-phy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7790";
+		reg = <0 0xe6590100 0 0x100>;
+		#phy-cells = <2>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clock-names = "usbhs";
+	};
Index: renesas/drivers/phy/Kconfig
=================================--- renesas.orig/drivers/phy/Kconfig
+++ renesas/drivers/phy/Kconfig
@@ -28,6 +28,13 @@ config PHY_MVEBU_SATA
 	depends on OF
 	select GENERIC_PHY
 
+config PHY_RCAR_GEN2
+	tristate "Renesas R-Car generation 2 USB PHY driver"
+	depends on ARCH_SHMOBILE
+	depends on GENERIC_PHY
+	help
+	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
+
 config OMAP_USB2
 	tristate "OMAP USB2 PHY Driver"
 	depends on ARCH_OMAP2PLUS
Index: renesas/drivers/phy/Makefile
=================================--- renesas.orig/drivers/phy/Makefile
+++ renesas/drivers/phy/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy
 obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
 obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
+obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
Index: renesas/drivers/phy/phy-rcar-gen2.c
=================================--- /dev/null
+++ renesas/drivers/phy/phy-rcar-gen2.c
@@ -0,0 +1,287 @@
+/*
+ * Renesas R-Car Gen2 PHY driver
+ *
+ * Copyright (C) 2014 Renesas Solutions Corp.
+ * Copyright (C) 2014 Cogent Embedded, Inc.
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
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define USBHS_LPSTS			0x02
+#define USBHS_UGCTRL			0x80
+#define USBHS_UGCTRL2			0x84
+#define USBHS_UGSTS			0x88
+
+/* Low Power Status register (LPSTS) */
+#define USBHS_LPSTS_SUSPM		0x4000
+
+/* USB General control register (UGCTRL) */
+#define USBHS_UGCTRL_CONNECT		0x00000004
+#define USBHS_UGCTRL_PLLRESET		0x00000001
+
+/* USB General control register 2 (UGCTRL2) */
+#define USBHS_UGCTRL2_USB2SEL		0x80000000
+#define USBHS_UGCTRL2_USB2SEL_PCI	0x00000000
+#define USBHS_UGCTRL2_USB2SEL_USB30	0x80000000
+#define USBHS_UGCTRL2_USB0SEL		0x00000030
+#define USBHS_UGCTRL2_USB0SEL_PCI	0x00000010
+#define USBHS_UGCTRL2_USB0SEL_HS_USB	0x00000030
+
+/* USB General status register (UGSTS) */
+#define USBHS_UGSTS_LOCK		0x00000300	/* 0x00000003? */
+
+#define	NUM_USB_CHANNELS	3
+
+struct rcar_gen2_phy {
+	struct phy *phy;
+	struct rcar_gen2_phy_driver *drv;
+	u32 select_mask;
+	u32 select_value;
+};
+
+struct rcar_gen2_phy_driver {
+	void __iomem *base;
+	struct clk *clk;
+	spinlock_t lock;
+	struct rcar_gen2_phy phys[NUM_USB_CHANNELS][2];
+};
+
+static int rcar_gen2_phy_init(struct phy *p)
+{
+	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
+	struct rcar_gen2_phy_driver *drv = phy->drv;
+	unsigned long flags;
+	u32 ugctrl2;
+
+	if (phy->select_mask) {
+		clk_prepare_enable(drv->clk);
+
+		spin_lock_irqsave(&drv->lock, flags);
+		ugctrl2 = readl(drv->base + USBHS_UGCTRL2);
+		ugctrl2 &= ~phy->select_mask;
+		ugctrl2 |= phy->select_value;
+		writel(ugctrl2, drv->base + USBHS_UGCTRL2);
+		spin_unlock_irqrestore(&drv->lock, flags);
+	}
+
+	return 0;
+}
+
+static int rcar_gen2_phy_exit(struct phy *p)
+{
+	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
+
+	if (phy->select_mask)
+		clk_disable_unprepare(phy->drv->clk);
+
+	return 0;
+}
+
+static int rcar_gen2_usbhs_phy_power_on(struct phy *p)
+{
+	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
+	struct rcar_gen2_phy_driver *drv = phy->drv;
+	void __iomem *base = drv->base;
+	unsigned long flags;
+	u32 value;
+	int err = 0, i;
+
+	spin_lock_irqsave(&drv->lock, flags);
+
+	/* Power on USBHS PHY */
+	value = readl(base + USBHS_UGCTRL);
+	value &= ~USBHS_UGCTRL_PLLRESET;
+	writel(value, base + USBHS_UGCTRL);
+
+	value = ioread16(base + USBHS_LPSTS);
+	value |= USBHS_LPSTS_SUSPM;
+	iowrite16(value, base + USBHS_LPSTS);
+
+	for (i = 0; i < 20; i++) {
+		value = readl(base + USBHS_UGSTS);
+		if ((value & USBHS_UGSTS_LOCK) = USBHS_UGSTS_LOCK) {
+			value = readl(base + USBHS_UGCTRL);
+			value |= USBHS_UGCTRL_CONNECT;
+			writel(value, base + USBHS_UGCTRL);
+			goto out;
+		}
+		udelay(1);
+	}
+
+	/* Timed out waiting for the PLL lock */
+	err = -ETIMEDOUT;
+
+out:
+	spin_unlock_irqrestore(&drv->lock, flags);
+
+	return err;
+}
+
+static int rcar_gen2_usbhs_phy_power_off(struct phy *p)
+{
+	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
+	struct rcar_gen2_phy_driver *drv = phy->drv;
+	void __iomem *base = drv->base;
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&drv->lock, flags);
+
+	/* Power off USBHS PHY */
+	value = readl(base + USBHS_UGCTRL);
+	value &= ~USBHS_UGCTRL_CONNECT;
+	writel(value, base + USBHS_UGCTRL);
+
+	value = ioread16(base + USBHS_LPSTS);
+	value &= ~USBHS_LPSTS_SUSPM;
+	iowrite16(value, base + USBHS_LPSTS);
+
+	value = readl(base + USBHS_UGCTRL);
+	value |= USBHS_UGCTRL_PLLRESET;
+	writel(value, base + USBHS_UGCTRL);
+
+	spin_unlock_irqrestore(&drv->lock, flags);
+
+	return 0;
+}
+
+static struct phy_ops rcar_gen2_phy_ops = {
+	.init		= rcar_gen2_phy_init,
+	.exit		= rcar_gen2_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy_ops rcar_gen2_usbhs_phy_ops = {
+	.init		= rcar_gen2_phy_init,
+	.exit		= rcar_gen2_phy_exit,
+	.power_on	= rcar_gen2_usbhs_phy_power_on,
+	.power_off	= rcar_gen2_usbhs_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static const struct of_device_id rcar_gen2_phy_match_table[] = {
+	{ .compatible = "renesas,usb-phy-r8a7790" },
+	{ .compatible = "renesas,usb-phy-r8a7791" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rcar_gen2_phy_match_table);
+
+static struct phy *rcar_gen2_phy_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	struct rcar_gen2_phy_driver *drv;
+
+	drv = dev_get_drvdata(dev);
+	if (!drv)
+		return ERR_PTR(-EINVAL);
+
+	if (args->args[0] >= NUM_USB_CHANNELS || args->args[1] >= 2)
+		return ERR_PTR(-ENODEV);
+
+	return drv->phys[args->args[0]][args->args[1]].phy;
+}
+
+static int rcar_gen2_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rcar_gen2_phy_driver *drv;
+	struct phy_provider *provider;
+	struct resource *res;
+	void __iomem *base;
+	struct clk *clk;
+	int i, j;
+
+	if (!dev->of_node) {
+		dev_err(dev, "This driver is required to be instantiated from device tree\n");
+		return -EINVAL;
+	}
+
+	clk = devm_clk_get(dev, "usbhs");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "Can't get USBHS clock\n");
+		return PTR_ERR(clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	spin_lock_init(&drv->lock);
+
+	drv->clk = clk;
+	drv->base = base;
+
+	drv->phys[0][0].select_mask  = USBHS_UGCTRL2_USB0SEL;
+	drv->phys[0][0].select_value = USBHS_UGCTRL2_USB0SEL_PCI;
+	drv->phys[0][1].select_mask  = USBHS_UGCTRL2_USB0SEL;
+	drv->phys[0][1].select_value = USBHS_UGCTRL2_USB0SEL_HS_USB;
+	drv->phys[2][0].select_mask  = USBHS_UGCTRL2_USB2SEL;
+	drv->phys[2][0].select_value = USBHS_UGCTRL2_USB2SEL_PCI;
+	drv->phys[2][1].select_mask  = USBHS_UGCTRL2_USB2SEL;
+	drv->phys[2][1].select_value = USBHS_UGCTRL2_USB2SEL_USB30;
+
+	for (i = 0; i < NUM_USB_CHANNELS; i++) {
+		for (j = 0; j < 2; j++) {
+			struct rcar_gen2_phy *phy = &drv->phys[i][j];
+			struct phy_ops *ops = &rcar_gen2_phy_ops;
+
+			/*
+			 * Override ops for the HS-USB controller which needs
+			 * to be powered on/off.
+			 */
+			if (i = 0 && j = 1)
+				ops = &rcar_gen2_usbhs_phy_ops;
+
+			phy->phy = devm_phy_create(dev, ops, NULL);
+			if (IS_ERR(phy->phy)) {
+				dev_err(dev,
+					"Failed to create PHY for channel %d\n",
+					i);
+				return PTR_ERR(phy->phy);
+			}
+
+			phy->drv = drv;
+			phy_set_drvdata(phy->phy, phy);
+		}
+	}
+
+	provider = devm_of_phy_provider_register(dev, rcar_gen2_phy_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "Failed to register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	dev_set_drvdata(dev, drv);
+
+	return 0;
+}
+
+static struct platform_driver rcar_gen2_phy_driver = {
+	.driver = {
+		.name		= "phy_rcar_gen2",
+		.of_match_table	= rcar_gen2_phy_match_table,
+	},
+	.probe	= rcar_gen2_phy_probe,
+};
+
+module_platform_driver(rcar_gen2_phy_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Renesas R-Car Gen2 PHY");
+MODULE_AUTHOR("Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>");

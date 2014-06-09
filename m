From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Jun 2014 11:44:27 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <1599447.RVY9gPzyeE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com, grant.likely@linaro.org, devicetree@vger.kernel.org, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Saturday 24 May 2014 02:06:03 Sergei Shtylyov wrote:
> This PHY, though formally being a part of Renesas USBHS controller, contains
> the UGCTRL2 register that controls multiplexing of the USB ports (Renesas
> calls them channels) to the different USB controllers: channel 0 can be
> connected to either PCI EHCI/OHCI or USBHS controllers, channel 2 can be
> connected to PCI EHCI/OHCI or xHCI controllers.
> 
> This is a new driver for this USB PHY currently already supported under
> drivers/ usb/phy/. The reason for writing the new driver was the
> requirement that the multiplexing of USB channels to the controller be
> dynamic, depending on what USB drivers are loaded,  rather than static as
> provided by the old driver. The infrastructure provided by
> drivers/phy/phy-core.c seems to fit that purpose ideally. The new driver
> only supports device tree probing for now.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'next' branch of Kishon's 'linux-phy.git' repo.
> 
> Changes in version 4:
> - added subnodes to the USB PHY node, described their properties in the
> binding document; rewrote the probe() method to parse out PHY selection and
> UGCTRL2 mask values out of these child nodes;
> - changed NUM_USB_CHANNELS to 2, removed the former channel #1 support as we
> don't have control over it anyway;
> - refreshed the patch.
> 
> Changes in version 3:
> - removed 'rcar_gen2_usbhs_phy_ops', moving 'power_{on|off}' intializers to
>   'rcar_gen2_phy_ops' and adding a check for USBHS PHY to power_{on|off}()
>   methods;
> - renamed the power_{on|off}() methods;
> - replaced io{read|write}16() calls with {read|write}w();
> - removed the comment to '#define USBHS_UGSTS_LOCK';
> - broke the line in the dev_err() call in the probe() method;
> - moved the driver's line in the 'Makefile' before OMAP drivers.
> 
> Changes in version 2:
> - rebased the patch, resolving reject.
> 
>  Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt |   60 +++
>  drivers/phy/Kconfig                                     |    7
>  drivers/phy/Makefile                                    |    1
>  drivers/phy/phy-rcar-gen2.c                             |  288 ++++++++++++
>  4 files changed, 356 insertions(+)
> 
> Index: linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
> =================================> --- /dev/null
> +++ linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
> @@ -0,0 +1,60 @@
> +* Renesas R-Car generation 2 USB PHY
> +
> +This file provides information on what the device node for the R-Car
> generation +2 USB PHY contains.
> +
> +Required properties:
> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790
> SoC. +	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791
> SoC. +- reg: offset and length of the register block.
> +- #phy-cells: see phy-bindings.txt in the same directory, must be 2.
> +- clocks: clock phandle and specifier pair.
> +- clock-names: string, clock input name, must be "usbhs".

Is that the functional clock for the PHY ? If so, what about naming it "fck" 
(or something similar) ?

> +The phandle's first argument in the PHY specifier identifies the USB
> channel, +the second one is the USB controller selector and depends on the
> first: +
> ++-----------+---------------+---------------+
> +|\ Selector |               |               |
> ++ --------- +       0       |       1       |
> +| Channel  \|               |               |
> ++-----------+---------------+---------------+
> +| 0         | PCI EHCI/OHCI | HS-USB        |
> +| 1         | PCI EHCI/OHCI | xHCI          |
> ++-----------+---------------+---------------+
> +
> +The USB PHY device tree node should be the subnodes corresponding to the
> USB +channels and the controllers connected to them. These subnodes must
> contain the +following properties:
> +- renesas,phy-select: the first cell identifies the USB channel, the second
> cell +  is the USB controller selector; see the table above for the values.
> +- renesas,ugctrl2-masks: the first cell is the UGCTRL2 mask corresponding
> to +  the USB channel, the second cell is the UGCTRL2 value corresponding
> to the +  USB controller selected for that channel.
> +
> +Example (Lager board):
> +
> +	usb-phy@e6590100 {
> +		compatible = "renesas,usb-phy-r8a7790";
> +		reg = <0 0xe6590100 0 0x100>;
> +		#phy-cells = <2>;
> +		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
> +		clock-names = "usbhs";
> +
> +		usb-phy@0,0 {
> +			renesas,phy-select = <0 0>;
> +			renesas,ugctrl2-masks = <0x00000030 0x00000010>;
> +		};
> +		usb-phy@0,1 {
> +			renesas,phy-select = <0 1>;
> +			renesas,ugctrl2-masks = <0x00000030 0x00000030>;
> +		};
> +		usb-phy@1,0 {
> +			renesas,phy-select = <1 0>;
> +			renesas,ugctrl2-masks = <0x80000000 0x00000000>;
> +		};
> +		usb-phy@1,1 {
> +			renesas,phy-select = <1 1>;
> +			renesas,ugctrl2-masks = <0x80000000 0x80000000>;
> +		};
> +	};
> Index: linux-phy/drivers/phy/Kconfig
> =================================> --- linux-phy.orig/drivers/phy/Kconfig
> +++ linux-phy/drivers/phy/Kconfig
> @@ -31,6 +31,13 @@ config PHY_MVEBU_SATA
>  	depends on OF
>  	select GENERIC_PHY
> 
> +config PHY_RCAR_GEN2
> +	tristate "Renesas R-Car generation 2 USB PHY driver"
> +	depends on ARCH_SHMOBILE
> +	depends on GENERIC_PHY
> +	help
> +	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
> +
>  config OMAP_CONTROL_PHY
>  	tristate "OMAP CONTROL PHY Driver"
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> Index: linux-phy/drivers/phy/Makefile
> =================================> --- linux-phy.orig/drivers/phy/Makefile
> +++ linux-phy/drivers/phy/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
> +obj-$(CONFIG_PHY_RCAR_GEN2)		+= phy-rcar-gen2.o
>  obj-$(CONFIG_OMAP_CONTROL_PHY)		+= phy-omap-control.o
>  obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
> =================================> --- /dev/null
> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
> @@ -0,0 +1,288 @@
> +/*
> + * Renesas R-Car Gen2 PHY driver
> + *
> + * Copyright (C) 2014 Renesas Solutions Corp.
> + * Copyright (C) 2014 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#define USBHS_LPSTS			0x02
> +#define USBHS_UGCTRL			0x80
> +#define USBHS_UGCTRL2			0x84
> +#define USBHS_UGSTS			0x88
> +
> +/* Low Power Status register (LPSTS) */
> +#define USBHS_LPSTS_SUSPM		0x4000
> +
> +/* USB General control register (UGCTRL) */
> +#define USBHS_UGCTRL_CONNECT		0x00000004
> +#define USBHS_UGCTRL_PLLRESET		0x00000001
> +
> +/* USB General control register 2 (UGCTRL2) */
> +#define USBHS_UGCTRL2_USB2SEL		0x80000000
> +#define USBHS_UGCTRL2_USB2SEL_PCI	0x00000000
> +#define USBHS_UGCTRL2_USB2SEL_USB30	0x80000000
> +#define USBHS_UGCTRL2_USB0SEL		0x00000030
> +#define USBHS_UGCTRL2_USB0SEL_PCI	0x00000010
> +#define USBHS_UGCTRL2_USB0SEL_HS_USB	0x00000030
> +
> +/* USB General status register (UGSTS) */
> +#define USBHS_UGSTS_LOCK		0x00000300
> +
> +#define	NUM_USB_CHANNELS	2
> +
> +struct rcar_gen2_phy {
> +	struct phy *phy;
> +	struct rcar_gen2_phy_driver *drv;
> +	u32 select_mask;
> +	u32 select_value;
> +};
> +
> +struct rcar_gen2_phy_driver {
> +	void __iomem *base;
> +	struct clk *clk;
> +	spinlock_t lock;
> +	struct rcar_gen2_phy phys[NUM_USB_CHANNELS][2];
> +};
> +
> +static int rcar_gen2_phy_init(struct phy *p)
> +{
> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
> +	struct rcar_gen2_phy_driver *drv = phy->drv;
> +	unsigned long flags;
> +	u32 ugctrl2;
> +
> +	clk_prepare_enable(drv->clk);
> +
> +	spin_lock_irqsave(&drv->lock, flags);
> +	ugctrl2 = readl(drv->base + USBHS_UGCTRL2);
> +	ugctrl2 &= ~phy->select_mask;
> +	ugctrl2 |= phy->select_value;
> +	writel(ugctrl2, drv->base + USBHS_UGCTRL2);
> +	spin_unlock_irqrestore(&drv->lock, flags);
> +	return 0;
> +}
> +
> +static int rcar_gen2_phy_exit(struct phy *p)
> +{
> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
> +
> +	clk_disable_unprepare(phy->drv->clk);
> +
> +	return 0;
> +}
> +
> +static int rcar_gen2_phy_power_on(struct phy *p)
> +{
> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
> +	struct rcar_gen2_phy_driver *drv = phy->drv;
> +	void __iomem *base = drv->base;
> +	unsigned long flags;
> +	u32 value;
> +	int err = 0, i;
> +
> +	/* Skip if it's not USBHS */
> +	if (phy->select_value != USBHS_UGCTRL2_USB0SEL_HS_USB)
> +		return 0;
> +
> +	spin_lock_irqsave(&drv->lock, flags);
> +
> +	/* Power on USBHS PHY */
> +	value = readl(base + USBHS_UGCTRL);
> +	value &= ~USBHS_UGCTRL_PLLRESET;
> +	writel(value, base + USBHS_UGCTRL);
> +
> +	value = readw(base + USBHS_LPSTS);
> +	value |= USBHS_LPSTS_SUSPM;
> +	writew(value, base + USBHS_LPSTS);
> +
> +	for (i = 0; i < 20; i++) {
> +		value = readl(base + USBHS_UGSTS);
> +		if ((value & USBHS_UGSTS_LOCK) = USBHS_UGSTS_LOCK) {
> +			value = readl(base + USBHS_UGCTRL);
> +			value |= USBHS_UGCTRL_CONNECT;
> +			writel(value, base + USBHS_UGCTRL);
> +			goto out;
> +		}
> +		udelay(1);
> +	}
> +
> +	/* Timed out waiting for the PLL lock */
> +	err = -ETIMEDOUT;
> +
> +out:
> +	spin_unlock_irqrestore(&drv->lock, flags);
> +
> +	return err;
> +}
> +
> +static int rcar_gen2_phy_power_off(struct phy *p)
> +{
> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
> +	struct rcar_gen2_phy_driver *drv = phy->drv;
> +	void __iomem *base = drv->base;
> +	unsigned long flags;
> +	u32 value;
> +
> +	/* Skip if it's not USBHS */
> +	if (phy->select_value != USBHS_UGCTRL2_USB0SEL_HS_USB)
> +		return 0;
> +
> +	spin_lock_irqsave(&drv->lock, flags);
> +
> +	/* Power off USBHS PHY */
> +	value = readl(base + USBHS_UGCTRL);
> +	value &= ~USBHS_UGCTRL_CONNECT;
> +	writel(value, base + USBHS_UGCTRL);
> +
> +	value = readw(base + USBHS_LPSTS);
> +	value &= ~USBHS_LPSTS_SUSPM;
> +	writew(value, base + USBHS_LPSTS);
> +
> +	value = readl(base + USBHS_UGCTRL);
> +	value |= USBHS_UGCTRL_PLLRESET;
> +	writel(value, base + USBHS_UGCTRL);
> +
> +	spin_unlock_irqrestore(&drv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops rcar_gen2_phy_ops = {
> +	.init		= rcar_gen2_phy_init,
> +	.exit		= rcar_gen2_phy_exit,
> +	.power_on	= rcar_gen2_phy_power_on,
> +	.power_off	= rcar_gen2_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct of_device_id rcar_gen2_phy_match_table[] = {
> +	{ .compatible = "renesas,usb-phy-r8a7790" },
> +	{ .compatible = "renesas,usb-phy-r8a7791" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rcar_gen2_phy_match_table);
> +
> +static struct phy *rcar_gen2_phy_xlate(struct device *dev,
> +				       struct of_phandle_args *args)
> +{
> +	struct rcar_gen2_phy_driver *drv;
> +
> +	drv = dev_get_drvdata(dev);
> +	if (!drv)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (args->args[0] >= NUM_USB_CHANNELS || args->args[1] >= 2)
> +		return ERR_PTR(-ENODEV);
> +
> +	return drv->phys[args->args[0]][args->args[1]].phy;
> +}
> +
> +static int rcar_gen2_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rcar_gen2_phy_driver *drv;
> +	struct phy_provider *provider;
> +	struct device_node *np;
> +	struct resource *res;
> +	void __iomem *base;
> +	struct clk *clk;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev,
> +			"This driver is required to be instantiated from device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	clk = devm_clk_get(dev, "usbhs");
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "Can't get USBHS clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&drv->lock);
> +
> +	drv->clk = clk;
> +	drv->base = base;
> +
> +	for_each_child_of_node(dev->of_node, np) {
> +  		struct rcar_gen2_phy *phy;
> +		u32 values[2];
> +		int error;
> +
> +		error = of_property_read_u32_array(np, "renesas,phy-select",
> +						   values, 2);
> +		if (error) {
> +			dev_err(dev, "Failed to read \"renesas,phy-select\" property\n");
> +			return error;
> +		}
> +		if (values[0] >= NUM_USB_CHANNELS || values[1] >= 2) {
> +			dev_err(dev, "Values out of range in \"renesas,phy-select\"
> property\n"); +			return error;
> +		}
> +		phy = &drv->phys[values[0]][values[1]];
> +
> +		error = of_property_read_u32_array(np, "renesas,ugctrl2-masks",
> +						   values, 2);
> +		if (error) {
> +			dev_err(dev, "Failed to read \"renesas,ugctrl2-masks\" 
property\n");
> +			return error;
> +		}
> +		phy->select_mask  = values[0];
> +		phy->select_value = values[1];
> +
> +		phy->phy = devm_phy_create(dev, &rcar_gen2_phy_ops, NULL);
> +		if (IS_ERR(phy->phy)) {
> +			dev_err(dev, "Failed to create PHY\n");
> +			return PTR_ERR(phy->phy);
> +		}
> +
> +		phy->drv = drv;
> +		phy_set_drvdata(phy->phy, phy);
> +	}
> +
> +	provider = devm_of_phy_provider_register(dev, rcar_gen2_phy_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(dev, "Failed to register PHY provider\n");
> +		return PTR_ERR(provider);
> +	}
> +
> +	dev_set_drvdata(dev, drv);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rcar_gen2_phy_driver = {
> +	.driver = {
> +		.name		= "phy_rcar_gen2",
> +		.of_match_table	= rcar_gen2_phy_match_table,
> +	},
> +	.probe	= rcar_gen2_phy_probe,
> +};
> +
> +module_platform_driver(rcar_gen2_phy_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Renesas R-Car Gen2 PHY");
> +MODULE_AUTHOR("Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,

Laurent Pinchart


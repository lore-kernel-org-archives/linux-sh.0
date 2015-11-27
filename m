From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Fri, 27 Nov 2015 05:33:16 +0000
Subject: Re: [PATCH v5 1/4] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <5657E84C.5010800@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445331471-5028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1445331471-5028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1445331471-5028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Tuesday 20 October 2015 02:27 PM, Yoshihiro Shimoda wrote:
> This patch adds support for R-Car generation 3 USB2 PHY driver.
> This SoC has 3 EHCI/OHCI channels, and the channel 0 is shared
> with the HSUSB (USB2.0 peripheral) device. And each channel has
> independent registers about the PHYs.
> 
> So, the purpose of this driver is:
>  1) initializes some registers of SoC specific to use the
>     {ehci,ohci}-platform driver.
> 
>  2) detects id pin to select host or peripheral on the channel 0.
> 
> For now, this driver only supports 1) above.

When you do 2), make sure to use the extcon framework.

One minor comment below and then I can queue it for 4.5.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  37 ++++
>  drivers/phy/Kconfig                                |   7 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-rcar-gen3-usb2.c                   | 219 +++++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
>  create mode 100644 drivers/phy/phy-rcar-gen3-usb2.c
> 

<snip>

> diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
> new file mode 100644
> index 0000000..9d9cf26
> --- /dev/null
> +++ b/drivers/phy/phy-rcar-gen3-usb2.c
> @@ -0,0 +1,219 @@
> +/*
> + * Renesas R-Car Gen3 for USB2.0 PHY driver
> + *
> + * Copyright (C) 2015 Renesas Electronics Corporation
> + *
> + * This is based on the phy-rcar-gen2 driver:
> + * Copyright (C) 2014 Renesas Solutions Corp.
> + * Copyright (C) 2014 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +
> +/******* USB2.0 Host registers (original offset is +0x200) *******/
> +#define USB2_INT_ENABLE		0x000
> +#define USB2_USBCTR		0x00c
> +#define USB2_SPD_RSM_TIMSET	0x10c
> +#define USB2_OC_TIMSET		0x110
> +
> +/* INT_ENABLE */
> +#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
> +#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)
> +#define USB2_INT_ENABLE_INIT		(USB2_INT_ENABLE_USBH_INTB_EN | \
> +					 USB2_INT_ENABLE_USBH_INTA_EN)
> +
> +/* USBCTR */
> +#define USB2_USBCTR_DIRPD	BIT(2)
> +#define USB2_USBCTR_PLL_RST	BIT(1)
> +
> +/* SPD_RSM_TIMSET */
> +#define USB2_SPD_RSM_TIMSET_INIT	0x014e029b
> +
> +/* OC_TIMSET */
> +#define USB2_OC_TIMSET_INIT		0x000209ab
> +
> +/******* HSUSB registers (original offset is +0x100) *******/
> +#define HSUSB_LPSTS			0x02
> +#define HSUSB_UGCTRL2			0x84
> +
> +/* Low Power Status register (LPSTS) */
> +#define HSUSB_LPSTS_SUSPM		0x4000
> +
> +/* USB General control register 2 (UGCTRL2) */
> +#define HSUSB_UGCTRL2_MASK		0x00000031 /* bit[31:6] should be 0 */
> +#define HSUSB_UGCTRL2_USB0SEL		0x00000030
> +#define HSUSB_UGCTRL2_USB0SEL_HOST	0x00000010
> +#define HSUSB_UGCTRL2_USB0SEL_HS_USB	0x00000020
> +#define HSUSB_UGCTRL2_USB0SEL_OTG	0x00000030
> +
> +struct rcar_gen3_data {
> +	void __iomem *base;
> +	struct clk *clk;
> +};
> +
> +struct rcar_gen3_chan {
> +	struct rcar_gen3_data usb2;
> +	struct rcar_gen3_data hsusb;
> +	struct phy *phy;
> +};
> +
> +static int rcar_gen3_phy_usb2_init(struct phy *p)
> +{
> +	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
> +	void __iomem *usb2_base = channel->usb2.base;
> +	void __iomem *hsusb_base = channel->hsusb.base;
> +	u32 val;
> +
> +	/* Initialize USB2 part */
> +	writel(USB2_INT_ENABLE_INIT, usb2_base + USB2_INT_ENABLE);
> +	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
> +	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
> +
> +	/* Initialize HSUSB part */
> +	if (hsusb_base) {
> +		/* TODO: support "OTG" mode */
> +		val = readl(hsusb_base + HSUSB_UGCTRL2);
> +		val = (val & ~HSUSB_UGCTRL2_USB0SEL) |
> +		      HSUSB_UGCTRL2_USB0SEL_HOST;
> +		writel(val & HSUSB_UGCTRL2_MASK, hsusb_base + HSUSB_UGCTRL2);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcar_gen3_phy_usb2_exit(struct phy *p)
> +{
> +	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
> +
> +	writel(0, channel->usb2.base + USB2_INT_ENABLE);
> +
> +	return 0;
> +}
> +
> +static int rcar_gen3_phy_usb2_power_on(struct phy *p)
> +{
> +	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
> +	void __iomem *usb2_base = channel->usb2.base;
> +	void __iomem *hsusb_base = channel->hsusb.base;
> +	u32 val;
> +
> +	val = readl(usb2_base + USB2_USBCTR);
> +	val |= USB2_USBCTR_PLL_RST;
> +	writel(val, usb2_base + USB2_USBCTR);
> +	val &= ~USB2_USBCTR_PLL_RST;
> +	writel(val, usb2_base + USB2_USBCTR);
> +
> +	/*
> +	 * TODO: To reduce power consuming, this driver should set the SUSPM
> +	 *	after the PHY detects ID pin as peripheral.
> +	 */
> +	if (hsusb_base) {
> +		/* Power on HSUSB PHY */
> +		val = readw(hsusb_base + HSUSB_LPSTS);
> +		val |= HSUSB_LPSTS_SUSPM;
> +		writew(val, hsusb_base + HSUSB_LPSTS);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcar_gen3_phy_usb2_power_off(struct phy *p)
> +{
> +	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
> +	void __iomem *hsusb_base = channel->hsusb.base;
> +	u32 val;
> +
> +	if (hsusb_base) {
> +		/* Power off HSUSB PHY */
> +		val = readw(hsusb_base + HSUSB_LPSTS);
> +		val &= ~HSUSB_LPSTS_SUSPM;
> +		writew(val, hsusb_base + HSUSB_LPSTS);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct phy_ops rcar_gen3_phy_usb2_ops = {
> +	.init		= rcar_gen3_phy_usb2_init,
> +	.exit		= rcar_gen3_phy_usb2_exit,
> +	.power_on	= rcar_gen3_phy_usb2_power_on,
> +	.power_off	= rcar_gen3_phy_usb2_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct of_device_id rcar_gen3_phy_usb2_match_table[] = {
> +	{ .compatible = "renesas,usb2-phy-r8a7795" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rcar_gen3_phy_usb2_match_table);
> +
> +static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rcar_gen3_chan *channel;
> +	struct phy_provider *provider;
> +	struct resource *res;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev, "This driver needs device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	channel = devm_kzalloc(dev, sizeof(*channel), GFP_KERNEL);
> +	if (!channel)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "usb2_host");
> +	channel->usb2.base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(channel->usb2.base))
> +		return PTR_ERR(channel->usb2.base);
> +
> +	/* "hsusb" memory resource is optional */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsusb");
> +
> +	/* To avoid error message by devm_ioremap_resource() */
> +	if (res) {
> +		channel->hsusb.base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(channel->hsusb.base))
> +			channel->hsusb.base = NULL;
> +	}
> +
> +	/* devm_phy_create() will call pm_runtime_enable(dev); */
> +	channel->phy = devm_phy_create(dev, NULL, &rcar_gen3_phy_usb2_ops);
> +	if (IS_ERR(channel->phy)) {
> +		dev_err(dev, "Failed to create USB2 PHY\n");
> +		return PTR_ERR(channel->phy);
> +	}
> +
> +	phy_set_drvdata(channel->phy, channel);
> +
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		dev_err(dev, "Failed to register PHY provider\n");
> +		return PTR_ERR(provider);
> +	}
> +
> +	return 0;

This can simply be replaced with return PTR_ERR_OR_ZERO(provider);

Thanks
Kishon

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 10 Apr 2014 19:53:26 +0000
Subject: Re: [PATCH v2] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <5346F6B6.8000901@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404090144.26769.sergei.shtylyov@cogentembedded.com> <53466C07.4080409@ti.com>
In-Reply-To: <53466C07.4080409@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-doc@vger.kernel.org, rdunlap@infradead.org, grant.likely@linaro.org

On 04/10/2014 02:01 PM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Wednesday 09 April 2014 03:14 AM, Sergei Shtylyov wrote:
>> This PHY, though formally being a part of Renesas USBHS controller, contains the
>> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls them
>> channels) to the different USB controllers: channel 0 can be connected to either
>> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI EHCI/OHCI
>> or xHCI controllers.
>>
>> This is a new driver for this USB PHY currently already supported under drivers/
>> usb/phy/. The reason for writing the new driver was the requirement that the
>> multiplexing of USB channels to the controller be dynamic, depending on what
>> USB drivers are loaded,  rather than static as provided by the old driver.

> I'm not sure what you mean by dynamic here as the binding between the
> controller and the PHY is given in dt data.

    I mean that whether the bindings are actually established within the 
kernel (and therefore the UGCTRL2 register value programmed) depends on the 
set of the USB controller drivers loaded. Contrasted to the fixed UGCTRL2 
value determined by the platform data (and so determining the set of the USB 
controller drivers that can be loaded) as it happens with the old driver.

>> The infrastructure provided by drivers/phy/phy-core.c seems to fit that purpose
>> ideally. The new driver only supports device tree probing for now.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

>> Index: linux-phy/drivers/phy/Kconfig
>> =================================>> --- linux-phy.orig/drivers/phy/Kconfig
>> +++ linux-phy/drivers/phy/Kconfig
>> @@ -31,6 +31,13 @@ config PHY_MVEBU_SATA
>>   	depends on OF
>>   	select GENERIC_PHY
>>
>> +config PHY_RCAR_GEN2
>> +	tristate "Renesas R-Car generation 2 USB PHY driver"
>> +	depends on ARCH_SHMOBILE
>> +	depends on GENERIC_PHY

> depends on CONFIG_OF?

    Well, it does not seem strictly necessary to build the driver, so I left 
it out; should double check though...
    BTW, it would be nice if each PHY driver doesn't have to either select or 
depend on CONFIG_GENERIC_PHY; how about a patch which would enclose all the 
drivers into 'if GENERIC_PHY'?

[...]
>> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
>> =================================>> --- /dev/null
>> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
>> @@ -0,0 +1,287 @@
>> +/*
>> + * Renesas R-Car Gen2 PHY driver
>> + *
>> + * Copyright (C) 2014 Renesas Solutions Corp.
>> + * Copyright (C) 2014 Cogent Embedded, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +
>> +#define USBHS_LPSTS			0x02
>> +#define USBHS_UGCTRL			0x80
>> +#define USBHS_UGCTRL2			0x84
>> +#define USBHS_UGSTS			0x88
>> +
>> +/* Low Power Status register (LPSTS) */
>> +#define USBHS_LPSTS_SUSPM		0x4000
>> +
>> +/* USB General control register (UGCTRL) */
>> +#define USBHS_UGCTRL_CONNECT		0x00000004
>> +#define USBHS_UGCTRL_PLLRESET		0x00000001
>> +
>> +/* USB General control register 2 (UGCTRL2) */
>> +#define USBHS_UGCTRL2_USB2SEL		0x80000000
>> +#define USBHS_UGCTRL2_USB2SEL_PCI	0x00000000
>> +#define USBHS_UGCTRL2_USB2SEL_USB30	0x80000000
>> +#define USBHS_UGCTRL2_USB0SEL		0x00000030
>> +#define USBHS_UGCTRL2_USB0SEL_PCI	0x00000010
>> +#define USBHS_UGCTRL2_USB0SEL_HS_USB	0x00000030

> Why isn't there an entry for channel 1?

    Because there's none; channel 1 is not configurable and fixed to PCI 
EHCI/OHCI (and doesn't exist on R8A7791, only on R8A7790).

>> +
>> +/* USB General status register (UGSTS) */
>> +#define USBHS_UGSTS_LOCK		0x00000300	/* 0x00000003? */

> Not sure about the LOCK value?

    The old driver has (3 << 8), the manual talks about bits 0-1. I didn't 
test the driver with USBHS controller for which this bitfield is only usable 
(no easy way to implement device tree support for USBHS). Should double check 
with the old driver -- forgot to do it due to the time constraints...

[...]
>> +static int rcar_gen2_usbhs_phy_power_on(struct phy *p)
>> +{
>> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
>> +	struct rcar_gen2_phy_driver *drv = phy->drv;
>> +	void __iomem *base = drv->base;
>> +	unsigned long flags;
>> +	u32 value;
>> +	int err = 0, i;
>> +
>> +	spin_lock_irqsave(&drv->lock, flags);
>> +
>> +	/* Power on USBHS PHY */
>> +	value = readl(base + USBHS_UGCTRL);
>> +	value &= ~USBHS_UGCTRL_PLLRESET;
>> +	writel(value, base + USBHS_UGCTRL);

> hmm.. Don't have separate bits to control power for separate PHYs?

    Exactly. The PHY actually belongs to the Renesas USBHS controller, that 
UGCTRL2 port multiplexing register seems like some ad-hockery... :-/

>> +
>> +	value = ioread16(base + USBHS_LPSTS);

> why ioreadl here?

    Oops. The old driver used io{read|write}*() accessors, and I've replaced 
them since they have no gain on the MMIO only devices. Apparently forgot to 
replace 16-bit I/O... :-/

>> +static int rcar_gen2_usbhs_phy_power_off(struct phy *p)
>> +{
>> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
>> +	struct rcar_gen2_phy_driver *drv = phy->drv;
>> +	void __iomem *base = drv->base;
>> +	unsigned long flags;
>> +	u32 value;
>> +
>> +	spin_lock_irqsave(&drv->lock, flags);
>> +
>> +	/* Power off USBHS PHY */
>> +	value = readl(base + USBHS_UGCTRL);
>> +	value &= ~USBHS_UGCTRL_CONNECT;
>> +	writel(value, base + USBHS_UGCTRL);

> here too.. that will power off all the PHYs no?

    No, only the USBHS PHY. The power_{on|off}() methods only exist for USBHS 
PHY (at indexes [0][1]).

>> +static struct phy_ops rcar_gen2_phy_ops = {
>> +	.init		= rcar_gen2_phy_init,
>> +	.exit		= rcar_gen2_phy_exit,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static struct phy_ops rcar_gen2_usbhs_phy_ops = {
>> +	.init		= rcar_gen2_phy_init,
>> +	.exit		= rcar_gen2_phy_exit,
>> +	.power_on	= rcar_gen2_usbhs_phy_power_on,
>> +	.power_off	= rcar_gen2_usbhs_phy_power_off,
>> +	.owner		= THIS_MODULE,
>> +};

> Let's not create multiple phy_ops for a single driver.

    Unfortunately, I have to because not all PHYs are equal.

[...]
>> +static int rcar_gen2_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rcar_gen2_phy_driver *drv;
>> +	struct phy_provider *provider;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	int i, j;
>> +
>> +	if (!dev->of_node) {
>> +		dev_err(dev, "This driver is required to be instantiated from device tree\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	clk = devm_clk_get(dev, "usbhs");
>> +	if (IS_ERR(clk)) {
>> +		dev_err(dev, "Can't get USBHS clock\n");
>> +		return PTR_ERR(clk);
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
>> +	if (!drv)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&drv->lock);
>> +
>> +	drv->clk = clk;
>> +	drv->base = base;
>> +
>> +	drv->phys[0][0].select_mask  = USBHS_UGCTRL2_USB0SEL;
>> +	drv->phys[0][0].select_value = USBHS_UGCTRL2_USB0SEL_PCI;
>> +	drv->phys[0][1].select_mask  = USBHS_UGCTRL2_USB0SEL;
>> +	drv->phys[0][1].select_value = USBHS_UGCTRL2_USB0SEL_HS_USB;

> channel 1 is not used?

    Not configurable and does not always exist as I said earlier.

> Thanks
> Kishon

WBR, Sergei


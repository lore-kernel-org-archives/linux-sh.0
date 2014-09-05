From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Sep 2014 18:46:29 +0000
Subject: Re: [PATCH v5] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <540A0505.5060008@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407222327.15179.sergei.shtylyov@cogentembedded.com> <53F4B3E7.3030700@ti.com>
In-Reply-To: <53F4B3E7.3030700@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org
Cc: rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 08/20/2014 06:42 PM, Kishon Vijay Abraham I wrote:

    Sorry for the delayed reply, I was busy in other kernel areas. Should have 
replied yesterday though...

[...]

>> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
>> =================================>> --- /dev/null
>> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
>> @@ -0,0 +1,341 @@
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
>> +#include <asm/cmpxchg.h>
>> +
>> +#define USBHS_LPSTS			0x02
>> +#define USBHS_UGCTRL			0x80
>> +#define USBHS_UGCTRL2			0x84
>> +#define USBHS_UGSTS			0x88	/* The manuals have 0x90 */
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
>> +
>> +/* USB General status register (UGSTS) */
>> +#define USBHS_UGSTS_LOCK		0x00000300 /* The manuals have 0x3 */
>> +
>> +#define PHYS_PER_CHANNEL	2
>> +
>> +struct rcar_gen2_phy {
>> +	struct phy *phy;
>> +	struct rcar_gen2_channel *channel;
>> +	int number;
>> +	u32 select_value;
>> +};
>> +
>> +struct rcar_gen2_channel {
>> +	struct device_node *of_node;
>> +	struct rcar_gen2_phy_driver *drv;
>> +	struct rcar_gen2_phy phys[PHYS_PER_CHANNEL];
>> +	int selected_phy;
>> +	u32 select_mask;
>> +};
>> +
>> +struct rcar_gen2_phy_driver {
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	spinlock_t lock;
>> +	int num_channels;
>> +	struct rcar_gen2_channel *channels;
>> +};
>> +
>> +static int rcar_gen2_phy_init(struct phy *p)
>> +{
>> +	struct rcar_gen2_phy *phy = phy_get_drvdata(p);
>> +	struct rcar_gen2_channel *channel = phy->channel;
>> +	struct rcar_gen2_phy_driver *drv = channel->drv;
>> +	unsigned long flags;
>> +	u32 ugctrl2;
>> +
>> +	/*
>> +	 * Try to acquire exclusive access to PHY.  The first driver calling
>> +	 * phy_init()  on a given channel wins, and all attempts  to use another
>> +	 * PHY on this channel will fail until phy_exit() is called by the first
>> +	 * driver.   Achieving this with cmpxcgh() should be SMP-safe.
>> +	 */
>> +	if (cmpxchg(&channel->selected_phy, -1, phy->number) != -1)
>> +		return -EBUSY;

> This should be done in phy_get no?

    No, if you mean the of_xlate() method: I need a place to release the lock 
which I wouldn't have in this case.
    If you mean modifying _of_phy_get(), it has no notion of channels and 
probably shouldn't have since the channels are a special case for this driver 
(and maybe some others) ...

> Can we add this in phy-core? There might be other users who want to have
> exclusive access within the same phy provider.

    The exclusive access is not within the provider in my case, it's within a 
channel (each of which has a corresponding DT subnode), so I don't think it's 
well representable in the phy-core. I'm not using your suggested 
subnode-per-PHY representation since it doesn't really fit my case well...

> Rest of it looks fine to me.

    Thanks.

> Thanks
> Kishon

WBR, Sergei


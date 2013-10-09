From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 09 Oct 2013 21:21:27 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <5255C8D7.4020107@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/10/2013 12:32 AM, Laurent Pinchart wrote:
> Hi Valentine,
>

Hi Laurent,

> Thank you for the patch.
>
> On Tuesday 08 October 2013 23:43:25 Valentine Barshak wrote:
>> This adds RCAR Gen2 USB phy support. The driver configures
>> USB channels 0/2 which are shared between PCI USB hosts and
>> USBHS/USBSS devices. It also controls internal USBHS phy.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   drivers/usb/phy/Kconfig                         |  13 ++
>>   drivers/usb/phy/Makefile                        |   1 +
>>   drivers/usb/phy/phy-rcar-gen2-usb.c             | 255 +++++++++++++++++++++
>>   include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
>>   4 files changed, 291 insertions(+)
>>   create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>>   create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index d5589f9..297062c 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -214,6 +214,19 @@ config USB_RCAR_PHY
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called phy-rcar-usb.
>>
>> +config USB_RCAR_GEN2_PHY
>> +	tristate "Renesas R-Car Gen2 USB PHY support"
>> +	depends on ARCH_R8A7790 || ARCH_R8A7791
>
>  From a development point of view it's always nice to be able to compile the
> driver for a wider range of devices, even if the device is only found in the
> R8A779[01]. This allows catching compilation errors, for instance caused by
> API changes that affect all drivers using the API being modified.

Compiling a dirver for an unsupported architecture also seems to be more 
error-prone.

>
> I would use either
>
> 	depends on ARM
>
> or
>
> 	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
>
> (assuming the driver can compile on non-ARM platforms, otherwise the above
> line could be changed to ARCH_R8A7790 || ARCH_R8A7791 || (ARM &&
> COMPILE_TEST)).

OK, I'll take a look.
Do all the drivers have to support COMPILE_TEST?

>
>> +	select USB_PHY
>> +	help
>> +	  Say Y here to add support for the Renesas R-Car Gen2 USB PHY driver.
>> +	  It is typically used to control internal USB PHY for USBHS,
>> +	  and to configure shared USB channels 0 and 2.
>> +	  This driver supports R8A7790 and R8A7791.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called phy-rcar-gen2-usb.
>> +
>>   config USB_ULPI
>>   	bool "Generic ULPI Transceiver Driver"
>>   	depends on ARM
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index 2135e85..8c5b147 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -29,5 +29,6 @@ obj-$(CONFIG_USB_MSM_OTG)		+= phy-msm-usb.o
>>   obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
>>   obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
>>   obj-$(CONFIG_USB_RCAR_PHY)		+= phy-rcar-usb.o
>> +obj-$(CONFIG_USB_RCAR_GEN2_PHY)		+= phy-rcar-gen2-usb.o
>>   obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
>>   obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
>> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> b/drivers/usb/phy/phy-rcar-gen2-usb.c new file mode 100644
>> index 0000000..a2e6f9f
>> --- /dev/null
>> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
>> @@ -0,0 +1,255 @@
>> +/*
>> + * Renesas R-Car Gen2 USB phy driver
>> + *
>> + * Copyright (C) 2013 Renesas Solutions Corp.
>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/usb/otg.h>
>> +#include <linux/platform_data/usb-rcar-gen2-phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/module.h>
>
> Would you mind ordering the headers alphabetically ? This helps avoiding
> duplicate includes, an existing include might not be noticed at first glance
> when adding a new one if the list is long and not sorted.

OK.

>
>> +struct rcar_gen2_usb_phy_priv {
>> +	struct usb_phy phy;
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	spinlock_t lock;
>> +	int usecount;
>> +	u32 ugctrl2;
>> +};
>> +
>> +#define usb_phy_to_priv(p) container_of(p, struct rcar_gen2_usb_phy_priv,
>> phy) +
>> +/* Low Power Status register */
>> +#define USBHS_LPSTS_REG			0x02
>> +#define USBHS_LPSTS_SUSPM		(1 << 14)
>> +
>> +/* USB General control register */
>> +#define USBHS_UGCTRL_REG		0x80
>> +#define USBHS_UGCTRL_CONNECT		(1 << 2)
>> +#define USBHS_UGCTRL_PLLRESET		(1 << 0)
>> +
>> +/* USB General control register 2 */
>> +#define USBHS_UGCTRL2_REG		0x84
>> +#define USBHS_UGCTRL2_USB0_PCI		(1 << 4)
>> +#define USBHS_UGCTRL2_USB0_HS		(3 << 4)
>> +#define USBHS_UGCTRL2_USB2_PCI		(0 << 31)
>> +#define USBHS_UGCTRL2_USB2_SS		(1 << 31)
>> +
>> +/* USB General status register */
>> +#define USBHS_UGSTS_REG			0x88
>> +#define USBHS_UGSTS_LOCK		(3 << 8)
>> +
>> +/* Enable USBHS internal phy */
>> +static int __rcar_gen2_usbhs_phy_enable(void __iomem *base)
>
> Any reason for the __ as a function prefix ?

This indicates that the function is called with the spinlock held.

>
> I would have passed a struct rcar_gen2_usb_phy_priv pointer to this function,
> which would allow you to print a debugging message using dev_dbg() in case of
> a timeout. That's up to you.
>
>> +{
>> +	u32 val;
>> +	int i;
>
> I tend to use unsigned int for loop counters that can't take negative values.

Do not see much of a difference really.

>
>> +
>> +	/* USBHS PHY power on */
>> +	val = ioread32(base + USBHS_UGCTRL_REG);
>> +	val &= ~USBHS_UGCTRL_PLLRESET;
>> +	iowrite32(val, base + USBHS_UGCTRL_REG);
>> +
>> +	val = ioread16(base + USBHS_LPSTS_REG);
>> +	val |= USBHS_LPSTS_SUSPM;
>> +	iowrite16(val, base + USBHS_LPSTS_REG);
>> +
>> +	for (i = 0; i < 20; i++) {
>> +		val = ioread32(base + USBHS_UGSTS_REG);
>> +		if ((val & USBHS_UGSTS_LOCK) = USBHS_UGSTS_LOCK) {
>> +			val = ioread32(base + USBHS_UGCTRL_REG);
>> +			val |= USBHS_UGCTRL_CONNECT;
>> +			iowrite32(val, base + USBHS_UGCTRL_REG);
>> +			return 0;
>> +		}
>> +		udelay(1);
>
> What's the maximum number of iterations you've observed in practice ? Does the
> 20 limit come from somewhere in particular ?

The maximum I've seen is 4. The docs say nothing about the limit. Thus, 
20 seemed more than enough to me.

[snip]

>> +static int rcar_gen2_usb_phy_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rcar_gen2_phy_platform_data *pdata;
>> +	struct rcar_gen2_usb_phy_priv *priv;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	struct clk *clk;
>> +	int retval;
>> +
>> +	pdata = dev_get_platdata(&pdev->dev);
>
> DT support would be nice too :-)

I Plan to add it with a separate patch later since we still need to add 
DT support to renesas_usbhs.

>
>> +	if (!pdata) {
>> +		dev_err(dev, "No platform data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	clk = devm_clk_get(&pdev->dev, "usbhs");
>> +	if (IS_ERR(clk)) {
>> +		dev_err(&pdev->dev, "Can't get the clock\n");
>> +		return PTR_ERR(clk);
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "No memory resource\n");
>
> No need to check the return value or print an error message,
> devm_ioremap_resource() already takes care of that.

OK, thanks.

>
>> +		return -ENODEV;
>> +	}
>> +
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base)) {
>> +		dev_err(dev, "Failed to ioremap resource\n");
>
> No need to print an error message here either.

OK, thanks.

[snip]

Thanks,
Val.

From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Wed, 17 Dec 2014 00:31:30 +0000
Subject: Re: [PATCH] extcon: add MAX3355 driver
Message-Id: <5490CEE2.1030900@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <14631865.01KLlU2iKL@wasted.cogentembedded.com>
In-Reply-To: <14631865.01KLlU2iKL-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/11/2014 08:28 AM, Sergei Shtylyov wrote:
> MAX3355E chip integrates a charge pump and comparators to enable a system with
> an integrated USB OTG dual-role transceiver to function as a USB OTG dual-role
> device. In addition to sensing/controlling Vbus, the chip also passes thru the
> ID signal from the USB OTG connector.  On some Renesas boards, this signal  is
> just  fed into the SoC thru a GPIO pin -- there's no real OTG controller, only
> host and gadget USB controllers sharing the same USB bus; however,  we'd  like
> to allow host or gadget drivers to be loaded depending on the cable type, hence
> the need for the MAX3355 extcon driver. The Vbus status signals are also wired
> to GPIOs (however, we're not currently intested in them), the  OFFVBUS# signal
> is controlled  by the host controllers, there's also the SHDN# signal wired to
> GPIO, which should be high for normal operation.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
> 
>  Documentation/devicetree/bindings/extcon/extcon-max3355.txt |   21 ++
>  drivers/extcon/Kconfig                                      |    6 
>  drivers/extcon/Makefile                                     |    1 
>  drivers/extcon/extcon-max3355.c                             |  122 ++++++++++++
>  4 files changed, 150 insertions(+)
> 
> Index: extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
> =================================> --- /dev/null
> +++ extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
> @@ -0,0 +1,21 @@
> +MAX3355 USB OTG chip

Need manufactor information as following :
  -> Maxim MAX3355

> +--------------------
> +
> +MAX3355 integrates a charge pump and comparators to enable a system with an
> +integrated USB OTG dual-role transceiver to function as a USB OTG dual-role
> +device.
> +
> +Required properties:
> +- compatible: should be "maxim,max3355";
> +- maxim,shdn-gpio: should contain a phandle and GPIO specifier for the GPIO pin
> +  connected to the MAX3355's SHDN# pin;
> +- maxim,id-gpio: should contain a phandle and GPIO specifier for the GPIO pin
> +  connected to the MAX3355's ID_OUT pin.
> +
> +Example (Koelsch board):
> +
> +	usb-otg {
> +		compatible = "maxim,max3355";
> +		maxim,shdn-gpio = <&gpio2 4 GPIO_ACTIVE_LOW>;
> +		maxim,id-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;

Kernel already supported the gpio helper function to get gpio from devicetree.	
I prefer use follwoing style by using of_get_gpio()/of_get_gpio_flags() in include/linux/of_gpio.h.

		gpios = <&gpio2 4 GPIO_ACTIVE_LOW>, <&gpio5 31 GPIO_ACTIVE_HIGH>;

> +	};
> Index: extcon/drivers/extcon/Kconfig
> =================================> --- extcon.orig/drivers/extcon/Kconfig
> +++ extcon/drivers/extcon/Kconfig
> @@ -45,6 +45,12 @@ config EXTCON_MAX14577
>  	  Maxim MAX14577/77836. The MAX14577/77836 MUIC is a USB port accessory
>  	  detector and switch.
>  
> +config EXTCON_MAX3355
> +	tristate "MAX3355 USB OTG EXTCON Support"
> +	help
> +	  Say Y here to enable support for the USB host detection by MAX3355
> +	  OTG USB chip.
> +
>  config EXTCON_MAX77693
>  	tristate "MAX77693 EXTCON Support"
>  	depends on MFD_MAX77693 && INPUT
> Index: extcon/drivers/extcon/Makefile
> =================================> --- extcon.orig/drivers/extcon/Makefile
> +++ extcon/drivers/extcon/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-
>  obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
>  obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
>  obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
> +obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
>  obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
>  obj-$(CONFIG_EXTCON_MAX8997)	+= extcon-max8997.o
>  obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
> Index: extcon/drivers/extcon/extcon-max3355.c
> =================================> --- /dev/null
> +++ extcon/drivers/extcon/extcon-max3355.c
> @@ -0,0 +1,122 @@
> +/*
> + * MAX3355 USB OTG chip extcon driver

ditto.

> + *
> + * Copyright (C) 2014 Cogent Embedded, Inc.
> + * Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + */
> +
> +#include <linux/extcon.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +struct max3355_data {
> +	struct extcon_dev *edev;
> +	int id_gpio;
> +};
> +
> +static const char *max3355_cable[] = {
> +	[0] = "USB-HOST",
> +	NULL,
> +};
> +
> +static irqreturn_t max3355_id_irq(int irq, void *dev_id)
> +{
> +	struct max3355_data *data = dev_id;
> +	int id = gpio_get_value(data->id_gpio);
> +
> +	extcon_set_cable_state(data->edev, "USB-HOST", !id);

You have to get the gpio flag in the devicetree by using of_get_gpio_flags() function
and then you would set the cable state according to gpio state and flag.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max3355_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct max3355_data *data;
> +	int gpio, irq, ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct max3355_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->edev = devm_extcon_dev_allocate(&pdev->dev, max3355_cable);
> +	if (IS_ERR(data->edev)) {
> +		dev_err(&pdev->dev, "failed to allocate extcon device\n");
> +		return PTR_ERR(data->edev);
> +	}
> +	data->edev->name = kstrdup(np->name, GFP_KERNEL);
> +
> +	gpio = of_get_named_gpio(np, "maxim,id-gpio", 0);

Use of_get_gpio() or of_get_gpio_flags().
"maxim,id-gpio" property has strong dependency on this driver and it is not standard.

> +	if (gpio < 0)
> +		return gpio;

Need to add error message.

> +	data->id_gpio = gpio;
> +
> +	gpio = of_get_named_gpio(np, "maxim,shdn-gpio", 0);

ditto.

> +	if (gpio < 0)
> +		return gpio;

Need to add error message.

> +
> +	ret = devm_gpio_request_one(&pdev->dev, gpio, GPIOF_DIR_OUT |
> +				    GPIOF_INIT_HIGH, pdev->name);
> +	if (ret < 0)
> +		return ret;

Need to add error message.

> +
> +	ret = devm_gpio_request_one(&pdev->dev, data->id_gpio, GPIOF_DIR_IN,
> +				    pdev->name);

Why do you use same name for two gpio when devm_gpio_request_one?
I prefer to use other name because two gpio is different.


> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_extcon_dev_register(&pdev->dev, data->edev);
> +	if (ret < 0)
> +		return ret;

Need to add error message.

> +
> +	irq = gpio_to_irq(data->id_gpio);
> +	if (irq < 0)
> +		return irq;

Need to add error message.

> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, max3355_id_irq,
> +					IRQF_TRIGGER_RISING |
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Is it right to add both RISING and FALLING trigger?
and need to add IRQF_NO_SUSPEND to wakeup from suspend state when interrupt happen.

> +					pdev->name, data);
> +	if (ret < 0)
> +		return ret;

Need to add error message.

> +
> +	platform_set_drvdata(pdev, data);
> +
> +	/* Perform initial detection */
> +	max3355_id_irq(irq, data);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max3355_match_table[] = {
> +	{ .compatible = "maxim,max3355", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max3355_match_table);
> +
> +static struct platform_driver max3355_driver = {
> +	.probe		= max3355_probe,
> +	.driver		= {
> +		.name	= "extcon-max3355",
> +		.of_match_table = max3355_match_table,
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(max3355_driver);
> +

Don't need un-used blank line.

> +MODULE_AUTHOR("Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>");
> +MODULE_DESCRIPTION("MAX3355 extcon driver");

Maxim MAX3355.

> +MODULE_LICENSE("GPL v2");
> 
> 

Thanks,
Chanwoo Choi


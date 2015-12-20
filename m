From: Chanwoo Choi <cwchoi00@gmail.com>
Date: Sun, 20 Dec 2015 14:31:29 +0000
Subject: Re: [PATCH v5] extcon: add Maxim MAX3355 driver
Message-Id: <CAGTfZH34rfMfjsAFgyPeNue74-5iCi6ZwrdN26_jwOXE6R=hwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5948633.my3nAG6hRz@wasted.cogentembedded.com>
In-Reply-To: <5948633.my3nAG6hRz@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hi,

This patch depend on GPIOLIB configuration as following:
I modified it with following diff and applied it.

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index ba4db7d..3d89e60 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -54,6 +54,7 @@ config EXTCON_MAX14577

 config EXTCON_MAX3355
        tristate "Maxim MAX3355 USB OTG EXTCON Support"
+       depends on GPIOLIB || COMPILE_TEST
        help
          If you say yes here you get support for the USB OTG role detection by
          MAX3355. The MAX3355 chip integrates a charge pump and comparators to

Thanks,
Chanwoo Choi


On Sat, Dec 19, 2015 at 8:17 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Maxim Integrated MAX3355E chip integrates a charge pump and comparators to
> enable a system with an integrated USB OTG dual-role transceiver to
> function as an USB OTG dual-role device. In addition to sensing/controlling
> Vbus, the chip also passes thru the ID signal from the USB OTG connector.
> On some Renesas boards, this signal is just fed into the SoC thru a GPIO
> pin -- there's no real OTG controller, only host and gadget USB controllers
> sharing the same USB bus; however, we'd like to allow host or gadget
> drivers to be loaded depending on the cable type, hence the need for the
> MAX3355 extcon driver. The Vbus status signals are also wired to GPIOs
> (however, we aren't currently interested in them), the OFFVBUS# signal is
> controlled by the host controllers, there's also the SHDN# signal wired to
> a GPIO, it should be driven high for the normal operation.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> ---
> Changes in version 5:
> - removed unused variable in the probe() method;
> - removed reference to the Koelsch board from the binding document;
> - added Chanwoo Choi's ACK.
>
> Changes in version 4:
> - stopped calling kstrdup() for the device name;
> - removed unneeded 'owner' field initializer;
> - moved devm_extcon_allocate() call further down in the probe() method;
> - extended the driver copyright;
> - indented the continuation lines in the binding document.
>
> Changes in version 3:
> - reformatted the change log.
>
> Changes in version 2:
> - added the USB gadget cable support;
> - added the remove() driver method which drives SHDN# GPIO low to save power;
> - dropped vendor prefix from the ID GPIO property name;
> - changed the GPIO property name suffix to "-gpios";
> - switched to usign extcon_set_cable_state_() API;
> - switched to using the gpiod/sleeping 'gpiolib' APIs;
> - addded error messages to max3355_probe();
> - added IRQF_NO_SUSPEND flasg to the devm_request_threaded_irq() call;
> - renamed 'ret' variable to 'err' in max3355_probe();
> - expanded the Kconfig entry help text;
> - added vendor name to the patch summary, the bindings document, the Kconfig
>   entry, the driver heading comment, the module description, and the change log;
> - fixed up and reformatted the change log.
>
>  Documentation/devicetree/bindings/extcon/extcon-max3355.txt |   21 +
>  drivers/extcon/Kconfig                                      |    8
>  drivers/extcon/Makefile                                     |    1
>  drivers/extcon/extcon-max3355.c                             |  150 ++++++++++++
>  4 files changed, 180 insertions(+)
>
> Index: extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
> =================================> --- /dev/null
> +++ extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
> @@ -0,0 +1,21 @@
> +Maxim Integrated MAX3355 USB OTG chip
> +-------------------------------------
> +
> +MAX3355 integrates a charge pump and comparators to enable a system with an
> +integrated USB OTG dual-role transceiver to function as a USB OTG dual-role
> +device.
> +
> +Required properties:
> +- compatible: should be "maxim,max3355";
> +- maxim,shdn-gpios: should contain a phandle and GPIO specifier for the GPIO pin
> +                   connected to the MAX3355's SHDN# pin;
> +- id-gpios: should contain a phandle and GPIO specifier for the GPIO pin
> +           connected to the MAX3355's ID_OUT pin.
> +
> +Example:
> +
> +       usb-otg {
> +               compatible = "maxim,max3355";
> +               maxim,shdn-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
> +               id-gpios = <&gpio5 31 GPIO_ACTIVE_HIGH>;
> +       };
> Index: extcon/drivers/extcon/Kconfig
> =================================> --- extcon.orig/drivers/extcon/Kconfig
> +++ extcon/drivers/extcon/Kconfig
> @@ -52,6 +52,14 @@ config EXTCON_MAX14577
>           Maxim MAX14577/77836. The MAX14577/77836 MUIC is a USB port accessory
>           detector and switch.
>
> +config EXTCON_MAX3355
> +       tristate "Maxim MAX3355 USB OTG EXTCON Support"
> +       help
> +         If you say yes here you get support for the USB OTG role detection by
> +         MAX3355. The MAX3355 chip integrates a charge pump and comparators to
> +         enable a system with an integrated USB OTG dual-role transceiver to
> +         function as an USB OTG dual-role device.
> +
>  config EXTCON_MAX77693
>         tristate "Maxim MAX77693 EXTCON Support"
>         depends on MFD_MAX77693 && INPUT
> Index: extcon/drivers/extcon/Makefile
> =================================> --- extcon.orig/drivers/extcon/Makefile
> +++ extcon/drivers/extcon/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_EXTCON_ARIZONA)    += extcon-a
>  obj-$(CONFIG_EXTCON_AXP288)    += extcon-axp288.o
>  obj-$(CONFIG_EXTCON_GPIO)      += extcon-gpio.o
>  obj-$(CONFIG_EXTCON_MAX14577)  += extcon-max14577.o
> +obj-$(CONFIG_EXTCON_MAX3355)   += extcon-max3355.o
>  obj-$(CONFIG_EXTCON_MAX77693)  += extcon-max77693.o
>  obj-$(CONFIG_EXTCON_MAX77843)  += extcon-max77843.o
>  obj-$(CONFIG_EXTCON_MAX8997)   += extcon-max8997.o
> Index: extcon/drivers/extcon/extcon-max3355.c
> =================================> --- /dev/null
> +++ extcon/drivers/extcon/extcon-max3355.c
> @@ -0,0 +1,150 @@
> +/*
> + * Maxim Integrated MAX3355 USB OTG chip extcon driver
> + *
> + * Copyright (C)  2014-2015 Cogent Embedded, Inc.
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
> +       struct extcon_dev *edev;
> +       struct gpio_desc *id_gpiod;
> +       struct gpio_desc *shdn_gpiod;
> +};
> +
> +static const unsigned int max3355_cable[] = {
> +       EXTCON_USB,
> +       EXTCON_USB_HOST,
> +       EXTCON_NONE,
> +};
> +
> +static irqreturn_t max3355_id_irq(int irq, void *dev_id)
> +{
> +       struct max3355_data *data = dev_id;
> +       int id = gpiod_get_value_cansleep(data->id_gpiod);
> +
> +       if (id) {
> +               /*
> +                * ID = 1 means USB HOST cable detached.
> +                * As we don't have event for USB peripheral cable attached,
> +                * we simulate USB peripheral attach here.
> +                */
> +               extcon_set_cable_state_(data->edev, EXTCON_USB_HOST, false);
> +               extcon_set_cable_state_(data->edev, EXTCON_USB, true);
> +       } else {
> +               /*
> +                * ID = 0 means USB HOST cable attached.
> +                * As we don't have event for USB peripheral cable detached,
> +                * we simulate USB peripheral detach here.
> +                */
> +               extcon_set_cable_state_(data->edev, EXTCON_USB, false);
> +               extcon_set_cable_state_(data->edev, EXTCON_USB_HOST, true);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int max3355_probe(struct platform_device *pdev)
> +{
> +       struct max3355_data *data;
> +       struct gpio_desc *gpiod;
> +       int irq, err;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(struct max3355_data),
> +                           GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       gpiod = devm_gpiod_get(&pdev->dev, "id", GPIOD_IN);
> +       if (IS_ERR(gpiod)) {
> +               dev_err(&pdev->dev, "failed to get ID_OUT GPIO\n");
> +               return PTR_ERR(gpiod);
> +       }
> +       data->id_gpiod = gpiod;
> +
> +       gpiod = devm_gpiod_get(&pdev->dev, "maxim,shdn", GPIOD_OUT_HIGH);
> +       if (IS_ERR(gpiod)) {
> +               dev_err(&pdev->dev, "failed to get SHDN# GPIO\n");
> +               return PTR_ERR(gpiod);
> +       }
> +       data->shdn_gpiod = gpiod;
> +
> +       data->edev = devm_extcon_dev_allocate(&pdev->dev, max3355_cable);
> +       if (IS_ERR(data->edev)) {
> +               dev_err(&pdev->dev, "failed to allocate extcon device\n");
> +               return PTR_ERR(data->edev);
> +       }
> +
> +       err = devm_extcon_dev_register(&pdev->dev, data->edev);
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failed to register extcon device\n");
> +               return err;
> +       }
> +
> +       irq = gpiod_to_irq(data->id_gpiod);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "failed to translate ID_OUT GPIO to IRQ\n");
> +               return irq;
> +       }
> +
> +       err = devm_request_threaded_irq(&pdev->dev, irq, NULL, max3355_id_irq,
> +                                       IRQF_ONESHOT | IRQF_NO_SUSPEND |
> +                                       IRQF_TRIGGER_RISING |
> +                                       IRQF_TRIGGER_FALLING,
> +                                       pdev->name, data);
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failed to request ID_OUT IRQ\n");
> +               return err;
> +       }
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       /* Perform initial detection */
> +       max3355_id_irq(irq, data);
> +
> +       return 0;
> +}
> +
> +static int max3355_remove(struct platform_device *pdev)
> +{
> +       struct max3355_data *data = platform_get_drvdata(pdev);
> +
> +       gpiod_set_value_cansleep(data->shdn_gpiod, 0);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id max3355_match_table[] = {
> +       { .compatible = "maxim,max3355", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, max3355_match_table);
> +
> +static struct platform_driver max3355_driver = {
> +       .probe          = max3355_probe,
> +       .remove         = max3355_remove,
> +       .driver         = {
> +               .name   = "extcon-max3355",
> +               .of_match_table = max3355_match_table,
> +       },
> +};
> +
> +module_platform_driver(max3355_driver);
> +
> +MODULE_AUTHOR("Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>");
> +MODULE_DESCRIPTION("Maxim MAX3355 extcon driver");
> +MODULE_LICENSE("GPL v2");
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

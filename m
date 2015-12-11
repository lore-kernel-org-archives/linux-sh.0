From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Fri, 11 Dec 2015 04:05:43 +0000
Subject: Re: [PATCH] extcon-usb-gpio: add enable pin support
Message-Id: <566A4B97.7080801@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4393960.B6dD3UkQy3@wasted.cogentembedded.com>
In-Reply-To: <4393960.B6dD3UkQy3@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hi Sergei,

On 2015년 12월 11일 08:07, Sergei Shtylyov wrote:
> Sometimes  there's a real  OTG chip behind the USB ID signal mapped to a GPIO
> pin: in my case it's Maxim Integrated MAX3355E which  integrates Vbus charge
> pump and comparators and passes  thru the ID  signal  from an OTG connector.

s/thru/through ?

> This chip also has the SHDN# pin which  should be  driven high for the normal
> operation  and low to  save power;  it  is connected to a GPIO pin as well on,
> hence  we'll have  to  teach the driver to parse the new optional device tree
> property, "enable-gpio"...

This patch description includes the double space between words. Also, I think
you need to write the patch description again for formal style.

This patch adds the specific 'enable-gpio' pin to express the SHDN#pin for MAX3355E.
I think it is not regular and standard case because maybe USB specification
don't include the SHDN#pin information. I think it not appropriate way.
Instead, you better to make the MAX3355 extcon driver to support this case.

Thanks,
Chanwoo 

> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
> 
>  Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt |    3 +++
>  drivers/extcon/extcon-usb-gpio.c                             |    5 +++++
>  2 files changed, 8 insertions(+)
> 
> Index: extcon/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> =================================> --- extcon.orig/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> +++ extcon/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
> @@ -7,6 +7,9 @@ Required properties:
>  - compatible: Should be "linux,extcon-usb-gpio"
>  - id-gpio: gpio for USB ID pin. See gpio binding.
>  
> +Optional properties:
> +- enable-gpio: gpio for the enable pin. See gpio binding.
> +
>  Example: Examples of extcon-usb-gpio node in dra7-evm.dts as listed below:
>  	extcon_usb1 {
>  		compatible = "linux,extcon-usb-gpio";
> Index: extcon/drivers/extcon/extcon-usb-gpio.c
> =================================> --- extcon.orig/drivers/extcon/extcon-usb-gpio.c
> +++ extcon/drivers/extcon/extcon-usb-gpio.c
> @@ -33,6 +33,7 @@ struct usb_extcon_info {
>  	struct device *dev;
>  	struct extcon_dev *edev;
>  
> +	struct gpio_desc *enable_gpiod;
>  	struct gpio_desc *id_gpiod;
>  	int id_irq;
>  
> @@ -99,6 +100,8 @@ static int usb_extcon_probe(struct platf
>  		return -ENOMEM;
>  
>  	info->dev = dev;
> +	info->enable_gpiod = devm_gpiod_get_optional(&pdev->dev, "enable",
> +						     GPIOD_OUT_HIGH);
>  	info->id_gpiod = devm_gpiod_get(&pdev->dev, "id", GPIOD_IN);
>  	if (IS_ERR(info->id_gpiod)) {
>  		dev_err(dev, "failed to get ID GPIO\n");
> @@ -155,6 +158,8 @@ static int usb_extcon_remove(struct plat
>  
>  	cancel_delayed_work_sync(&info->wq_detcable);
>  
> +	gpiod_set_value_cansleep(info->enable_gpiod, 0);
> +
>  	return 0;
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


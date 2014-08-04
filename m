From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 04 Aug 2014 00:05:41 +0000
Subject: Re: [PATCH 2/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <877g2pxgoi.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53DB7EC4.5010705@renesas.com>
In-Reply-To: <53DB7EC4.5010705@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>


Hi Shimoda-san

> This driver supports other SoCs, but they need boards/Soc depend code.
> So, this patch adds device tree support for R-Car H2 and M2 initially.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
(snip)
> +static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
> +{
> +	struct renesas_usbhs_platform_info *info;
> +	struct renesas_usbhs_driver_param *dparam;
> +	u32 tmp;
> +	int gpio;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return NULL;
> +
> +	dparam = &info->driver_param;
> +
> +	if (of_device_is_compatible(dev->of_node, "renesas,usbhs-r8a7790"))
> +		dparam->type = USBHS_TYPE_R8A7790;
> +
> +	if (of_device_is_compatible(dev->of_node, "renesas,usbhs-r8a7791"))
> +		dparam->type = USBHS_TYPE_R8A7791;
> +
> +	if (!of_property_read_u32(dev->of_node, "buswait_bwait", &tmp))
> +		dparam->buswait_bwait = tmp;
> +	gpio = of_get_named_gpio_flags(dev->of_node, "enable-gpio", 0, NULL);
> +	if (gpio > 0)
> +		dparam->enable_gpio = gpio;
(snip)
> +static const struct of_device_id usbhs_of_match[] = {
> +	{ .compatible = "renesas,usbhs-r8a7790"},
> +	{ .compatible = "renesas,usbhs-r8a7791"},
> +	{ },

How about to use "of_device_id :: data" for USBHS_TYPE_xxx ?

Best regards
---
Kuninori Morimoto

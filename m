From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 04 Aug 2014 04:27:01 +0000
Subject: Re: [PATCH 2/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <53DF0B95.8090203@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53DB7EC4.5010705@renesas.com> <877g2pxgoi.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <877g2pxgoi.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>

Hi Morimoto-san,

(2014/08/04 9:05), Kuninori Morimoto wrote:
> 
> Hi Shimoda-san
> 
>> This driver supports other SoCs, but they need boards/Soc depend code.
>> So, this patch adds device tree support for R-Car H2 and M2 initially.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
> (snip)
>> +static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
>> +{
>> +	struct renesas_usbhs_platform_info *info;
>> +	struct renesas_usbhs_driver_param *dparam;
>> +	u32 tmp;
>> +	int gpio;
>> +
>> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return NULL;
>> +
>> +	dparam = &info->driver_param;
>> +
>> +	if (of_device_is_compatible(dev->of_node, "renesas,usbhs-r8a7790"))
>> +		dparam->type = USBHS_TYPE_R8A7790;
>> +
>> +	if (of_device_is_compatible(dev->of_node, "renesas,usbhs-r8a7791"))
>> +		dparam->type = USBHS_TYPE_R8A7791;
>> +
>> +	if (!of_property_read_u32(dev->of_node, "buswait_bwait", &tmp))
>> +		dparam->buswait_bwait = tmp;
>> +	gpio = of_get_named_gpio_flags(dev->of_node, "enable-gpio", 0, NULL);
>> +	if (gpio > 0)
>> +		dparam->enable_gpio = gpio;
> (snip)
>> +static const struct of_device_id usbhs_of_match[] = {
>> +	{ .compatible = "renesas,usbhs-r8a7790"},
>> +	{ .compatible = "renesas,usbhs-r8a7791"},
>> +	{ },
> 
> How about to use "of_device_id :: data" for USBHS_TYPE_xxx ?

Thank you for the suggestion.
To remove the "if (of_device_is_compatible(...))", I will use the
"of_device_id :: data" lile a ".data = (void *)USBHS_TYPE_R8A7790".

Best regards,
Yoshihiro Shimoda

> Best regards
> ---
> Kuninori Morimoto
> 

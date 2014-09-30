From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 30 Sep 2014 09:51:37 +0000
Subject: Re: [PATCH v3 2/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <542A7D29.3010805@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5406A664.2050501@renesas.com> <54298A38.5030703@cogentembedded.com>
In-Reply-To: <54298A38.5030703@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, kuninori morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht@gmail.com>

Hello.

(2014/09/30 1:35), Sergei Shtylyov wrote:
> Hello.
> 
> On 09/03/2014 09:25 AM, Yoshihiro Shimoda wrote:
> 
>> This driver supports other SoCs, but they need boards/Soc depend code.
>> So, this patch adds device tree support for R-Car H2 and M2 initially.
> 
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   drivers/usb/renesas_usbhs/common.c |   44 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
> 
>> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
>> index 1b9bf8d..b3b6813 100644
>> --- a/drivers/usb/renesas_usbhs/common.c
>> +++ b/drivers/usb/renesas_usbhs/common.c
>> @@ -18,6 +18,8 @@
>>   #include <linux/gpio.h>
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/slab.h>
>>   #include <linux/sysfs.h>
>> @@ -438,6 +440,43 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
> [...]
>> +static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
>> +{
>> +	struct renesas_usbhs_platform_info *info;
>> +	struct renesas_usbhs_driver_param *dparam;
>> +	const struct of_device_id *of_id = of_match_device(usbhs_of_match, dev);
>> +	u32 tmp;
>> +	int gpio;
>> +
>> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return NULL;
>> +
>> +	dparam = &info->driver_param;
>> +	dparam->type = of_id ? (u32)of_id->data : 0;
>> +	if (!of_property_read_u32(dev->of_node, "renesas,buswait", &tmp))
>> +		dparam->buswait_bwait = tmp;
>> +	gpio = of_get_named_gpio_flags(dev->of_node, "renesas,enable-gpio", 0,
>> +				       NULL);
>> +	if (gpio > 0)
>> +		dparam->enable_gpio = gpio;
>> +
>> +	return info;
> 
>     I don't see where you parse the optional "phy" property. It should exist 
> for the Lager and Koelsch boards you target.

Since I wrote 'phy-names: must be "usb"' in the document,
I intend to use a fixed property for "phy" driver like the following:

	phy = phy_get(&pdev->dev, "usb");

Is this a bad code?

About using the phy driver in renesas_usbhs driver, I intend to modify
the drivers/usb/renesas_usbhs/rcar.c.

Best regards,
Yoshihiro Shimoda

> WBR, Sergei
> 

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 29 Sep 2014 16:35:04 +0000
Subject: Re: [PATCH v3 2/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <54298A38.5030703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5406A664.2050501@renesas.com>
In-Reply-To: <5406A664.2050501-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Ulrich Hecht <ulrich.hecht-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hello.

On 09/03/2014 09:25 AM, Yoshihiro Shimoda wrote:

> This driver supports other SoCs, but they need boards/Soc depend code.
> So, this patch adds device tree support for R-Car H2 and M2 initially.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/usb/renesas_usbhs/common.c |   44 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)

> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> index 1b9bf8d..b3b6813 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -18,6 +18,8 @@
>   #include <linux/gpio.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
> @@ -438,6 +440,43 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
[...]
> +static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
> +{
> +	struct renesas_usbhs_platform_info *info;
> +	struct renesas_usbhs_driver_param *dparam;
> +	const struct of_device_id *of_id = of_match_device(usbhs_of_match, dev);
> +	u32 tmp;
> +	int gpio;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return NULL;
> +
> +	dparam = &info->driver_param;
> +	dparam->type = of_id ? (u32)of_id->data : 0;
> +	if (!of_property_read_u32(dev->of_node, "renesas,buswait", &tmp))
> +		dparam->buswait_bwait = tmp;
> +	gpio = of_get_named_gpio_flags(dev->of_node, "renesas,enable-gpio", 0,
> +				       NULL);
> +	if (gpio > 0)
> +		dparam->enable_gpio = gpio;
> +
> +	return info;

    I don't see where you parse the optional "phy" property. It should exist 
for the Lager and Koelsch boards you target.

WBR, Sergei


From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 07 Oct 2014 09:46:13 +0000
Subject: Re: [PATCH 2/2] arm: shmobile: lager: enable HS-USB
Message-Id: <5433B665.9040302@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237073-1288-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <542EFDEA.2030906@cogentembedded.com> <5431E984.6000203@renesas.com> <54335D0E.6070606@renesas.com>
In-Reply-To: <54335D0E.6070606-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 10/7/2014 7:25 AM, Yoshihiro Shimoda wrote:

>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>> ---
>>>>    arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
>>>>    1 file changed, 5 insertions(+)

>>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>>>> index 1698591..4badd0a 100644
>>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>>>> @@ -445,3 +445,8 @@
>>>>    		};
>>>>    	};
>>>>    };
>>>> +
>>>> +&hsusb {
>>>> +	status = "okay";
>>>> +	renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_LOW>;

>>>      It's certainly active-high.

>> Since the current code has the following, we have to set the active_low...
>> However, the code is unreadable, I think. So, I will modify the code.
>>
>> 	/* check GPIO determining if USB function should be enabled */
>> 	if (priv->dparam.enable_gpio) {
>> 		gpio_request_one(priv->dparam.enable_gpio, GPIOF_IN, NULL);
>> 		ret = !gpio_get_value(priv->dparam.enable_gpio);
>> 		gpio_free(priv->dparam.enable_gpio);
>> 		if (ret) {
>> 			dev_warn(&pdev->dev,
>> 				 "USB function not selected (GPIO %d)\n",
>> 				 priv->dparam.enable_gpio);
>> 			ret = -ENOTSUPP;
>> 			goto probe_end_mod_exit;
>> 		}
>> 	}

> I am confusing about the gpio_get_value()...
> In case of ARM, gpio_get_value() will call gpiod_get_raw_value() finally.

> gpio_get_value() in arch/arm/include/asm/gpio.h
>   --> __gpio_get_value() in include/asm-generic/gpio.h
>    --> gpiod_get_raw_value() in drivers/gpio/gpiolib.c

> The gpiod_get_raw_value() doesn't care of the GPIO_ACTIVE_{HIGH,LOW}.
> So, should I add gpiod_is_active_low() or someting in the renesas_usbhs driver?

    Why do you still think it's active-low?!

> Or, Do I misunderstand something?

    Look at the above code again.

> Best regards,
> Yoshihiro Shimoda

WBR, Sergei


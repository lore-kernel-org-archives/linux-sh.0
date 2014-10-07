From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 11:01:32 +0000
Subject: Re: [PATCH 2/2] arm: shmobile: lager: enable HS-USB
Message-Id: <5433C80C.2090006@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237073-1288-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237073-1288-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <542EFDEA.2030906@cogentembedded.com> <5431E984.6000203@renesas.com> <54335D0E.6070606@renesas.com> <5433B665.9040302@cogentembedded.com>
In-Reply-To: <5433B665.9040302@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello.

(2014/10/07 18:46), Sergei Shtylyov wrote:
> On 10/7/2014 7:25 AM, Yoshihiro Shimoda wrote:
> 
>>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>>> ---
>>>>>    arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
>>>>>    1 file changed, 5 insertions(+)
> 
>>>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
>>>>> index 1698591..4badd0a 100644
>>>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>>>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>>>>> @@ -445,3 +445,8 @@
>>>>>            };
>>>>>        };
>>>>>    };
>>>>> +
>>>>> +&hsusb {
>>>>> +    status = "okay";
>>>>> +    renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_LOW>;
> 
>>>>      It's certainly active-high.
> 
>>> Since the current code has the following, we have to set the active_low...
>>> However, the code is unreadable, I think. So, I will modify the code.
>>>
>>>     /* check GPIO determining if USB function should be enabled */
>>>     if (priv->dparam.enable_gpio) {
>>>         gpio_request_one(priv->dparam.enable_gpio, GPIOF_IN, NULL);
>>>         ret = !gpio_get_value(priv->dparam.enable_gpio);
>>>         gpio_free(priv->dparam.enable_gpio);
>>>         if (ret) {
>>>             dev_warn(&pdev->dev,
>>>                  "USB function not selected (GPIO %d)\n",
>>>                  priv->dparam.enable_gpio);
>>>             ret = -ENOTSUPP;
>>>             goto probe_end_mod_exit;
>>>         }
>>>     }
> 
>> I am confusing about the gpio_get_value()...
>> In case of ARM, gpio_get_value() will call gpiod_get_raw_value() finally.
> 
>> gpio_get_value() in arch/arm/include/asm/gpio.h
>>   --> __gpio_get_value() in include/asm-generic/gpio.h
>>    --> gpiod_get_raw_value() in drivers/gpio/gpiolib.c
> 
>> The gpiod_get_raw_value() doesn't care of the GPIO_ACTIVE_{HIGH,LOW}.
>> So, should I add gpiod_is_active_low() or someting in the renesas_usbhs driver?
> 
>    Why do you still think it's active-low?!
> 
>> Or, Do I misunderstand something?
> 
>    Look at the above code again.

Thank you for the comment.
Finally, I understood this. I will not modify the driver and
I just change the "GPIO_ACTIVE_LOW" in the dts file to "GPIO_ACTIVE_HIGH"
because of your previous comment below:

>>     'ret' is non-zero here if gpio_get_value() returned 0, so 0 means "host"
>> and 1 means "gadget", i.e. GPIO is active-high.

Best regards,
Yoshihiro Shimoda

>> Best regards,
>> Yoshihiro Shimoda
> 
> WBR, Sergei
> 

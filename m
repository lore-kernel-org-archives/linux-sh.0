From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Fri, 18 Dec 2015 00:19:49 +0000
Subject: Re: [PATCH v3] extcon: add Maxim MAX3355 driver
Message-Id: <56735125.1040304@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2473780.4IzuWX8hE2@wasted.cogentembedded.com>
 <CAJKOXPfD8DnDow04_wyRyGk+8zBmT15giDS+WDcV+pFaWSypGw@mail.gmail.com>
 <5672C884.3000603@cogentembedded.com>
In-Reply-To: <5672C884.3000603-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 17.12.2015 23:36, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/17/2015 3:53 AM, Krzysztof Kozlowski wrote:
> 
>>> Maxim Integrated MAX3355E chip integrates a charge pump and
>>> comparators to
>>> enable a system with an integrated USB OTG dual-role transceiver to
>>> function as an USB OTG dual-role device. In addition to
>>> sensing/controlling
>>> Vbus, the chip also passes thru the ID signal from the USB OTG
>>> connector.
>>> On some Renesas boards, this signal is just fed into the SoC thru a GPIO
>>> pin -- there's no real OTG controller, only host and gadget USB
>>> controllers
>>> sharing the same USB bus; however, we'd like to allow host or gadget
>>> drivers to be loaded depending on the cable type, hence the need for the
>>> MAX3355 extcon driver. The Vbus status signals are also wired to GPIOs
>>> (however, we aren't currently interested in them), the OFFVBUS#
>>> signal is
>>> controlled by the host controllers, there's also the SHDN# signal
>>> wired to
>>> a GPIO, it should be driven high for the normal operation.
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>> ---
>>> Changes in version 3:
>>> - reformatted the change log.
>>>
>>> Changes in version 2:
>>> - added the USB gadget cable support;
>>> - added the remove() driver method which drives SHDN# GPIO low to
>>> save power;
>>> - dropped vendor prefix from the ID GPIO property name;
>>> - changed the GPIO property name suffix to "-gpios";
>>> - switched to usign extcon_set_cable_state_() API;
>>> - switched to using the gpiod/sleeping 'gpiolib' APIs;
>>> - addded error messages to max3355_probe();
>>> - added IRQF_NO_SUSPEND flasg to the devm_request_threaded_irq() call;
>>> - renamed 'ret' variable to 'err' in max3355_probe();
>>> - expanded the Kconfig entry help text;
>>> - added vendor name to the patch summary, the bindings document, the
>>> Kconfig
>>>    entry, the driver heading comment, the module description, and the
>>> change log;
>>> - fixed up and reformatted the change log.
>>>
>>>   Documentation/devicetree/bindings/extcon/extcon-max3355.txt |   21 +
>>>   drivers/extcon/Kconfig                                      |    8
>>>   drivers/extcon/Makefile                                     |    1
>>>   drivers/extcon/extcon-max3355.c                             |  153
>>> ++++++++++++
>>>   4 files changed, 183 insertions(+)
>>>
>>> Index:
>>> renesas/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
>>> =================================>>> --- /dev/null
>>> +++ renesas/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
>>> @@ -0,0 +1,21 @@
>>> +Maxim Integrated MAX3355 USB OTG chip
>>> +-------------------------------------
>>> +
>>> +MAX3355 integrates a charge pump and comparators to enable a system
>>> with an
>>> +integrated USB OTG dual-role transceiver to function as a USB OTG
>>> dual-role
>>> +device.
>>> +
>>> +Required properties:
>>> +- compatible: should be "maxim,max3355";
>>> +- maxim,shdn-gpios: should contain a phandle and GPIO specifier for
>>> the GPIO pin
>>> +  connected to the MAX3355's SHDN# pin;
>>
>> Could you add some indentation to the wrapped line for this property?
>> For readability.
> 
>    If it's not indented enough, I can add more spaces/tabs.

Ahh, now I see it is sufficient. I need fix my email client.

> 
>>> +- id-gpios: should contain a phandle and GPIO specifier for the GPIO
>>> pin
>>> +  connected to the MAX3355's ID_OUT pin.
>>
>> Ditto.
>>
>> Why this property lacks the vendor prefix i(n comparison to shdn-gpios
>> which has the prefix)?
> 
>    Since the extcon-usb-gpio driver uses "id-gpio" prop already. I can
> add back the vendor prefix if you insist.


It is for USB ID and palmas has it already as well so I do not insist.
Seems generic.

> 
> [...]
>>> Index: renesas/drivers/extcon/extcon-max3355.c
>>> =================================>>> --- /dev/null
>>> +++ renesas/drivers/extcon/extcon-max3355.c
>>> @@ -0,0 +1,153 @@
> [...]
>>> +static int max3355_probe(struct platform_device *pdev)
>>> +{
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct max3355_data *data;
>>> +       struct gpio_desc *gpiod;
>>> +       int irq, err;
>>> +
>>> +       data = devm_kzalloc(&pdev->dev, sizeof(struct max3355_data),
>>> +                           GFP_KERNEL);
>>> +       if (!data)
>>> +               return -ENOMEM;
>>> +
>>> +       data->edev = devm_extcon_dev_allocate(&pdev->dev,
>>> max3355_cable);
>>> +       if (IS_ERR(data->edev)) {
>>> +               dev_err(&pdev->dev, "failed to allocate extcon
>>> device\n");
>>> +               return PTR_ERR(data->edev);
>>> +       }
>>> +       data->edev->name = kstrdup(np->name, GFP_KERNEL);
>>
>> I think it is not needed any more (extcon_dev_register()) will set it.
>> Anyway there is no checking for NULL return value and no freeing in
>> error/exit paths.
> 
>    Oops, will fix.
> 
> [...]
>>> +static struct platform_driver max3355_driver = {
>>> +       .probe          = max3355_probe,
>>> +       .remove         = max3355_remove,
>>> +       .driver         = {
>>> +               .name   = "extcon-max3355",
>>> +               .of_match_table = max3355_match_table,
>>> +               .owner  = THIS_MODULE,
>>
>> No need for owner.
>> Please pass the source through recent coccicheck and fix the findings.
> 
>    Has it been included in the kernel source somewhere already?

The rules detecting the unnecessary owner should be there for some time
(sice 4.2 or 4.1?). The coccicheck is in kernel - scripts/coccicheck. It
uses coccinelle/spatch. You can run it just like other code-checker
tools - sparse and smatch.

Best regards,
Krzysztof


From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Nov 2015 18:24:21 +0000
Subject: Re: [PATCH] extcon: add MAX3355 driver
Message-Id: <5640E4D5.4020001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <14631865.01KLlU2iKL@wasted.cogentembedded.com>
 <5490CEE2.1030900@samsung.com> <5491FC69.7090203@cogentembedded.com>
 <562685EF.7010504@cogentembedded.com> <5629CBFA.4020605@samsung.com>
In-Reply-To: <5629CBFA.4020605@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 10/23/2015 08:56 AM, Chanwoo Choi wrote:

>>>>> MAX3355E chip integrates a charge pump and comparators to enable a system with
>>>>> an integrated USB OTG dual-role transceiver to function as a USB OTG dual-role
>>>>> device. In addition to sensing/controlling Vbus, the chip also passes thru the
>>>>> ID signal from the USB OTG connector.  On some Renesas boards, this signal  is
>>>>> just  fed into the SoC thru a GPIO pin -- there's no real OTG controller, only
>>>>> host and gadget USB controllers sharing the same USB bus; however,  we'd  like
>>>>> to allow host or gadget drivers to be loaded depending on the cable type,
>>>>> hence
>>>>> the need for the MAX3355 extcon driver. The Vbus status signals are also wired
>>>>> to GPIOs (however, we're not currently intested in them), the  OFFVBUS# signal
>>>>> is controlled  by the host controllers, there's also the SHDN# signal wired to
>>>>> GPIO, which should be high for normal operation.
>>>
>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>>>> ---
>>>>> The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
>>>
>>>>>    Documentation/devicetree/bindings/extcon/extcon-max3355.txt |   21 ++
>>>>>    drivers/extcon/Kconfig                                      |    6
>>>>>    drivers/extcon/Makefile                                     |    1
>>>>>    drivers/extcon/extcon-max3355.c                             |  122
>>>>> ++++++++++++
>>>>>    4 files changed, 150 insertions(+)
>>>
>>>>> Index: extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
>>>>> =================================>>>>> --- /dev/null
>>>>> +++ extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
>>>>> @@ -0,0 +1,21 @@
>>>>> +MAX3355 USB OTG chip
>>>
>>>> Need manufactor information as following :
>>>>     -> Maxim MAX3355
>>>
>>>      Would be Maxim enough? Or perhaps I should use Maxim Integrated [Products]?
>>
>>     You haven't replied to my questions.
>>
>>>>> +--------------------
>>>>> +
>>>>> +MAX3355 integrates a charge pump and comparators to enable a system with an
>>>>> +integrated USB OTG dual-role transceiver to function as a USB OTG dual-role
>>>>> +device.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: should be "maxim,max3355";
>>>>> +- maxim,shdn-gpio: should contain a phandle and GPIO specifier for the
>>>>> GPIO pin
>>>>> +  connected to the MAX3355's SHDN# pin;
>>>>> +- maxim,id-gpio: should contain a phandle and GPIO specifier for the GPIO pin
>>>>> +  connected to the MAX3355's ID_OUT pin.
>>>>> +
>>>>> +Example (Koelsch board):
>>>>> +
>>>>> +    usb-otg {
>>>>> +        compatible = "maxim,max3355";
>>>>> +        maxim,shdn-gpio = <&gpio2 4 GPIO_ACTIVE_LOW>;
>>>>> +        maxim,id-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
>>>
>>>> Kernel already supported the gpio helper function to get gpio from devicetree.
>>>> I prefer use follwoing style by using of_get_gpio()/of_get_gpio_flags() in
>>>> include/linux/of_gpio.h.
>>>
>>>>          gpios = <&gpio2 4 GPIO_ACTIVE_LOW>, <&gpio5 31 GPIO_ACTIVE_HIGH>;
>>>
>>>      OK, though Documentation/devicetree/bindings/gpio/gpio.txt does not seem
>>> to insist on using this one...
>>
>>     Moreover, it now says "gpios" isn't allowed for the new bindings. So I have to strongly disagree here...
>
> OK. But, I recommend you use the 'gpiod' with devm_gpiod_get
> instead of using devm_gpio_request_one() directly as following:
> You can refer drivers/extcon/extcon-usb-gpio.c about using gpiod.
>
> For example,
> 	data->shdn_gpiod = devm_gpiod_get(dev, "maxim,shdn", GPIOD_IN);
> 	data->id_gpiod = devm_gpiod_get(dev, "maxim,id", GPIOD_IN);

    Thanks, done now. I just had another idea: how about I add an optional 
"enable-gpio" property to the 'extcon-usb-gpio' driver? I wouldn't need my own 
driver then at all... :-)

MBR, Sergei


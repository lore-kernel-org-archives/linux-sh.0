From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Dec 2015 18:33:18 +0000
Subject: Re: [PATCH] extcon-usb-gpio: add enable pin support
Message-Id: <566B16EE.5080206@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4393960.B6dD3UkQy3@wasted.cogentembedded.com>
 <20151211035312.GA9088@rob-hp-laptop>
In-Reply-To: <20151211035312.GA9088@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 12/11/2015 06:53 AM, Rob Herring wrote:

>> Sometimes  there's a real  OTG chip behind the USB ID signal mapped to a GPIO
>> pin: in my case it's Maxim Integrated MAX3355E which  integrates Vbus charge
>> pump and comparators and passes  thru the ID  signal  from an OTG connector.
>> This chip also has the SHDN# pin which  should be  driven high for the normal
>> operation  and low to  save power;  it  is connected to a GPIO pin as well on,
>> hence  we'll have  to  teach the driver to parse the new optional device tree
>> property, "enable-gpio"...
>
> Some wierd spacing going on here.

    I like my text properly filling up the given columns. What's the problem? :-)

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
>>
>>   Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt |    3 +++
>>   drivers/extcon/extcon-usb-gpio.c                             |    5 +++++
>>   2 files changed, 8 insertions(+)
>>
>> Index: extcon/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>> =================================>> --- extcon.orig/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>> +++ extcon/Documentation/devicetree/bindings/extcon/extcon-usb-gpio.txt
>> @@ -7,6 +7,9 @@ Required properties:
>>   - compatible: Should be "linux,extcon-usb-gpio"
>>   - id-gpio: gpio for USB ID pin. See gpio binding.
>>
>> +Optional properties:
>> +- enable-gpio: gpio for the enable pin. See gpio binding.
>
> Use -gpios as -gpio is deprecated.

    Didn't know, thanks.

[...]
>> Index: extcon/drivers/extcon/extcon-usb-gpio.c
>> =================================>> --- extcon.orig/drivers/extcon/extcon-usb-gpio.c
>> +++ extcon/drivers/extcon/extcon-usb-gpio.c
[...]
>> @@ -99,6 +100,8 @@ static int usb_extcon_probe(struct platf
>>   		return -ENOMEM;
>>
>>   	info->dev = dev;
>> +	info->enable_gpiod = devm_gpiod_get_optional(&pdev->dev, "enable",
>> +						     GPIOD_OUT_HIGH);
>>   	info->id_gpiod = devm_gpiod_get(&pdev->dev, "id", GPIOD_IN);
>>   	if (IS_ERR(info->id_gpiod)) {
>>   		dev_err(dev, "failed to get ID GPIO\n");
>> @@ -155,6 +158,8 @@ static int usb_extcon_remove(struct plat
>>
>>   	cancel_delayed_work_sync(&info->wq_detcable);
>>
>> +	gpiod_set_value_cansleep(info->enable_gpiod, 0);

> Shouldn't you support either polarity?

    The gpiolib does that for me -- devm_gpiod_get_optional() should read the 
polarity from DT.

> Rob

MBR, Sergei


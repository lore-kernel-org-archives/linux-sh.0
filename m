From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Thu, 17 Dec 2015 02:34:25 +0000
Subject: Re: [PATCH v3] extcon: add Maxim MAX3355 driver
Message-Id: <56721F31.5060608@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2473780.4IzuWX8hE2@wasted.cogentembedded.com>
 <56721AFE.9020103@samsung.com>
In-Reply-To: <56721AFE.9020103-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

On 2015년 12월 17일 11:16, Chanwoo Choi wrote:
> Hi Sergei,
> 
> On 2015년 12월 17일 03:07, Sergei Shtylyov wrote:
>> Maxim Integrated MAX3355E chip integrates a charge pump and comparators to
>> enable a system with an integrated USB OTG dual-role transceiver to
>> function as an USB OTG dual-role device. In addition to sensing/controlling
>> Vbus, the chip also passes thru the ID signal from the USB OTG connector.
>> On some Renesas boards, this signal is just fed into the SoC thru a GPIO
>> pin -- there's no real OTG controller, only host and gadget USB controllers
>> sharing the same USB bus; however, we'd like to allow host or gadget
>> drivers to be loaded depending on the cable type, hence the need for the
>> MAX3355 extcon driver. The Vbus status signals are also wired to GPIOs
>> (however, we aren't currently interested in them), the OFFVBUS# signal is
>> controlled by the host controllers, there's also the SHDN# signal wired to
>> a GPIO, it should be driven high for the normal operation.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> Changes in version 3:
>> - reformatted the change log.
>>
>> Changes in version 2:
>> - added the USB gadget cable support;
>> - added the remove() driver method which drives SHDN# GPIO low to save power;
>> - dropped vendor prefix from the ID GPIO property name;
>> - changed the GPIO property name suffix to "-gpios";
>> - switched to usign extcon_set_cable_state_() API;
>> - switched to using the gpiod/sleeping 'gpiolib' APIs;
>> - addded error messages to max3355_probe();
>> - added IRQF_NO_SUSPEND flasg to the devm_request_threaded_irq() call;
>> - renamed 'ret' variable to 'err' in max3355_probe();
>> - expanded the Kconfig entry help text;
>> - added vendor name to the patch summary, the bindings document, the Kconfig
>>   entry, the driver heading comment, the module description, and the change log;
>> - fixed up and reformatted the change log.
>>
>>  Documentation/devicetree/bindings/extcon/extcon-max3355.txt |   21 +
>>  drivers/extcon/Kconfig                                      |    8 
>>  drivers/extcon/Makefile                                     |    1 
>>  drivers/extcon/extcon-max3355.c                             |  153 ++++++++++++
>>  4 files changed, 183 insertions(+)
>>

[snip]

>> +	return 0;
>> +}
>> +
>> +static int max3355_remove(struct platform_device *pdev)
>> +{
>> +	struct max3355_data *data = platform_get_drvdata(pdev);
>> +
>> +	gpiod_set_value_cansleep(data->shdn_gpiod, 0);

Don't need to handle the 'shdn' gpio on resume/suspend funtcion?

But, if the interrput of id gpio is used for wakeup source,
there is no reason to handle it for suspend mode.

[snip]

Thanks,
Chanwoo Choi

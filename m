From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 09 Oct 2013 21:47:26 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <5255CEEE.9080109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/10/2013 01:28 AM, Laurent Pinchart wrote:
> Hi Valentine,
>
> On Thursday 10 October 2013 01:21:27 Valentine wrote:
>> On 10/10/2013 12:32 AM, Laurent Pinchart wrote:
>>> Hi Valentine,
>>
>> Hi Laurent,
>>
>>> Thank you for the patch.
>>>
>>> On Tuesday 08 October 2013 23:43:25 Valentine Barshak wrote:
>>>> This adds RCAR Gen2 USB phy support. The driver configures
>>>> USB channels 0/2 which are shared between PCI USB hosts and
>>>> USBHS/USBSS devices. It also controls internal USBHS phy.
>>>>
>>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>>> ---
>>>>
>>>>    drivers/usb/phy/Kconfig                         |  13 ++
>>>>    drivers/usb/phy/Makefile                        |   1 +
>>>>    drivers/usb/phy/phy-rcar-gen2-usb.c             | 255 +++++++++++++++++
>>>>    include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
>>>>    4 files changed, 291 insertions(+)
>>>>    create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>>>>    create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>>>>
>>>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>>>> index d5589f9..297062c 100644
>>>> --- a/drivers/usb/phy/Kconfig
>>>> +++ b/drivers/usb/phy/Kconfig
>>>> @@ -214,6 +214,19 @@ config USB_RCAR_PHY
>>>>    	  To compile this driver as a module, choose M here: the
>>>>    	  module will be called phy-rcar-usb.
>>>>
>>>> +config USB_RCAR_GEN2_PHY
>>>> +	tristate "Renesas R-Car Gen2 USB PHY support"
>>>> +	depends on ARCH_R8A7790 || ARCH_R8A7791
>>>>
>>>  From a development point of view it's always nice to be able to compile
>>> the driver for a wider range of devices, even if the device is only found
>>> in the R8A779[01]. This allows catching compilation errors, for instance
>>> caused by API changes that affect all drivers using the API being
>>> modified.
>>
>> Compiling a dirver for an unsupported architecture also seems to be more
>> error-prone.
>
> It happened to me previously that a subsystem refactoring touching lots of
> drivers forgot to update one of the drivers I was maintaining. This went
> undetected as the driver could only be compiled for a very restricted set of
> platforms, breaking compilation in mainline. It's easier to avoid this kind of
> situation if the driver can be compiled for a larger number of platforms.
>
>>> I would use either
>>>
>>> 	depends on ARM
>>>
>>> or
>>>
>>> 	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
>>>
>>> (assuming the driver can compile on non-ARM platforms, otherwise the above
>>> line could be changed to ARCH_R8A7790 || ARCH_R8A7791 || (ARM &&
>>> COMPILE_TEST)).
>>
>> OK, I'll take a look.
>> Do all the drivers have to support COMPILE_TEST?
>
> There's currently no rule, but if the driver can only be compiled for a
> restricted set of platforms, I would say that supporting COMPILE_TEST would be
> a good practice. It of course needs to be restricted to the platforms on which
> the driver will actually compile :-)

OK thanks.
I'll probably go with the safest option:
ARCH_R8A7790 || ARCH_R8A7791 || (ARM && COMPILE_TEST)

It does compile on x86 though, and may compile on other platforms as well.

Thanks,
Val.


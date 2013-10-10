From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 10 Oct 2013 16:29:43 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <5256D5F7.3050306@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/10/2013 07:23 PM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Oct 10, 2013 at 02:14:45AM +0400, Valentine Barshak wrote:
>> This adds RCAR Gen2 USB phy support. The driver configures
>> USB channels 0/2 which are shared between PCI USB hosts and
>> USBHS/USBSS devices. It also controls internal USBHS phy.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   drivers/usb/phy/Kconfig                         |  13 ++
>>   drivers/usb/phy/Makefile                        |   1 +
>>   drivers/usb/phy/phy-rcar-gen2-usb.c             | 248 ++++++++++++++++++++++++
>>   include/linux/platform_data/usb-rcar-gen2-phy.h |  22 +++
>>   4 files changed, 284 insertions(+)
>>   create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>>   create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index d5589f9..bba7d29 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -214,6 +214,19 @@ config USB_RCAR_PHY
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called phy-rcar-usb.
>>
>> +config USB_RCAR_GEN2_PHY
>> +	tristate "Renesas R-Car Gen2 USB PHY support"
>> +	depends on ARCH_R8A7790 || ARCH_R8A7791 || (ARM && COMPILE_TEST)
>
> see my question on other thread, why the forced ARM dependency ?
>

I just can't test building it architectures other than ARM and X86, 
though I guess it should probably build fine.
Just thought restricting to ARM would be safe enough.
I'll remove ARM dependency and resubmit just this patch in a bit.

Thanks,
Val.

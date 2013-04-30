From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 30 Apr 2013 19:02:18 +0000
Subject: Re: [PATCH v6 9/9] rcar-phy: handle platform data
Message-Id: <5180153A.1090009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/30/2013 02:42 PM, Felipe Balbi wrote:

>
>> Set the USBPCTRL0 register from the passed platform data in rcar_usb_phy_init();
>> don't reset it to 0 in  rcar_usb_phy_shutdown()  anymore as that does not make
>> sense.  Also, don't allow the driver's probe to succeed when the platform data
>> are not supplied with a device.
>>
>> The patch has been tested on the Marzen and BOCK-W boards.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Felipe Balbi <balbi@ti.com>
>
>> Index: renesas/drivers/usb/phy/rcar-phy.c
>> =================================>> --- renesas.orig/drivers/usb/phy/rcar-phy.c
>> +++ renesas/drivers/usb/phy/rcar-phy.c
>> @@ -11,10 +12,11 @@
>>   
>>   #include <linux/delay.h>
>>   #include <linux/io.h>
>> -#include <linux/usb/otg.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/module.h>
>> +#include <linux/usb/otg.h>
> trailing change here.

    What do you mean by "trailing"? I just naturally grouped together 
headers from the same directory.

>   Please just mention it on the commit log. It doesn't a patch of its own :-p

    I'll drop it now probably as you told me to switch to 
include/linux/platfrom_data/...

>
>> @@ -89,8 +112,21 @@ static int rcar_usb_phy_init(struct usb_
>>   		/* (4) USB-PHY reset clear */
>>   		iowrite32(PHY_ENB | PLL_ENB | PHY_RST, (reg0 + USBPCTRL1));
>>   
>> -		/* set platform specific port settings */
>> -		iowrite32(0x00000000, (reg0 + USBPCTRL0));
>> +		/* Board specific port settings */
>> +		val = 0;
>> +		if (pdata->port1_func)
>> +			val |= PORT1;
>> +		if (pdata->penc1)
>> +			val |= PENC;
>> +		for (i = 0; i < 3; i++) {
>> +			/* OVCn bits follow each other in the right order */
>> +			if (pdata->ovc_pin[i].select_3_3v)
>> +				val |= OVC0 << i;
>> +			/* OVCn_ACT bits are spaced by irregular intervals */
>> +			if (pdata->ovc_pin[i].active_high)
>> +				val |= ovcn_act[i];
>> +		}
>> +		iowrite32(val, (reg0 + USBPCTRL0));
> not all architectures provide iowrite32(). Please make sure your driver
> builds on x86 and ARM by using SHOW_ALL_DRIVERS (on Kconfig).

    Sure, it builds on ARM because it was designed for ARM SH Mobile 
subarch.
I'll check x86 just in case.

> BTW, conversion away from iowrite32() could (should) be part of a
> separate patch. No need to prevent this one from being applied.
>

    Of course. You mean conversion to plain writel(), right?

WBR, Sergei


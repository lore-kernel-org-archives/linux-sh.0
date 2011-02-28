From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 28 Feb 2011 04:40:54 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <4D6B2756.7070601@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi David,

2011/02/26 3:41, David Daney wrote:
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 759a12f..257974e 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -1070,6 +1070,7 @@ MODULE_LICENSE ("GPL");
>>
>>   #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
>>       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
>> +    defined(CONFIG_CPU_SUBTYPE_SH7757) || \
>>       defined(CONFIG_CPU_SUBTYPE_SH7763) || \
>>       defined(CONFIG_CPU_SUBTYPE_SH7786)
>>   #include "ohci-sh.c"
> 
> I wonder if all that #ifdefery could be moved into the arch/sh Kconfig.
> 
> Patching the core ehci/ohci code each time a new sh CPU variant is 
> released seems like the wrong approach.

Thank you very much for your comment. I think so.
So I will move it into the drivers/usb/host Kconfig because
the Kconfig has some configs for architecture dependency.

Best regards,
Yoshihiro Shimoda

> David Daney
> 

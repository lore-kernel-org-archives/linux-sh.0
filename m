From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Apr 2013 16:54:38 +0000
Subject: Re: [PATCH v2 2/9] ehci-platform: add pre_setup() method to platform data
Message-Id: <516447CE.3020308@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/09/2013 07:27 PM, Alan Stern wrote:

>
>>>>>> --- renesas.orig/include/linux/usb/ehci_pdriver.h
>>>>>> +++ renesas/include/linux/usb/ehci_pdriver.h
>>>>>> @@ -19,6 +19,8 @@
>>>>>>    #ifndef __USB_CORE_EHCI_PDRIVER_H
>>>>>>    #define __USB_CORE_EHCI_PDRIVER_H
>>>>>> +#include <linux/usb/hcd.h>
>>>>> This isn't needed in the .h file, right?  Only the .c file, if it hasn't
>>>>> already included it (hint, I bet it has...)
>>>>      No, it hasn't. And I wouldn't want to include this header in the
>>>> platform code.
>>> Then you don't need it in this .h file either, please remove it.
>>       I do need it in the platform .c file. Well, long live multiple
>> redeclarations
>> of the same thing!
> If you do remove that line from ehci_pdriver.h, you should add a
> declaration of struct usb_hcd.  Like this:
>
> struct usb_hcd;
>
> Otherwise the compiler will complain when it sees this structure
> mentioned for the first time in the parameter list of a
> function-pointer declaration.

    That's what I did, thanks. I've also added 'struct platform_device;' 
line for the same reason.

> Alan Stern
>
WBR, Sergei


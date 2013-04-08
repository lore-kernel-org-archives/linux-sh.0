From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 08 Apr 2013 22:04:56 +0000
Subject: Re: [PATCH v2 2/9] ehci-platform: add pre_setup() method to platform data
Message-Id: <51633F08.2050705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/09/2013 01:51 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 04/09/2013 01:26 AM, Greg KH wrote:
>
>>
>>> Sometimes there is a need  to initialize some non-standard registers 
>>> mapped to
>>> the EHCI region before accessing the standard EHCI registers. Add 
>>> pre_setup()
>>> method with 'struct usb_hcd *' parameter to be called just before 
>>> ehci_setup()
>>> to the 'ehci-platform'  driver's platform data for this purpose...
>>>
>>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
> [...]
>>> Index: renesas/include/linux/usb/ehci_pdriver.h
>>> =================================>>> --- renesas.orig/include/linux/usb/ehci_pdriver.h
>>> +++ renesas/include/linux/usb/ehci_pdriver.h
>>> @@ -19,6 +19,8 @@
>>>   #ifndef __USB_CORE_EHCI_PDRIVER_H
>>>   #define __USB_CORE_EHCI_PDRIVER_H
>>>   +#include <linux/usb/hcd.h>
>> This isn't needed in the .h file, right?  Only the .c file, if it hasn't
>> already included it (hint, I bet it has...)
>
>    No, it hasn't. And I wouldn't want to include this header in the
> platform code.

    Although, if you insist...

    It just occured to me that this file doesn't have 'struct 
platform_device'
pre-declared either -- in the "best" tradition of the USB header files. :-)

WBR, Sergei


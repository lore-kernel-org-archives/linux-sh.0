From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 09 Apr 2013 15:27:46 +0000
Subject: Re: [PATCH v2 2/9] ehci-platform: add pre_setup() method to platform data
Message-Id: <Pine.LNX.4.44L0.1304091125430.1573-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 9 Apr 2013, Sergei Shtylyov wrote:

> >>>> --- renesas.orig/include/linux/usb/ehci_pdriver.h
> >>>> +++ renesas/include/linux/usb/ehci_pdriver.h
> >>>> @@ -19,6 +19,8 @@
> >>>>   #ifndef __USB_CORE_EHCI_PDRIVER_H
> >>>>   #define __USB_CORE_EHCI_PDRIVER_H
> >>>> +#include <linux/usb/hcd.h>
> >>> This isn't needed in the .h file, right?  Only the .c file, if it hasn't
> >>> already included it (hint, I bet it has...)
> >>     No, it hasn't. And I wouldn't want to include this header in the
> >> platform code.
> > Then you don't need it in this .h file either, please remove it.
> 
>      I do need it in the platform .c file. Well, long live multiple 
> redeclarations
> of the same thing!

If you do remove that line from ehci_pdriver.h, you should add a
declaration of struct usb_hcd.  Like this:

struct usb_hcd;

Otherwise the compiler will complain when it sees this structure
mentioned for the first time in the parameter list of a
function-pointer declaration.

Alan Stern


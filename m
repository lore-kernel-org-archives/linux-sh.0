From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2013 21:26:42 +0000
Subject: Re: [PATCH v2 2/9] ehci-platform: add pre_setup() method to platform data
Message-Id: <20130408212642.GA25235@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304090120.00626.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 01:20:00AM +0400, Sergei Shtylyov wrote:
> Sometimes there is a need  to initialize some non-standard registers mapped to
> the EHCI region before accessing the standard EHCI registers.  Add pre_setup()
> method with 'struct usb_hcd *' parameter to be called just before ehci_setup()
> to the 'ehci-platform'  driver's platform data for this purpose...
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes since the original posting:
> - changed init() method to pre_setup() with different parameters abd call site.
> 
>  drivers/usb/host/ehci-platform.c |    6 ++++++
>  include/linux/usb/ehci_pdriver.h |    3 +++
>  2 files changed, 9 insertions(+)
> 
> Index: renesas/drivers/usb/host/ehci-platform.c
> =================================> --- renesas.orig/drivers/usb/host/ehci-platform.c
> +++ renesas/drivers/usb/host/ehci-platform.c
> @@ -46,6 +46,12 @@ static int ehci_platform_reset(struct us
>  	ehci->big_endian_desc = pdata->big_endian_desc;
>  	ehci->big_endian_mmio = pdata->big_endian_mmio;
>  
> +	if (pdata->pre_setup) {
> +		retval = pdata->pre_setup(hcd);
> +		if (retval < 0)
> +			return retval;
> +	}
> +
>  	ehci->caps = hcd->regs + pdata->caps_offset;
>  	retval = ehci_setup(hcd);
>  	if (retval)
> Index: renesas/include/linux/usb/ehci_pdriver.h
> =================================> --- renesas.orig/include/linux/usb/ehci_pdriver.h
> +++ renesas/include/linux/usb/ehci_pdriver.h
> @@ -19,6 +19,8 @@
>  #ifndef __USB_CORE_EHCI_PDRIVER_H
>  #define __USB_CORE_EHCI_PDRIVER_H
>  
> +#include <linux/usb/hcd.h>

This isn't needed in the .h file, right?  Only the .c file, if it hasn't
already included it (hint, I bet it has...)

thanks,

greg k-h

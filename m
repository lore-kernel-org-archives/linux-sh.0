From: Peter Chen <Peter.Chen@freescale.com>
Date: Wed, 17 Dec 2014 02:08:34 +0000
Subject: RE: [PATCH] usb: hcd: add OTG ID signal sensing
Message-Id: <BN3PR0301MB08495DD76B65E14BDE460E42816D0@BN3PR0301MB0849.namprd03.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3663198.HSrURZGche@wasted.cogentembedded.com>
In-Reply-To: <3663198.HSrURZGche@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

 
> 
> On the Renesas R8A7791 SoC based boards there's MAX3355 USB OTG chip and
> mini-AB USB connector corresponding to USB port 0 driven either by EHCI/OHCI
> or  Renesas USBHS gadget controller. And we'd like the  host/gadget drivers to
> work based on the cable type connected. An 'extcon' driver for MAX3355 has
> been written, so we only need to bind  to it via device tree which I'm doing in
> this patch.
> 
> I wasn't able to find a solution better than checking the cable type at the host
> driver probe time and refusing to drive a host if B-cable is connected.
> 

You may need a dual-role/otg driver to do it, which can enable host/device function
according to ID pin.

Peter

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.
> It needs the recent 'extcon' core in order to properly handle probe deferral.
> 
>  drivers/usb/core/hcd.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> Index: usb/drivers/usb/core/hcd.c
> ==============================
> ===> --- usb.orig/drivers/usb/core/hcd.c
> +++ usb/drivers/usb/core/hcd.c
> @@ -42,6 +42,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/types.h>
> 
> +#include <linux/extcon.h>
>  #include <linux/phy/phy.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -2632,6 +2633,23 @@ int usb_add_hcd(struct usb_hcd *hcd,
>  	int retval;
>  	struct usb_device *rhdev;
> 
> +	if (IS_ENABLED(CONFIG_EXTCON) &&
> +	    of_property_read_bool(hcd->self.controller->of_node, "extcon")) {
> +		struct extcon_dev *edev;
> +
> +		edev = extcon_get_edev_by_phandle(hcd->self.controller, 0);
> +		if (IS_ERR(edev))
> +			return PTR_ERR(edev);
> +
> +		retval = extcon_get_cable_state(edev, "USB-HOST");
> +		if (!retval) {
> +			dev_err(hcd->self.controller,
> +				"OTG B-cable plugged in, host driver won't
> load\n");
> +			return -EINVAL;
> +		} else if (retval < 0)
> +			return retval;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->usb_phy) {
>  		struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller,
> 0);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

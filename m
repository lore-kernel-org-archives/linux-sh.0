From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 28 May 2014 20:26:07 +0000
Subject: Re: [PATCH v2 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <20140528202607.GA7537@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5385C71D.5060509@renesas.com>
In-Reply-To: <5385C71D.5060509-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, May 28, 2014 at 08:23:09PM +0900, Yoshihiro Shimoda wrote:
> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> some specific initializations related to the firmware downloading and
> some specific registers. This patch adds the support for this special
> configuration as an xHCI quirk executed during probe and start.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/host/Kconfig     |    8 +++
>  drivers/usb/host/Makefile    |    3 +
>  drivers/usb/host/xhci-plat.c |   18 +++++
>  drivers/usb/host/xhci-rcar.c |  160 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-rcar.h |   27 +++++++
>  5 files changed, 216 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-rcar.c
>  create mode 100644 drivers/usb/host/xhci-rcar.h
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 61b7817..537d9e1 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -37,6 +37,14 @@ config USB_XHCI_MVEBU
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Marvell Armada 375/38x ARM SOCs.
> 
> +config USB_XHCI_RCAR
> +	tristate "xHCI support for Renesas R-Car SoCs"
> +	select USB_XHCI_PLATFORM
> +	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	---help---
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	  found in Renesas R-Car ARM SoCs.
> +
>  endif # USB_XHCI_HCD
> 
>  config USB_EHCI_HCD
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index af89a90..144c038 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -22,6 +22,9 @@ ifneq ($(CONFIG_USB_XHCI_PLATFORM), )
>  ifneq ($(CONFIG_USB_XHCI_MVEBU), )
>  	xhci-hcd-y		+= xhci-mvebu.o
>  endif
> +ifneq ($(CONFIG_USB_XHCI_RCAR), )
> +	xhci-hcd-y		+= xhci-rcar.o
> +endif
>  endif
> 
>  obj-$(CONFIG_USB_WHCI_HCD)	+= whci/
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 1389370..7c714c1 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -21,6 +21,7 @@
> 
>  #include "xhci.h"
>  #include "xhci-mvebu.h"
> +#include "xhci-rcar.h"
> 
>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>  {
> @@ -40,6 +41,12 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
> 
>  static int xhci_plat_start(struct usb_hcd *hcd)
>  {
> +	struct device_node *of_node = hcd->self.controller->of_node;
> +
> +	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
> +	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
> +		xhci_rcar_start(hcd);
> +
>  	return xhci_run(hcd);
>  }
> 
> @@ -181,6 +188,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  			goto disable_phy;
>  	}
> 
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "renesas,xhci-r8a7790") ||
> +	    of_device_is_compatible(pdev->dev.of_node,
> +				    "renesas,xhci-r8a7791")) {
> +		ret = xhci_rcar_init_quirk(pdev);
> +		if (ret)
> +			goto power_off_phy;
> +	}
> +
>  	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (ret)
>  		goto power_off_phy;
> @@ -295,6 +311,8 @@ static const struct of_device_id usb_xhci_of_match[] = {
>  	{ .compatible = "xhci-platform" },
>  	{ .compatible = "marvell,armada-375-xhci"},
>  	{ .compatible = "marvell,armada-380-xhci"},
> +	{ .compatible = "renesas,xhci-r8a7790"},
> +	{ .compatible = "renesas,xhci-r8a7791"},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> new file mode 100644
> index 0000000..233726b
> --- /dev/null
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -0,0 +1,160 @@
> +/*
> + * xHCI host controller driver for R-Car SoCs
> + *
> + * Copyright (C) 2014 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/phy.h>
> +
> +#include "xhci.h"
> +#include "xhci-rcar.h"
> +
> +#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem"

Shouldn't you also add a:
	MODULE_FIRMWARE(FIRMWARE_NAME);
line to this file so that the automatic tools can pick it up properly?

thanks,

greg k-h

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 19 May 2014 12:14:52 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <5379F5BC.6010204@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com>
In-Reply-To: <5379D805.3070002@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, mathias.nyman@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello.

On 19-05-2014 14:08, Yoshihiro Shimoda wrote:

> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> some specific initilization related to the firmware downloading and
> some specific registers. This patch adds the support for this special
> configuration as an xHCI quirk executed during probe and start.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[...]

> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 561d07e..3a2da1f 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -20,6 +20,7 @@
>
>   #include "xhci.h"
>   #include "xhci-mvebu.h"
> +#include "xhci-rcar.h"
>
>   static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>   {
> @@ -39,6 +40,12 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
>
>   static int xhci_plat_start(struct usb_hcd *hcd)
>   {
> +	struct device_node *of_node = hcd->self.controller->of_node;
> +
> +	if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
> +	    of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))

    Perhaps "renesas,r8a7791-xhci"?

> +		xhci_rcar_start(hcd);
> +
>   	return xhci_run(hcd);
>   }
>
[...]
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> new file mode 100644
> index 0000000..3c0bfae
> --- /dev/null
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -0,0 +1,182 @@
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
> +
> +/*** Register Offset ***/
> +#define RCAR_USB3_INT_ENA	0x224	/* Interrupt Enable */
> +#define RCAR_USB3_DL_CTRL	0x250	/* FW Download Control & Status */
> +#define RCAR_USB3_FW_DATA0	0x258	/* FW Data0 */
> +
> +#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
> +#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */
> +#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */
> +#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */
> +#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
> +#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */
> +
> +/*** Register Settings ***/
> +/* Interrupt Enable */
> +#define RCAR_USB3_INT_XHC_ENA	0x00000001
> +#define RCAR_USB3_INT_PME_ENA	0x00000002
> +#define RCAR_USB3_INT_HSE_ENA	0x00000004
> +#define RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \
> +				RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA)
> +
> +/* FW Download Control & Status */
> +#define RCAR_USB3_DL_CTRL		0x250

    Already #define'd.

> +/* USB3.0 Configuraion */

    Configuration.

> +int xhci_rcar_start(struct usb_hcd *hcd)
> +{
> +	if (hcd->regs != NULL) {
> +		u32 temp;

    Need empty line here... and should perhaps return error if hcd->regs NULL?

> +		/* Interrupt Enable */
> +		temp = readl(hcd->regs + RCAR_USB3_INT_ENA);
> +		temp |= RCAR_USB3_INT_ENA_VAL;
> +		writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
> +		/* LCLK Select */
> +		writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK);
> +		/* USB3.0 Configuration */
> +		writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CONF1);
> +		writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CONF2);
> +		writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CONF3);
> +		/* USB3.0 Polariy */
> +		writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL);
> +		writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL);
> +	}
> +
> +	return 0;
> +}
[...]

WBR, Sergei


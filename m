From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 05 Feb 2016 04:48:30 +0000
Subject: RE: [PATCH] usb: renesas_usbhs: add R-Car Gen3 power control
Message-Id: <SG2PR06MB0919282B7AFDF04DBBA8BE4BD8D20@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Felipe,
(I changed your email address)

Would you review this patch?
I checked that I could apply this patch to the latest Felipe's usb.git / testing/next branch correctly.
(the commit id = 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3)

P.S.
I will submit a patch for this driver (but it doesn't depend on this patch) soon.

Best regards,
Yoshihiro Shimoda

> -----Original Message-----
> From: Yoshihiro Shimoda
> Sent: Thursday, January 07, 2016 6:18 PM
> To: gregkh@linuxfoundation.org; balbi@ti.com
> Cc: linux-usb@vger.kernel.org; linux-sh@vger.kernel.org; Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Subject: [PATCH] usb: renesas_usbhs: add R-Car Gen3 power control
> 
> Since the usb2 phy driver for gen3 (phy-rcar-gen3-usb2) cannot access
> LPSTS and UGCTRL2 registers in the HSUSB module, this driver have to
> initialize the registers. So, this patch adds such handling code into
> rcar3.c.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the latest Felipe's usb.git / testing/next branch.
>  (commit id = 5072cfc40a80cea3749fd3413b3896630d8c787e)
> 
>  drivers/usb/renesas_usbhs/Makefile |  2 +-
>  drivers/usb/renesas_usbhs/common.c | 14 +++++++---
>  drivers/usb/renesas_usbhs/rcar3.c  | 54 ++++++++++++++++++++++++++++++++++++++
>  drivers/usb/renesas_usbhs/rcar3.h  |  3 +++
>  include/linux/usb/renesas_usbhs.h  |  1 +
>  5 files changed, 69 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/usb/renesas_usbhs/rcar3.c
>  create mode 100644 drivers/usb/renesas_usbhs/rcar3.h
> 
> diff --git a/drivers/usb/renesas_usbhs/Makefile b/drivers/usb/renesas_usbhs/Makefile
> index 9e47f47..d787d05 100644
> --- a/drivers/usb/renesas_usbhs/Makefile
> +++ b/drivers/usb/renesas_usbhs/Makefile
> @@ -4,7 +4,7 @@
> 
>  obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs.o
> 
> -renesas_usbhs-y			:= common.o mod.o pipe.o fifo.o rcar2.o
> +renesas_usbhs-y			:= common.o mod.o pipe.o fifo.o rcar2.o rcar3.o
> 
>  ifneq ($(CONFIG_USB_RENESAS_USBHS_HCD),)
>  	renesas_usbhs-y		+= mod_host.o
> diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> index 5af9ca5..baeb7d2 100644
> --- a/drivers/usb/renesas_usbhs/common.c
> +++ b/drivers/usb/renesas_usbhs/common.c
> @@ -25,6 +25,7 @@
>  #include <linux/sysfs.h>
>  #include "common.h"
>  #include "rcar2.h"
> +#include "rcar3.h"
> 
>  /*
>   *		image of renesas_usbhs
> @@ -477,18 +478,16 @@ static const struct of_device_id usbhs_of_match[] = {
>  		.data = (void *)USBHS_TYPE_RCAR_GEN2,
>  	},
>  	{
> -		/* Gen3 is compatible with Gen2 */
>  		.compatible = "renesas,usbhs-r8a7795",
> -		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> +		.data = (void *)USBHS_TYPE_RCAR_GEN3,
>  	},
>  	{
>  		.compatible = "renesas,rcar-gen2-usbhs",
>  		.data = (void *)USBHS_TYPE_RCAR_GEN2,
>  	},
>  	{
> -		/* Gen3 is compatible with Gen2 */
>  		.compatible = "renesas,rcar-gen3-usbhs",
> -		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> +		.data = (void *)USBHS_TYPE_RCAR_GEN3,
>  	},
>  	{ },
>  };
> @@ -578,6 +577,13 @@ static int usbhs_probe(struct platform_device *pdev)
>  			priv->dparam.pipe_size = ARRAY_SIZE(usbhsc_new_pipe);
>  		}
>  		break;
> +	case USBHS_TYPE_RCAR_GEN3:
> +		priv->pfunc = usbhs_rcar3_ops;
> +		if (!priv->dparam.pipe_configs) {
> +			priv->dparam.pipe_configs = usbhsc_new_pipe;
> +			priv->dparam.pipe_size = ARRAY_SIZE(usbhsc_new_pipe);
> +		}
> +		break;
>  	default:
>  		if (!info->platform_callback.get_id) {
>  			dev_err(&pdev->dev, "no platform callbacks");
> diff --git a/drivers/usb/renesas_usbhs/rcar3.c b/drivers/usb/renesas_usbhs/rcar3.c
> new file mode 100644
> index 0000000..38b01f2
> --- /dev/null
> +++ b/drivers/usb/renesas_usbhs/rcar3.c
> @@ -0,0 +1,54 @@
> +/*
> + * Renesas USB driver R-Car Gen. 3 initialization and power control
> + *
> + * Copyright (C) 2016 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/io.h>
> +#include "common.h"
> +#include "rcar3.h"
> +
> +#define LPSTS		0x102
> +#define UGCTRL2		0x184	/* 32-bit register */
> +
> +/* Low Power Status register (LPSTS) */
> +#define LPSTS_SUSPM	0x4000
> +
> +/* USB General control register 2 (UGCTRL2), bit[31:6] should be 0 */
> +#define UGCTRL2_RESERVED_3	0x00000001	/* bit[3:0] should be B'0001 */
> +#define UGCTRL2_USB0SEL_OTG	0x00000030
> +
> +void usbhs_write32(struct usbhs_priv *priv, u32 reg, u32 data)
> +{
> +	iowrite32(data, priv->base + reg);
> +}
> +
> +static int usbhs_rcar3_power_ctrl(struct platform_device *pdev,
> +				void __iomem *base, int enable)
> +{
> +	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
> +
> +	usbhs_write32(priv, UGCTRL2, UGCTRL2_RESERVED_3 | UGCTRL2_USB0SEL_OTG);
> +
> +	if (enable)
> +		usbhs_bset(priv, LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
> +	else
> +		usbhs_bset(priv, LPSTS, LPSTS_SUSPM, 0);
> +
> +	return 0;
> +}
> +
> +static int usbhs_rcar3_get_id(struct platform_device *pdev)
> +{
> +	return USBHS_GADGET;
> +}
> +
> +const struct renesas_usbhs_platform_callback usbhs_rcar3_ops = {
> +	.power_ctrl = usbhs_rcar3_power_ctrl,
> +	.get_id = usbhs_rcar3_get_id,
> +};
> diff --git a/drivers/usb/renesas_usbhs/rcar3.h b/drivers/usb/renesas_usbhs/rcar3.h
> new file mode 100644
> index 0000000..5f850b2
> --- /dev/null
> +++ b/drivers/usb/renesas_usbhs/rcar3.h
> @@ -0,0 +1,3 @@
> +#include "common.h"
> +
> +extern const struct renesas_usbhs_platform_callback usbhs_rcar3_ops;
> diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
> index 4db191f..00a47d0 100644
> --- a/include/linux/usb/renesas_usbhs.h
> +++ b/include/linux/usb/renesas_usbhs.h
> @@ -184,6 +184,7 @@ struct renesas_usbhs_driver_param {
>  };
> 
>  #define USBHS_TYPE_RCAR_GEN2	1
> +#define USBHS_TYPE_RCAR_GEN3	2
> 
>  /*
>   * option:
> --
> 1.9.1


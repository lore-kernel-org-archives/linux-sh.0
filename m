From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 15 Feb 2015 16:06:42 +0000
Subject: Re: [PATCH v2] sh-pfc: add R8A7794 PFC support
Message-Id: <1974835.KMEIIiPVsr@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <5262485.fuAdzVmykl@wasted.cogentembedded.com>
In-Reply-To: <5262485.fuAdzVmykl@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Thursday 12 February 2015 00:01:18 Sergei Shtylyov wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Add PFC support for  the  R8A7794 SoC  including pin groups for some on-chip
> devices such as ETH, I2C, INTC, MSIOF, QSPI, [H]SCIF...
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [Sergei: squashed together several patches, fixed the MLB_CLK typo, added
> IRQ4.. IRQ9 pin groups,  fixed IRQn comments, added ETH B pin group names,
> removed stray new line and fixed typos in the  comments in the
> pinmux_config_regs[] initializer, added reasonable and removed unreasonable
> copyrights, modified the bindings document, renamed, added changelog.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
> Changes in version 2:
> - rebased the patch.
> 
>  Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    1
>  drivers/pinctrl/sh-pfc/Kconfig                                    |    5
>  drivers/pinctrl/sh-pfc/Makefile                                   |    1
>  drivers/pinctrl/sh-pfc/core.c                                     |    9
>  drivers/pinctrl/sh-pfc/core.h                                     |    1
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c                              | 3989 ++
>  6 files changed, 4006 insertions(+)

[snip]

> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/core.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/core.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/core.c
> @@ -481,6 +481,12 @@ static const struct of_device_id sh_pfc_
>  		.data = &r8a7791_pinmux_info,
>  	},
>  #endif
> +#ifdef CONFIG_PINCTRL_PFC_R8A7794
> +	{
> +		.compatible = "renesas,pfc-r8a7794",
> +		.data = &r8a7794_pinmux_info,
> +	},
> +#endif
>  #ifdef CONFIG_PINCTRL_PFC_SH73A0
>  	{
>  		.compatible = "renesas,pfc-sh73a0",
> @@ -600,6 +606,9 @@ static const struct platform_device_id s
>  #ifdef CONFIG_PINCTRL_PFC_R8A7791
>  	{ "pfc-r8a7791", (kernel_ulong_t)&r8a7791_pinmux_info },
>  #endif
> +#ifdef CONFIG_PINCTRL_PFC_R8A7794
> +	{ "pfc-r8a7794", (kernel_ulong_t)&r8a7794_pinmux_info },

R-Car E2 is DT-only, so there's no need for a platform_device_id entry.

> +#endif
>  #ifdef CONFIG_PINCTRL_PFC_SH7203
>  	{ "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
>  #endif

[snip]

> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> =================================> --- /dev/null
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> @@ -0,0 +1,3989 @@
> +/*
> + * r8a7794 processor support - PFC hardware block.
> + *
> + * Copyright (C) 2014 Renesas Electronics Corporation
> + * Copyright (C) 2015 Renesas Solutions Corp.
> + * Copyright (C) 2015 Cogent  Embedded, Inc., <source@cogentembedded.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_data/gpio-rcar.h>
> +
> +#include "core.h"
> +#include "sh_pfc.h"
> +
> +#define CPU_ALL_PORT(fn, sfx)						\
> +	PORT_GP_32(0, fn, sfx),						\
> +	PORT_GP_32(1, fn, sfx),						\
> +	PORT_GP_32(2, fn, sfx),						\
> +	PORT_GP_32(3, fn, sfx),						\
> +	PORT_GP_32(4, fn, sfx),						\
> +	PORT_GP_32(5, fn, sfx),						\
> +	PORT_GP_32(6, fn, sfx)

If I'm not mistaken port GP1 has 26 pins only, GP5 28 pins and GP6 26 pins.

[snip]

I haven't checked all pins in details, but the pin groups look sensible to me.

-- 
Regards,

Laurent Pinchart


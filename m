From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 28 Aug 2015 19:23:08 +0000
Subject: Re: [PATCH 1/2][RFC] pinctrl: sh-pfc: Initial R8A7795 PFC support
Message-Id: <15835467.TaO4P3MKAU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com> <87bndrdan7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bndrdan7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello Morimoto-san,

Thank you for the patch.

On Friday 28 August 2015 09:32:53 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Add PFC base support for the R8A7795 SoC.
> It is including IPSRx / MOD_SELx only
> 
> Original patch was created by Takeshi Kihara, and
> Kuninori Morimoto updated it.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/pinctrl/sh-pfc/Kconfig       |    5 +
>  drivers/pinctrl/sh-pfc/Makefile      |    1 +
>  drivers/pinctrl/sh-pfc/core.c        |    6 +
>  drivers/pinctrl/sh-pfc/core.h        |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 1499 +++++++++++++++++++++++++++++++
>  5 files changed, 1512 insertions(+)
>  create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a7795.c

[snip]

> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c new file mode 100644
> index 0000000..23f2c4e
> --- /dev/null
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> @@ -0,0 +1,1499 @@
> +/*
> + * R-Car Gen3 processor support - PFC hardware block.
> + *
> + * Copyright (C) 2015  Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
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
> +	PORT_GP_32(6, fn, sfx),						\
> +	PORT_GP_32(7, fn, sfx)

Not all GPIO banks include 32 pins. From a quick look at the datasheet the 
following GPIO pins are available.

GP0       0-15
GP1       0-27
GP2       0-14
GP3       0-15
GP4       0-17
GP5       0-25
GP6       0-31
GP7       0-3

[snip]

> +static const struct pinmux_cfg_reg pinmux_config_regs[] = {

[snip]

> +	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
> +			     2, 3, 1, 2, 3, 1, 1, 2, 1,
> +			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
> +		/* SEL_TSIF1 [2] */
> +		FN_SEL_TSIF1_0,		FN_SEL_TSIF1_1,
> +		FN_SEL_TSIF1_2,		FN_SEL_TSIF1_3,
> +		/* SEL_TSIF0 [3] */
> +		FN_SEL_TSIF0_0,		FN_SEL_TSIF0_1,
> +		FN_SEL_TSIF0_2,		FN_SEL_TSIF0_3,
> +		FN_SEL_TSIF0_4,		FN_SEL_TSIF0_5,
> +		FN_SEL_TSIF0_6,		FN_SEL_TSIF0_7,
> +		/* SEL_TIMER_TM	 [1] */
> +		FN_SEL_TIMER_TMU_0,	FN_SEL_TIMER_TMU_1,
> +		/* SEL_SSP1_1 [2] */
> +		FN_SEL_SSP1_1_0,	FN_SEL_SSP1_1_1,
> +		FN_SEL_SSP1_1_2,	FN_SEL_SSP1_1_3,
> +		/* SEL_SSP1_0 [3] */
> +		FN_SEL_SSP1_0_0,	FN_SEL_SSP1_0_1,
> +		FN_SEL_SSP1_0_2,	FN_SEL_SSP1_0_3,
> +		FN_SEL_SSP1_0_4,	FN_SEL_SSP1_0_5,
> +		FN_SEL_SSP1_0_6,	FN_SEL_SSP1_0_7,
> +		/* SEL_SSI [1] */
> +		FN_SEL_SSI_0,		FN_SEL_SSI_1,
> +		/* SEL_SPEED_PULSE [1] */
> +		FN_SEL_SPEED_PULSE_0,	FN_SEL_SPEED_PULSE_1,
> +		/* SEL_SIMCARD [2] */
> +		FN_SEL_SIMCARD_0,	FN_SEL_SIMCARD_1,
> +		FN_SEL_SIMCARD_2,	FN_SEL_SIMCARD_3,
> +		/* SEL_SDHI2 [1] */
> +		FN_SEL_SDHI2_0,		FN_SEL_SDHI2_1,
> +		/* SEL_SCIF4 [2] */
> +		FN_SEL_SCIF4_0,		FN_SEL_SCIF4_1,
> +		FN_SEL_SCIF4_2,		FN_SEL_SCIF4_3,
> +		/* SEL_SCIF3 [1] */
> +		FN_SEL_SCIF3_0,		FN_SEL_SCIF3_1,
> +		/* SEL_SCIF2 [1] */
> +		FN_SEL_SCIF2_0,		FN_SEL_SCIF2_1,
> +		/* SEL_SCIF1 [1] */
> +		FN_SEL_SCIF1_0,		FN_SEL_SCIF1_1,
> +		/* SEL_SCIF [1] */
> +		FN_SEL_SCIF_0,		FN_SEL_SCIF_1,
> +		/* SEL_REMOCON [1] */
> +		FN_SEL_REMOCON_0,	FN_SEL_REMOCON_1,
> +		/* RESERVED [2] */
> +		0, 0, 0, 0,

According to the datasheet those two bits are supposed to control the RDS 
clock and data pins (whatever they are).

> +		/* SEL_RCAN0 [1] */
> +		FN_SEL_RCAN0_0,		FN_SEL_RCAN0_1,
> +		/* SEL_PWM6 [1] */
> +		FN_SEL_PWM6_0,		FN_SEL_PWM6_1,
> +		/* SEL_PWM5 [1] */
> +		FN_SEL_PWM5_0,		FN_SEL_PWM5_1,
> +		/* SEL_PWM4 [1] */
> +		FN_SEL_PWM4_0,		FN_SEL_PWM4_1,
> +		/* SEL_PWM3 [1] */
> +		FN_SEL_PWM3_0,		FN_SEL_PWM3_1,
> +		/* SEL_PWM2 [1] */
> +		FN_SEL_PWM2_0,		FN_SEL_PWM2_1,
> +		/* SEL_PWM1 [1] */
> +		FN_SEL_PWM1_0,		FN_SEL_PWM1_1, }
> +	},

[snip]

The rest looks good to me.

-- 
Regards,

Laurent Pinchart


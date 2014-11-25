From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Nov 2014 09:51:50 +0000
Subject: Re: [PATCH v2 3/6] ARM: shmobile: r8a73a4: Add CPG register bits header
Message-Id: <2864773.2PhLac3zxv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1416500496-21024-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1416500496-21024-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 20 November 2014 17:21:33 Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  include/dt-bindings/clock/r8a73a4-clock.h | 62 ++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h
> 
> diff --git a/include/dt-bindings/clock/r8a73a4-clock.h
> b/include/dt-bindings/clock/r8a73a4-clock.h new file mode 100644
> index 0000000..cbc1abf
> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a73a4-clock.h
> @@ -0,0 +1,62 @@
> +/*
> + * Copyright 2014 Ulrich Hecht
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_R8A73A4_H__
> +#define __DT_BINDINGS_CLOCK_R8A73A4_H__
> +
> +/* CPG */
> +#define R8A73A4_CLK_PLL0	0
> +#define R8A73A4_CLK_PLL1	1
> +#define R8A73A4_CLK_PLL2	2
> +#define R8A73A4_CLK_PLL2S	3
> +#define R8A73A4_CLK_PLL2H	4
> +#define R8A73A4_CLK_MAIN	5

The indices don't match the DT bindings, where the main clock is listed first.

> +#define R8A73A4_CLK_Z		6
> +#define R8A73A4_CLK_Z2		7
> +#define R8A73A4_CLK_I		8
> +#define R8A73A4_CLK_M3		9
> +#define R8A73A4_CLK_B		10
> +#define R8A73A4_CLK_M1		11
> +#define R8A73A4_CLK_M2		12
> +#define R8A73A4_CLK_ZX		13
> +#define R8A73A4_CLK_ZS		14
> +#define R8A73A4_CLK_HP		15
> +
> +/* MSTP2 */
> +#define R8A73A4_CLK_SCIFA0	4
> +#define R8A73A4_CLK_SCIFA1	3

Could you please keep lines sorted by numerical value, and possibly in 
descending order, to match the order from the datasheet ? That would make 
review easier.

> +#define R8A73A4_CLK_SCIFB0	6
> +#define R8A73A4_CLK_SCIFB1	7
> +#define R8A73A4_CLK_SCIFB2	16
> +#define R8A73A4_CLK_SCIFB3	17
> +#define R8A73A4_CLK_DMAC	18
> +
> +/* MSTP3 */
> +#define R8A73A4_CLK_IIC2	0
> +#define R8A73A4_CLK_MMCIF1	5

MMCIF1 and MMCIF0 are called MMC1 and MMC0 in the datasheet.

> +#define R8A73A4_CLK_SDHI2	12
> +#define R8A73A4_CLK_SDHI1	13
> +#define R8A73A4_CLK_SDHI0	14
> +#define R8A73A4_CLK_MMCIF0	15
> +#define R8A73A4_CLK_IIC6	16
> +#define R8A73A4_CLK_IIC7	17
> +#define R8A73A4_CLK_IIC0	18
> +#define R8A73A4_CLK_IIC1	23
> +#define R8A73A4_CLK_CMT1	29
> +
> +/* MSTP4 */
> +#define R8A73A4_CLK_IIC5	9
> +#define R8A73A4_CLK_IIC4	10
> +#define R8A73A4_CLK_IIC3	11
> +
> +/* MSTP5 */
> +#define R8A73A4_CLK_THERMAL	22
> +#define R8A73A4_CLK_IIC8	15
> +
> +#endif /* __DT_BINDINGS_CLOCK_R8A73A4_H__ */

-- 
Regards,

Laurent Pinchart


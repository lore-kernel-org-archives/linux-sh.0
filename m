From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Feb 2010 23:25:16 +0000
Subject: Re: [PATCH 2/4] sh: separate DMA headers, used by the legacy and the dmaengine drivers
Message-Id: <20100203232516.GB21857@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 03, 2010 at 04:03:50PM +0100, Guennadi Liakhovetski wrote:
> diff --git a/arch/sh/include/asm/dma-common.h b/arch/sh/include/asm/dma-common.h
> new file mode 100644
> index 0000000..a3456f4
> --- /dev/null
> +++ b/arch/sh/include/asm/dma-common.h
[snip]

> +#define CHCR_DE 0x00000001
> +#define CHCR_TE 0x00000002
> +#define CHCR_IE 0x00000004
> +
> +#include <cpu/dma-register.h>
> +
> +#endif

The easier option would be to rename dma-common.h to dma-register.h,
which would bring it in line with what it's actually pulling in from cpu/.

Even then, these definitions are specific to Hitachi/Renesas-style
on-chip DMACs, so they're not really common across the architecture (this
is why we have dma-sh.h instead of stashing everything in dma.h, although
in retrospect I could have chosen a better name).

> diff --git a/arch/sh/include/asm/sh-dmaengine.h b/arch/sh/include/asm/sh-dmaengine.h
> new file mode 100644
> index 0000000..e127ce5
> --- /dev/null
> +++ b/arch/sh/include/asm/sh-dmaengine.h
> @@ -0,0 +1,71 @@
> +/*
> + * Header for the new SH dmaengine driver
> + *
> + * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef SH_DMAENGINE_H
> +#define SH_DMAENGINE_H
> +

Lets just call this asm/dmaengine.h for now. If more dmaengine drivers
come along that want to fight over the namespace, we can shuffle things
around as necessary then.

> +#include <asm/dma-common.h>
> +
> +#define SH_DMAC_MAX_CHANNELS	6
> +
> +/* SuperH DMA mode */
> +#define SHDMA_MIX_IRQ	(1 << 0)
> +
With the IRQs being passed through platform data, there shouldn't be any
need for this anymore. If the driver wants to use it internally for
differentiating between muxed vs split out IRQs that's fine, but the
platform data shouldn't care.

> diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
> new file mode 100644
> index 0000000..ed9c469
> --- /dev/null
> +++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
> @@ -0,0 +1,40 @@
> +/*
> + * SH3 CPU-specific DMA definitions, used by both DMA drivers
> + *
> + * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef DMA_REGISTER_H
> +#define DMA_REGISTER_H
> +
> +#define CHCR_TS_LOW_MASK	0x18
> +#define CHCR_TS_LOW_SHIFT	3
> +#define CHCR_TS_HIGH_MASK	0
> +#define CHCR_TS_HIGH_SHIFT	0
> +
> +#define DMAOR_INIT	DMAOR_DME
> +
These should all be part of the platform data.

> +/*
> + * The SuperH DMAC supports a number of transmit sizes, we list them here,
> + * with their respective values as they appear in the CHCR registers.
> + */
> +enum {
> +	XMIT_SZ_8BIT,
> +	XMIT_SZ_16BIT,
> +	XMIT_SZ_32BIT,
> +	XMIT_SZ_128BIT,
> +};
> +
> +#define TS_SHIFT {			\
> +	[XMIT_SZ_8BIT]		= 0,	\
> +	[XMIT_SZ_16BIT]		= 1,	\
> +	[XMIT_SZ_32BIT]		= 2,	\
> +	[XMIT_SZ_128BIT]	= 4,	\
> +}
> +
> +#define TS_INDEX2VAL(i)	(((i) & 3) << CHCR_TS_LOW_SHIFT)
> +
If we compare the simple case with .. 

> +/* Transmit sizes and respective CHCR register values */
> +enum {
> +	XMIT_SZ_8BIT		= 0,
> +	XMIT_SZ_16BIT		= 1,
> +	XMIT_SZ_32BIT		= 2,
> +	XMIT_SZ_64BIT		= 7,
> +	XMIT_SZ_128BIT		= 3,
> +	XMIT_SZ_256BIT		= 4,
> +	XMIT_SZ_128BIT_BLK	= 0xb,
> +	XMIT_SZ_256BIT_BLK	= 0xc,
> +};
> +
> +/* log2(size / 8) - used to calculate number of transfers */
> +#define TS_SHIFT {			\
> +	[XMIT_SZ_8BIT]		= 0,	\
> +	[XMIT_SZ_16BIT]		= 1,	\
> +	[XMIT_SZ_32BIT]		= 2,	\
> +	[XMIT_SZ_64BIT]		= 3,	\
> +	[XMIT_SZ_128BIT]	= 4,	\
> +	[XMIT_SZ_256BIT]	= 5,	\
> +	[XMIT_SZ_128BIT_BLK]	= 4,	\
> +	[XMIT_SZ_256BIT_BLK]	= 5,	\
> +}
> +
> +#define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
> +			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
> +
We see that the complex case is a superset, suggesting that it's
worthwhile to make this common.

This XMIT_SZ_xxx enum should be moved in to the upper level so all CPUs
have visibility of it, and at the same time should be converted to shifts
to permit platform data to have an xmit_sz_valid bitmap or something
similar.

Beyond that, if the xmit sizes are ordered logically by size rather than
by CHCR values then TS_SHIFT can go away and the entire thing can be
calculated dynamically, we would just need a helper routine for
converting a size mask to a CHCR one.

After the above items are done, we should be in a position to kill off
all of the CPU DMA headers.

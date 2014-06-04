From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:37:38 +0000
Subject: Re: [PATCH 4/8] shdma: fdt: initial of probe code to create pdata
Message-Id: <538F4B52.3040508@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-5-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/06/14 17:14, Ben Dooks wrote:
> Add helper to produce driver data when the probe is via the fdt. Extract
> the data from a template and device-tree ndoe and create the driver internal
> data from it.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/dma/sh/shdma-of.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sh/shdma.h    | 20 +++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
> index 894c48e..6c45ffe 100644
> --- a/drivers/dma/sh/shdma-of.c
> +++ b/drivers/dma/sh/shdma-of.c
> @@ -3,12 +3,15 @@
>   *
>   * Copyright (C) 2013 Renesas Electronics Inc.
>   * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + * Copyright (c) 2014 Codethink Limited
> + *	Ben Dooks <ben.dooks@codethink.co.uk>
>   *
>   * This is free software; you can redistribute it and/or modify
>   * it under the terms of version 2 of the GNU General Public License as
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/slab.h>
>  #include <linux/dmaengine.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -16,6 +19,9 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/shdma-base.h>
> +#include <linux/sh_dma.h>
> +
> +#include "shdma-arm.h"
>  
>  struct shdma_of_state {
>  	unsigned long	slave_used[256 / sizeof(unsigned long)];
> @@ -23,6 +29,29 @@ struct shdma_of_state {
>  
>  #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
>  
> +static const unsigned int arm_dma_ts_shift[] = SH_DMAE_ARM_TS_SHIFT;
> +
> +static struct sh_dmae_pdata arm_dmae_info = {
> +	.ts_low_shift	= SHDMA_ARM_TS_LOW_SHIFT,
> +	.ts_low_mask	= SHDMA_ARM_TS_LOW_BIT << SHDMA_ARM_TS_LOW_SHIFT,
> +	.ts_high_shift	= SHDMA_ARM_TS_HI_SHIFT,
> +	.ts_high_mask	= SHDMA_ARM_TS_HI_BIT << SHDMA_ARM_TS_HI_SHIFT,
> +	.ts_shift	= arm_dma_ts_shift,
> +	.ts_shift_num	= ARRAY_SIZE(arm_dma_ts_shift),
> +	.dmaor_init	= DMAOR_DME,
> +	.chclr_present	= 1,
> +	.chclr_bitwise	= 1,
> +};
> +
> +struct sh_dmae_of_info shdma_arm_info = {
> +	.pdata_template	= &arm_dmae_info,
> +	.channel_offset	= 0x8000-0x20,
> +	.channel_stride	= 0x80,
> +	.offset		= 0x0,
> +	.dmars		= 0x40,
> +	.chclr_offset	= 0x80,
> +};
> +

I've just realised all this is dmae specific, so should be moved
into the shdmac driver.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

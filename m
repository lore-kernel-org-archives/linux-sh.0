From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Apr 2014 20:55:15 +0000
Subject: Re: [PATCH 8/9] DMA: shdma: initial of common code
Message-Id: <534310B3.5080207@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk> <1396901229-29117-9-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-9-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

On 04/08/2014 12:07 AM, Ben Dooks wrote:

> Add support for building shdma internal data from the device tree to allow
> converting the driver to be device tree enabled.

> It includes a helper for the of case to build the internal data used to
> select and filter out the DMA channels from the ID information in the
> device tree. Also updates the documentation for the DT case.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   Documentation/devicetree/bindings/dma/shdma.txt |  24 +++++
>   drivers/dma/sh/shdma-of.c                       | 134 ++++++++++++++++++++++++
>   drivers/dma/sh/shdma.h                          |  20 ++++
>   include/dt-bindings/dma/shdma.h                 |  45 ++++++++
>   4 files changed, 223 insertions(+)
>   create mode 100644 include/dt-bindings/dma/shdma.h

> diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
> index 2a3f3b8..7d9e7bd 100644
> --- a/Documentation/devicetree/bindings/dma/shdma.txt
> +++ b/Documentation/devicetree/bindings/dma/shdma.txt
> @@ -15,6 +15,12 @@ Required properties:
>   - compatible:	should be "renesas,shdma-mux"
>   - #dma-cells:	should be <1>, see "dmas" property below
>
> +New properites, required for renesas,dma-r8a7790.
> +- reneasa,slaves: A list of DMA channel MID/RID and the configuration to

    s/reneasa/renesas/

> +		go with them. These pairs are in the form of:
> +			< mid+rid configuration>

    Space after < probably not needed.

> @@ -70,6 +77,23 @@ Example:
>   		};
>   	};
>
> +For r8a7790, the following is an example of using the reneasas,slaves to

    s/reneasas/renesas/

[...]
> diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
> index 06473a0..386fd9e 100644
> --- a/drivers/dma/sh/shdma-of.c
> +++ b/drivers/dma/sh/shdma-of.c
> @@ -3,12 +3,15 @@
>    *
>    * Copyright (C) 2013 Renesas Electronics Inc.
>    * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + * Copyright (c) 2014 Codethink Limited
> + *	Ben Dooks <ben.dooks@codethink.co.uk>
>    *
>    * This is free software; you can redistribute it and/or modify
>    * it under the terms of version 2 of the GNU General Public License as
>    * published by the Free Software Foundation.
>    */
>
> +#include <linux/slab.h>

    I think the #include's are sorted alphabetically in this file.

>   #include <linux/dmaengine.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> @@ -16,9 +19,37 @@
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/shdma-base.h>
> +#include <linux/sh_dma.h>
> +
> +#include <dt-bindings/dma/shdma.h>
>
>   #define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
>
> +#include "shdma-arm.h"
> +
> +static const unsigned int arm_dma_ts_shift[] = SH_DMAE_TS_SHIFT;
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

    Spaces needed around -, so that the code is at least consistent.

> +	.channel_stride	= 0x80,
> +	.offset		= 0x0,
> +	.dmars		= 0x40,
> +	.chclr_offset	= 0x80,
> +};
> +
>   static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
>   				       struct of_dma *ofdma)
>   {
> @@ -40,6 +71,109 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
>   	return chan;
>   }
>
> +const struct sh_dmae_pdata *
> +sh_dma_probe_of(struct platform_device *pdev, const struct of_device_id *ofmatch)
> +{
[...]
> +	/* look in current, or parent node for the slave mappings */
> +	prop = of_find_property(np, "renesas,slaves", &len);
> +	if (!prop)
> +		prop = of_find_property(np->parent, "renesas,slaves", &len);
> +

    Empty line not needed here.

> +	if (prop) {
> +		struct sh_dmae_slave_config *slaves;
> +		int nr_slaves = len / (sizeof(u32) * 3);
> +		const __be32 *of_ptr;
> +		u32 of_idx;
> +
[...]
> diff --git a/include/dt-bindings/dma/shdma.h b/include/dt-bindings/dma/shdma.h
> new file mode 100644
> index 0000000..0c8fc9e
> --- /dev/null
> +++ b/include/dt-bindings/dma/shdma.h
> @@ -0,0 +1,45 @@
> +/* DMA binding definitions for SH-DMAC engines.
> + *
> + * Moved from sh_dma.h to share with device tree by Ben Dooks.
> + * Orignal code from:
> + *   shdma.h: Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + *   shdma-arm.h: Copyright (C) 2013 Renesas Electronics, Inc.

   Hm, you're adding the new code, not moving it, as it seems from this patch...

[...]

WBR, Sergei


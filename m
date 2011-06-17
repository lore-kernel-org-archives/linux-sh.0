From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Jun 2011 07:32:56 +0000
Subject: Re: [RFC][PATCH 5/6 v2] ARM: mach-shmobile: sh7372: Add USB-DMAC
Message-Id: <Pine.LNX.4.64.1106170931090.27141@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pei2towhu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pei2towhu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 17 Jun 2011, Kuninori Morimoto wrote:

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> - use "needs_tend_set" / "no_dmars" instead of "is_usbdmac"
> 
>  arch/arm/mach-shmobile/clock-sh7372.c        |    5 +-
>  arch/arm/mach-shmobile/include/mach/sh7372.h |    4 +
>  arch/arm/mach-shmobile/setup-sh7372.c        |  146 ++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+), 1 deletions(-)
> 

[snip]

> diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
> index cd807ee..59ce277 100644
> --- a/arch/arm/mach-shmobile/setup-sh7372.c
> +++ b/arch/arm/mach-shmobile/setup-sh7372.c
> @@ -602,6 +602,150 @@ static struct platform_device dma2_device = {
>  	},
>  };
>  
> +/*
> + * USB-DMAC
> + */
> +
> +unsigned int usbts_shift[] = {3, 4, 5};
> +
> +enum {
> +	XMIT_SZ_8BYTE		= 0,
> +	XMIT_SZ_16BYTE		= 1,
> +	XMIT_SZ_32BYTE		= 2,
> +};
> +
> +#define USBTS_INDEX2VAL(i) (((i) & 3) << 6)
> +
> +static const struct sh_dmae_channel sh7372_usb_dmae_channels[] = {
> +	{
> +		.offset = 0,
> +	}, {
> +		.offset = 0x20,
> +	},
> +};
> +
> +/* USB DMAC0 */
> +static const struct sh_dmae_slave_config sh7372_usb_dmae0_slaves[] = {
> +	{
> +		.slave_id	= SHDMA_SLAVE_USB0_TX,
> +		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_USB0_RX,
> +		.chcr		= TS_INDEX2VAL(XMIT_SZ_8BYTE),

Is "TS_INDEX2VAL" really correct here or should it be "USBTS_INDEX2VAL"?

> +	},
> +};
> +
> +static struct sh_dmae_pdata usb_dma0_platform_data = {
> +	.slave		= sh7372_usb_dmae0_slaves,
> +	.slave_num	= ARRAY_SIZE(sh7372_usb_dmae0_slaves),
> +	.channel	= sh7372_usb_dmae_channels,
> +	.channel_num	= ARRAY_SIZE(sh7372_usb_dmae_channels),
> +	.ts_low_shift	= 6,
> +	.ts_low_mask	= 0xc0,
> +	.ts_high_shift	= 0,
> +	.ts_high_mask	= 0,
> +	.ts_shift	= usbts_shift,
> +	.ts_shift_num	= ARRAY_SIZE(usbts_shift),
> +	.dmaor_init	= DMAOR_DME,
> +	.chcr_offset	= 0x14,
> +	.chcr_ie_bit	= (1 << 5),

superfluous parenthesis

> +	.dmaor_is_32bit	= 1,
> +	.needs_tend_set	= 1,
> +	.no_dmars	= 1,
> +};
> +
> +static struct resource sh7372_usb_dmae0_resources[] = {
> +	{
> +		/* Channel registers and DMAOR */
> +		.start	= 0xe68a0020,
> +		.end	= 0xe68a0064 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		/* VCR/SWR/DMICR */
> +		.start	= 0xe68a0000,
> +		.end	= 0xe68a0014 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		/* IRQ for channels */
> +		.start	= evt2irq(0x0a00),
> +		.end	= evt2irq(0x0a00),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device usb_dma0_device = {
> +	.name		= "sh-dma-engine",
> +	.id		= 3,
> +	.resource	= sh7372_usb_dmae0_resources,
> +	.num_resources	= ARRAY_SIZE(sh7372_usb_dmae0_resources),
> +	.dev		= {
> +		.platform_data	= &usb_dma0_platform_data,
> +	},
> +};
> +
> +/* USB DMAC1 */
> +static const struct sh_dmae_slave_config sh7372_usb_dmae1_slaves[] = {
> +	{
> +		.slave_id	= SHDMA_SLAVE_USB1_TX,
> +		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_USB1_RX,
> +		.chcr		= TS_INDEX2VAL(XMIT_SZ_8BYTE),
> +	},
> +};
> +
> +static struct sh_dmae_pdata usb_dma1_platform_data = {
> +	.slave		= sh7372_usb_dmae1_slaves,
> +	.slave_num	= ARRAY_SIZE(sh7372_usb_dmae1_slaves),
> +	.channel	= sh7372_usb_dmae_channels,
> +	.channel_num	= ARRAY_SIZE(sh7372_usb_dmae_channels),
> +	.ts_low_shift	= 6,
> +	.ts_low_mask	= 0xc0,
> +	.ts_high_shift	= 0,
> +	.ts_high_mask	= 0,
> +	.ts_shift	= usbts_shift,
> +	.ts_shift_num	= ARRAY_SIZE(usbts_shift),
> +	.dmaor_init	= DMAOR_DME,
> +	.chcr_offset	= 0x14,
> +	.chcr_ie_bit	= (1 << 5),

ditto

> +	.dmaor_is_32bit	= 1,
> +	.needs_tend_set	= 1,
> +	.no_dmars	= 1,
> +};
> +
> +static struct resource sh7372_usb_dmae1_resources[] = {
> +	{
> +		/* Channel registers and DMAOR */
> +		.start	= 0xe68c0020,
> +		.end	= 0xe68c0064 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		/* VCR/SWR/DMICR */
> +		.start	= 0xe68c0000,
> +		.end	= 0xe68c0014 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		/* IRQ for channels */
> +		.start	= evt2irq(0x1d00),
> +		.end	= evt2irq(0x1d00),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device usb_dma1_device = {
> +	.name		= "sh-dma-engine",
> +	.id		= 4,
> +	.resource	= sh7372_usb_dmae1_resources,
> +	.num_resources	= ARRAY_SIZE(sh7372_usb_dmae1_resources),
> +	.dev		= {
> +		.platform_data	= &usb_dma1_platform_data,
> +	},
> +};
> +
>  /* VPU */
>  static struct uio_info vpu_platform_data = {
>  	.name = "VPU5HG",
> @@ -829,6 +973,8 @@ static struct platform_device *sh7372_late_devices[] __initdata = {
>  	&dma0_device,
>  	&dma1_device,
>  	&dma2_device,
> +	&usb_dma0_device,
> +	&usb_dma1_device,
>  	&vpu_device,
>  	&veu0_device,
>  	&veu1_device,
> -- 
> 1.7.4.1

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

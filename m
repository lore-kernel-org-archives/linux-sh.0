From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sun, 20 Jan 2008 00:16:29 +0000
Subject: Re: [PATCH] sh: add resource of USB for SH7720
Message-Id: <20080120011516.9e1ba8d7.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <47860ABA.7000407@renesas.com>
In-Reply-To: <47860ABA.7000407@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

Without looking to heavily in the hd64465 datasheet, you think this would work for hd64465+SH7729 platform? It contains an OHCI based usb host.

Best wishes
Kristoffer


On Thu, 10 Jan 2008 21:08:26 +0900
Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com> wrote:

> add resource of USB for SH7720.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh3/setup-sh7720.c |   53 ++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff -uprN a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
> --- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2008-01-08 20:41:40.000000000 +0900
> +++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2008-01-10 15:13:37.000000000 +0900
> @@ -85,9 +85,62 @@ static struct platform_device sci_device
>  	},
>  };
> 
> +static struct resource usb_ohci_resources[] = {
> +	[0] = {
> +		.start	= 0xA4428000,
> +		.end	= 0xA44280FF,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= 67,
> +		.end	= 67,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 usb_ohci_dma_mask = 0xffffffffUL;
> +static struct platform_device usb_ohci_device = {
> +	.name		= "sh_ohci",
> +	.id		= -1,
> +	.dev = {
> +		.dma_mask		= &usb_ohci_dma_mask,
> +		.coherent_dma_mask	= 0xffffffff,
> +	},
> +	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
> +	.resource	= usb_ohci_resources,
> +};
> +
> +static struct resource usbf_resources[] = {
> +	[0] = {
> +		.name	= "sh_udc",
> +		.start	= 0xA4420000,
> +		.end	= 0xA44200FF,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.name	= "sh_udc",
> +		.start	= 65,
> +		.end	= 65,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device usbf_device = {
> +	.name		= "sh_udc",
> +	.id		= -1,
> +	.dev = {
> +		.dma_mask		= NULL,
> +		.coherent_dma_mask	= 0xffffffff,
> +	},
> +	.num_resources	= ARRAY_SIZE(usbf_resources),
> +	.resource	= usbf_resources,
> +};
> +
>  static struct platform_device *sh7720_devices[] __initdata = {
>  	&rtc_device,
>  	&sci_device,
> +	&usb_ohci_device,
> +	&usbf_device,
>  };
> 
>  static int __init sh7720_devices_setup(void)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>

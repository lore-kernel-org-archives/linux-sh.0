From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 03 Mar 2009 06:50:45 +0000
Subject: Re: [PATCH] Add OHCI USB support for SH7786
Message-Id: <20090303065045.GC30177@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6vozecn.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uy6vozecn.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 02, 2009 at 02:16:06PM +0900, Kuninori Morimoto wrote:
> +static u64 usb_ohci_dma_mask = 0xffffffffUL;

Please use DMA_BIT_MASK(32) here for the initializer instead. The
definition is in linux/dma-mapping.h.

> +static struct platform_device usb_ohci_device = {
> +	.name		= "sh_ohci",
> +	.id		= -1,
> +	.dev = {
> +		.dma_mask		= &usb_ohci_dma_mask,
> +		.coherent_dma_mask	= 0xffffffff,
> +	},

Likewise for the coherent_dma_mask.

> +int __init sh7786_usb_setup(int exclock)
> +{
Where is this function used?

> +	int i;
> +	u32 val;
> +
> +	ctrl_outl(0x00ff0040, 0xffe70094);
> +	ctrl_outl(0x00000001, 0xffe7009c);
> +
This needs documenting. Also, please use __raw_writel() and friends
instead of the ctrl_xxx() variants for new code.

> +	val = ctrl_inl(USBCTL0) & 0xffffff7f;
> +	if (exclock)
> +		val |= 0x00000080;
> +	ctrl_outl(val, USBCTL0);
> +
The above mask and bit definition should have macros associated with
them, so we know precisely what is changing.

> +	/* Set the PHY ENB bit */
> +	i = 1000000;
> +	ctrl_outl(0x00000001, USBPCTL1);
> +	while (i-- && !(ctrl_inl(USBST) & (1 << 30)))
> +		;
> +
This is not sufficient, all new versions of gcc will optimize this away.
At the very least, you will need a cpu_relax(); to prevent the loop
optimization.

> +	/* Set the PLL ENB bit */
> +	i = 1000000;
> +	ctrl_outl(0x00000003, USBPCTL1);
> +	while (i-- && ((ctrl_inl(USBST) & (0x3 << 30)) != (0x3 << 30)))
> +		;
> +
Likewise.

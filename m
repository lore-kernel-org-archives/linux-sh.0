From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 08 Apr 2015 13:14:03 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: Revise the binding document about the dma-names
Message-Id: <20150408131403.GC5977@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <1428489744-4872-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1428489744-4872-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "balbi@ti.com" <balbi@ti.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Apr 08, 2015 at 11:42:24AM +0100, Yoshihiro Shimoda wrote:
> Since the DT should describe the hardware (not the driver limitation),
> This patch revises the binding document about the dma-names to change
> simple numbering as "ch%d" instead of "tx<n>" and "rx<n>".

The naming given in this patch looks more sensible to me.

> Also this patch fixes the actual code of renesas_usbhs driver to handle
> the new dma-names.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on Felipe's usb.bit / testing/next branch.
>  (commit id = bbc78c07a51f6fd29c227b1220a9016e585358ba)

I take it the existing driver and binding haven't hit mainline, and
therefore there are no users yet?

Mark.

> 
>  Geert is pointed out about this issue:
>  https://www.mail-archive.com/devicetree@vger.kernel.org/msg68401.html
> 
>  .../devicetree/bindings/usb/renesas_usbhs.txt      |  6 ++----
>  drivers/usb/renesas_usbhs/fifo.c                   | 24 ++++++++++++++--------
>  2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index dc2a18f..ddbe304 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -15,10 +15,8 @@ Optional properties:
>    - phys: phandle + phy specifier pair
>    - phy-names: must be "usb"
>    - dmas: Must contain a list of references to DMA specifiers.
> -  - dma-names : Must contain a list of DMA names:
> -   - tx0 ... tx<n>
> -   - rx0 ... rx<n>
> -    - This <n> means DnFIFO in USBHS module.
> +  - dma-names : named "ch%d", where %d is the channel number ranging from zero
> +                to the number of channels (DnFIFOs) minus one.
>  
>  Example:
>  	usbhs: usb@e6590000 {
> diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
> index 8597cf9..bc23b4a 100644
> --- a/drivers/usb/renesas_usbhs/fifo.c
> +++ b/drivers/usb/renesas_usbhs/fifo.c
> @@ -1227,15 +1227,21 @@ static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo,
>  {
>  	char name[16];
>  
> -	snprintf(name, sizeof(name), "tx%d", channel);
> -	fifo->tx_chan = dma_request_slave_channel_reason(dev, name);
> -	if (IS_ERR(fifo->tx_chan))
> -		fifo->tx_chan = NULL;
> -
> -	snprintf(name, sizeof(name), "rx%d", channel);
> -	fifo->rx_chan = dma_request_slave_channel_reason(dev, name);
> -	if (IS_ERR(fifo->rx_chan))
> -		fifo->rx_chan = NULL;
> +	/*
> +	 * To avoid complex handing for DnFIFOs, the driver uses each
> +	 * DnFIFO as TX or RX direction (not bi-direction).
> +	 * So, the driver uses odd channels for TX, even channels for RX.
> +	 */
> +	snprintf(name, sizeof(name), "ch%d", channel);
> +	if (channel & 1) {
> +		fifo->tx_chan = dma_request_slave_channel_reason(dev, name);
> +		if (IS_ERR(fifo->tx_chan))
> +			fifo->tx_chan = NULL;
> +	} else {
> +		fifo->rx_chan = dma_request_slave_channel_reason(dev, name);
> +		if (IS_ERR(fifo->rx_chan))
> +			fifo->rx_chan = NULL;
> +	}
>  }
>  
>  static void usbhsf_dma_init(struct usbhs_priv *priv, struct usbhs_fifo *fifo,
> -- 
> 1.9.1
> 

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 19:01:19 +0000
Subject: Re: [PATCH 1/8] serial: sh-sci: Use correct device for DMA mapping with IOMMU
Message-Id: <16854107.LNku0akEuk@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432145174-11534-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432145174-11534-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 20 May 2015 20:06:07 Geert Uytterhoeven wrote:
> To function correctly in the presence of an IOMMU, the DMA buffers must
> be managed using the DMA channel's device instead of the platform
> device's device.
> 
> Make sure to free the DMA memory before releasing the channel, and avoid
> freeing it twice (when DMA initialization succeeded before, but failed
> partially on next open).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 583aa563d4038f8b..8756d186e86891ac 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1372,10 +1372,13 @@ static void sci_rx_dma_release(struct sci_port *s,
> bool enable_pio)
> 
>  	s->chan_rx = NULL;
>  	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
> +	if (sg_dma_address(&s->sg_rx[0])) {

0 is a valid DMA address. You should use dma_mapping_error() to test for 
invalid addresses. I'm afraid we don't have any API to set a DMA address to an 
invalid value, but we can probably use DMA_ERROR_CODE for now even if it's 
limited to ARM.

> +		dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
> +				  sg_virt(&s->sg_rx[0]),
> +				  sg_dma_address(&s->sg_rx[0]));
> +		sg_dma_address(&s->sg_rx[0]) = 0;
> +	}
>  	dma_release_channel(chan);
> -	if (sg_dma_address(&s->sg_rx[0]))
> -		dma_free_coherent(port->dev, s->buf_len_rx * 2,
> -				  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
>  	if (enable_pio)
>  		sci_start_rx(port);
>  }
> @@ -1706,7 +1709,8 @@ static void sci_request_dma(struct uart_port *port)
>  		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
>  			    UART_XMIT_SIZE,
>  			    (uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
> -		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
> +		nent = dma_map_sg(chan->device->dev, &s->sg_tx, 1,
> +				  DMA_TO_DEVICE);
>  		if (!nent)
>  			sci_tx_dma_release(s, false);
>  		else
> @@ -1735,8 +1739,9 @@ static void sci_request_dma(struct uart_port *port)
>  		s->chan_rx = chan;
> 
>  		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
> -		buf[0] = dma_alloc_coherent(port->dev, s->buf_len_rx * 2,
> -					    &dma[0], GFP_KERNEL);
> +		buf[0] = dma_alloc_coherent(chan->device->dev,
> +					    s->buf_len_rx * 2, &dma[0],
> +					    GFP_KERNEL);

I might be mistaken but I think this will break with the shdma-mux 
infrastructure, as the IOMMUs will be associated with the physical DMA 
controller and not the mux device. Maybe this just calls for getting rid of 
shdma-mux. I'm knowingly forgetting about the other option that would require 
fixing the problem in the DMA mapping implementation :-)

Those issues aren't introduced by this patch, so you can add my

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

here and fix them later.

> 
>  		if (!buf[0]) {
>  			dev_warn(port->dev,

-- 
Regards,

Laurent Pinchart


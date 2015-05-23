From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 19:06:27 +0000
Subject: Re: [PATCH 3/8] serial: sh-sci: Use min_t()/max_t() instead of casts
Message-Id: <1761966.VabTI6DprL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432145174-11534-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432145174-11534-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 20 May 2015 20:06:09 Geert Uytterhoeven wrote:
> When comparing differently sized types, it's better to use
> min_t()/max_t() than adding casts.
> 
> Also use "unsigned int" instead of "int", as that's the right type for
> the length of an SG entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/tty/serial/sh-sci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 0aec66cf68615972..21c07c6cb0cd2220 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1520,7 +1520,8 @@ static void work_fn_tx(struct work_struct *work)
>  	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
>  	sg_dma_address(sg) = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
>  		sg->offset;
> -	sg_dma_len(sg) = min((int)CIRC_CNT(xmit->head, xmit->tail,
> UART_XMIT_SIZE), +	sg_dma_len(sg) = min_t(unsigned int,
> +		CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
>  		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
>  	spin_unlock_irq(&port->lock);
> 
> @@ -1746,7 +1747,7 @@ static void sci_request_dma(struct uart_port *port)
> 
>  		s->chan_rx = chan;
> 
> -		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
> +		s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
>  		buf[0] = dma_alloc_coherent(chan->device->dev,
>  					    s->buf_len_rx * 2, &dma[0],
>  					    GFP_KERNEL);

-- 
Regards,

Laurent Pinchart


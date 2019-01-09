From: Ulrich Hecht <uli@fpond.eu>
Date: Wed, 09 Jan 2019 12:47:00 +0000
Subject: Re: [PATCH v5 1/4] serial: sh-sci: Extract sci_dma_rx_chan_invalidate()
Message-Id: <428987666.1195881.1547038020104@webmail.strato.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190107162320.15530-1-geert+renesas@glider.be>
 <20190107162320.15530-2-geert+renesas@glider.be>
In-Reply-To: <20190107162320.15530-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org


> On January 7, 2019 at 5:23 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> The cookies and channel pointer for the DMA receive channel are
> invalidated in two places, and one more is planned.
> Extract this functionality in a common helper.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:
>   - New.
> ---
>  drivers/tty/serial/sh-sci.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 8df0fd8245203f8b..4c75468680cb547d 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1243,12 +1243,22 @@ static int sci_dma_rx_find_active(struct sci_port *s)
>  	return -1;
>  }
>  
> +static void sci_dma_rx_chan_invalidate(struct sci_port *s)
> +{
> +	unsigned int i;
> +
> +	s->chan_rx = NULL;
> +	for (i = 0; i < ARRAY_SIZE(s->cookie_rx); i++)
> +		s->cookie_rx[i] = -EINVAL;
> +	s->active_rx = 0;
> +}
> +
>  static void sci_rx_dma_release(struct sci_port *s)
>  {
>  	struct dma_chan *chan = s->chan_rx_saved;
>  
> -	s->chan_rx_saved = s->chan_rx = NULL;
> -	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
> +	s->chan_rx_saved = NULL;
> +	sci_dma_rx_chan_invalidate(s);
>  	dmaengine_terminate_sync(chan);
>  	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
>  			  sg_dma_address(&s->sg_rx[0]));
> @@ -1367,10 +1377,7 @@ static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
>  		spin_lock_irqsave(&port->lock, flags);
>  	if (i)
>  		dmaengine_terminate_async(chan);
> -	for (i = 0; i < 2; i++)
> -		s->cookie_rx[i] = -EINVAL;
> -	s->active_rx = 0;
> -	s->chan_rx = NULL;
> +	sci_dma_rx_chan_invalidate(s);
>  	sci_start_rx(port);
>  	if (!port_lock_held)
>  		spin_unlock_irqrestore(&port->lock, flags);
> -- 
> 2.17.1
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

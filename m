From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 13:22:42 +0000
Subject: Re: [PATCH v4 2/4] serial: sh-sci: Fix crash in rx_timer_fn() on PIO fallback
Message-Id: <20181217132241.4lbaeshn2rnlhjqe@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
 <20181213184444.21904-3-geert+renesas@glider.be>
In-Reply-To: <20181213184444.21904-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Dec 13, 2018 at 07:44:42PM +0100, Geert Uytterhoeven wrote:
> When falling back to PIO, active_rx must be set to a different value
> than cookie_rx[i], else sci_dma_rx_find_active() will incorrectly find a
> match, leading to a NULL pointer dereference in rx_timer_fn() later.
> 
> Use zero instead, which is the same value as after driver
> initialization.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This looks good so to me long as dmaengine_submit() doesn't return 0.
Is that the case?

> ---
> v4:
>   - No changes,
> 
> v3:
>   - Split in multiple patches.
> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 2a08039f792235e5..e353e03ce2602559 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1369,7 +1369,7 @@ static void sci_submit_rx(struct sci_port *s, bool port_lock_held)
>  		dmaengine_terminate_async(chan);
>  	for (i = 0; i < 2; i++)
>  		s->cookie_rx[i] = -EINVAL;
> -	s->active_rx = -EINVAL;
> +	s->active_rx = 0;
>  	s->chan_rx = NULL;
>  	sci_start_rx(port);
>  	if (!port_lock_held)
> -- 
> 2.17.1
> 

From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Jun 2018 14:54:11 +0000
Subject: Re: [PATCH] serial: sh-sci: Stop RX FIFO timer during port shutdown
Message-Id: <20180629145410.k5674s4hl7yraszo@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142803.21077-1-geert+renesas@glider.be>
In-Reply-To: <20180629142803.21077-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Jun 29, 2018 at 04:28:03PM +0200, Geert Uytterhoeven wrote:
> The RX FIFO timer may be armed when the port is shut down, hence the
> timer function may still be called afterwards.
> 
> Fix this race condition by deleting the timer during port shutdown.
> 
> Fixes: 039403765e5da3c6 ("serial: sh-sci: SCIFA/B RX FIFO software timeout")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> Tested with scifa0 on r8a7740/armadillo, after
> 
>     echo 2000 > /sys/devices/platform/e6c40000.serial/rx_fifo_timeout
> ---
>  drivers/tty/serial/sh-sci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5c870ab80b98e25b..04f5b754e69e28dd 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2100,6 +2100,8 @@ static void sci_shutdown(struct uart_port *port)
>  	}
>  #endif
>  
> +	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0)
> +		del_timer_sync(&s->rx_fifo_timer);
>  	sci_free_irq(s);
>  	sci_free_dma(port);
>  }
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

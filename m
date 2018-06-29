From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Jun 2018 14:48:25 +0000
Subject: Re: [PATCH 1/3] serial: sh-sci: Postpone DMA release when falling back to PIO
Message-Id: <CAMuHMdV9EvedhRHkDNkNqkD6NQ=hiJuNkqk1h91YRiN96_3gOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-1-geert+renesas@glider.be> <20180629142513.20743-2-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Jun 29, 2018 at 4:26 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When the sh-sci driver detects an issue with DMA during operation, it
> falls backs to PIO, and releases all DMA resources.
>
> As releasing DMA resources immediately has no advantages, but
> complicates the code, and is susceptible to races, it is better to
> postpone this to port shutdown.
>
> This allows to remove the locking from sci_rx_dma_release() and
> sci_tx_dma_release(), but requires keeping a copy of the DMA channel
> pointers for release during port shutdown.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -1212,25 +1214,17 @@ static int sci_dma_rx_find_active(struct sci_port *s)
>         return -1;
>  }
>
> -static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
> +static void sci_rx_dma_release(struct sci_port *s)
>  {
> -       struct dma_chan *chan = s->chan_rx;
> +       struct dma_chan *chan = s->chan_rx_saved;
>         struct uart_port *port = &s->port;

Brown paper bag #2: unused variable port. Let's blame it on the warm Friday
afternoon.

So yes, there will be a v2, eventually...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

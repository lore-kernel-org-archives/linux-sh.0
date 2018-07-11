From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jul 2018 15:28:46 +0000
Subject: Re: [PATCH v2 1/3] serial: sh-sci: Postpone DMA release when falling back to PIO
Message-Id: <CAMuHMdXf31V3dxGrXtsUdoSHnYB2m9wQWDYUT=kd9MXR81dQLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180706090543.31625-1-geert+renesas@glider.be>
 <20180706090543.31625-2-geert+renesas@glider.be> <20180711144041.i7cszjtmapeods4w@verge.net.au>
In-Reply-To: <20180711144041.i7cszjtmapeods4w@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Simon,

On Wed, Jul 11, 2018 at 4:41 PM Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jul 06, 2018 at 11:05:41AM +0200, Geert Uytterhoeven wrote:
> > When the sh-sci driver detects an issue with DMA during operation, it
> > falls backs to PIO, and releases all DMA resources.
> >
> > As releasing DMA resources immediately has no advantages, but
> > complicates the code, and is susceptible to races, it is better to
> > postpone this to port shutdown.
> >
> > This allows to remove the locking from sci_rx_dma_release() and
> > sci_tx_dma_release(), but requires keeping a copy of the DMA channel
> > pointers for release during port shutdown.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c

> > @@ -1535,7 +1534,6 @@ static void sci_request_dma(struct uart_port *port)
> >       chan = sci_request_dma_chan(port, DMA_MEM_TO_DEV);
> >       dev_dbg(port->dev, "%s: TX: got channel %p\n", __func__, chan);
> >       if (chan) {
> > -             s->chan_tx = chan;
> >               /* UART circular tx buffer is an aligned page. */
> >               s->tx_dma_addr = dma_map_single(chan->device->dev,
> >                                               port->state->xmit.buf,
> > @@ -1544,11 +1542,13 @@ static void sci_request_dma(struct uart_port *port)
> >               if (dma_mapping_error(chan->device->dev, s->tx_dma_addr)) {
> >                       dev_warn(port->dev, "Failed mapping Tx DMA descriptor\n");
> >                       dma_release_channel(chan);
> > -                     s->chan_tx = NULL;
> > +                     chan = NULL;
>
> I am sure that I am missing something obvious, but why is chan set here?
> Unless I'm reading the wrong code its set again at the end of the
> block that ends just after the call to INIT_WORK().

I don't see where it's set again at the end of the block?

But indeed, there's no need to set it to NULL here, as chan isn't used
later again.
So the assignment should be removed, cfr. for the RX DMA case below[*].
Probably I missed that due to the asymmetry between the TX and RX DMA paths.
Will send a follow up patch to remove the assignment.

>
> >               } else {
> >                       dev_dbg(port->dev, "%s: mapped %lu@%p to %pad\n",
> >                               __func__, UART_XMIT_SIZE,
> >                               port->state->xmit.buf, &s->tx_dma_addr);
> > +
> > +                     s->chan_tx_saved = s->chan_tx = chan;
> >               }
> >
> >               INIT_WORK(&s->work_tx, work_fn_tx);
> > @@ -1561,8 +1561,6 @@ static void sci_request_dma(struct uart_port *port)
> >               dma_addr_t dma;
> >               void *buf;
> >
> > -             s->chan_rx = chan;
> > -
> >               s->buf_len_rx = 2 * max_t(size_t, 16, port->fifosize);
> >               buf = dma_alloc_coherent(chan->device->dev, s->buf_len_rx * 2,
> >                                        &dma, GFP_KERNEL);
> > @@ -1570,7 +1568,6 @@ static void sci_request_dma(struct uart_port *port)
> >                       dev_warn(port->dev,
> >                                "Failed to allocate Rx dma buffer, using PIO\n");
> >                       dma_release_channel(chan);
> > -                     s->chan_rx = NULL;

[*] here.

> >                       return;
> >               }
> >
> > @@ -1591,6 +1588,8 @@ static void sci_request_dma(struct uart_port *port)
> >
> >               if (port->type = PORT_SCIFA || port->type = PORT_SCIFB)
> >                       sci_submit_rx(s);
> > +
> > +             s->chan_rx_saved = s->chan_rx = chan;
> >       }
> >  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

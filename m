From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Jul 2018 09:53:22 +0000
Subject: Re: [PATCH v2 2/3] serial: sh-sci: Stop TX DMA workqueue during port shutdown
Message-Id: <20180717095321.pce7rzvhcfna735n@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20180706090543.31625-1-geert+renesas@glider.be>
 <20180706090543.31625-3-geert+renesas@glider.be>
 <20180711145149.muwetfr2mzbd5dc4@verge.net.au>
 <CAMuHMdUyhFT=tRp3_9ACWruLCDTLtfmQHyYDsZOu4xCieE++Lw@mail.gmail.com>
 <20180713074233.jxijuts35g5meejy@verge.net.au>
 <CAMuHMdWNkHr+XeoDzB+BWFQX4jskgqxmO2Obc6SJ7HUC8XXS4w@mail.gmail.com>
In-Reply-To: <CAMuHMdWNkHr+XeoDzB+BWFQX4jskgqxmO2Obc6SJ7HUC8XXS4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Jul 13, 2018 at 10:00:05AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Jul 13, 2018 at 9:42 AM Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jul 11, 2018 at 05:15:57PM +0200, Geert Uytterhoeven wrote:
> > > On Wed, Jul 11, 2018 at 4:52 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Fri, Jul 06, 2018 at 11:05:42AM +0200, Geert Uytterhoeven wrote:
> > > > > The transmit DMA workqueue is never stopped, hence the work function may
> > > > > be called after the port has been shut down.
> > > > >
> > > > > Fix this race condition by cancelling queued work, if any, before DMA
> > > > > release.  Don't initialize the work if DMA initialization failed, as it
> > > > > won't be used anyway.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > > --- a/drivers/tty/serial/sh-sci.c
> > > > > +++ b/drivers/tty/serial/sh-sci.c
> > > > > @@ -1293,6 +1293,7 @@ static void sci_tx_dma_release(struct sci_port *s)
> > > > >  {
> > > > >       struct dma_chan *chan = s->chan_tx_saved;
> > > > >
> > > > > +     cancel_work_sync(&s->work_tx);
> > > > >       s->chan_tx_saved = s->chan_tx = NULL;
> > > > >       s->cookie_tx = -EINVAL;
> > > > >       dmaengine_terminate_all(chan);
> > > > > @@ -1548,10 +1549,9 @@ static void sci_request_dma(struct uart_port *port)
> > > > >                               __func__, UART_XMIT_SIZE,
> > > > >                               port->state->xmit.buf, &s->tx_dma_addr);
> > > > >
> > > > > +                     INIT_WORK(&s->work_tx, work_fn_tx);
> > > > >                       s->chan_tx_saved = s->chan_tx = chan;
> > > >
> > > > Is it ok that work_fn_tx reads and writes s->work_tx which
> > >
> > > writes s->chan_tx?
> >
> > Yes :)
> >
> > > > is set after the call to INIT_WORK() ?
> > >
> > > Yes, unlike interrupt handlers, it isn't called until software kicks the
> > > workqueue using schedule_work(&s->work_tx);
> >
> > Ok, so we are sure access is only happening on one CPU?
> 
> sci_request_dma() is called during early port setup, before it can be used.
> So no other CPU should be using it (unless it contains a time machine ;-)

Thanks, that is what I was/am missing.

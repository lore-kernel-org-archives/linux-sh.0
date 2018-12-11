From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Dec 2018 08:16:03 +0000
Subject: Re: [PATCH v3 3/4] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Message-Id: <CAMuHMdUXUz8+2Mher9_-x4F04qdP+o39a89t+QiwnyS8OSk1AQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181210182154.20357-1-geert+renesas@glider.be>
	<20181210182154.20357-4-geert+renesas@glider.be>
	<20181210190052.admylepukreo23j3@ninjato>
In-Reply-To: <20181210190052.admylepukreo23j3@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, uli+renesas@fpond.eu, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi Wolfram,

On Mon, Dec 10, 2018 at 8:00 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >       if (!port_lock_held)
> >               spin_unlock_irqrestore(&port->lock, flags);
> > +     return -1;
>
> -Esomething here...
>
> >               } else {
> > +                     if (sci_submit_rx(s, false))
> > +                             goto handle_pio;
>
> and 'sci_submit_rx() < 0' here? I think it makes it more readable that
> this is an error case then. 'if sci_submit_rx() do_something' sounds a
> bit like the good case if boolean logic was used.

Thanks, will update for v4, using -EAGAIN.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

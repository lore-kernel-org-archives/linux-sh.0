From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 12 Jul 2018 09:44:39 +0000
Subject: Re: [PATCH] [RFC] serial: sh-sci: fix register alocation in h8300.
Message-Id: <87lgagpz3s.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20180711114121.10735-1-ysato@users.sourceforge.jp>
In-Reply-To: <20180711114121.10735-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 11 Jul 2018 21:53:30 +0900,
Geert Uytterhoeven wrote:
> 
> Hi Sato-san,
> 
> CC Laurent
> 
> On Wed, Jul 11, 2018 at 2:38 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > h8300's SCI registers aligned byte address.
> > Although it may be appropriate to put it in sci_port_params,
> > because I can not think of a good way, I did it like this.
> >
> > Signei-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Thanks for your patch!
> 
> Fixes: dfc80387aefb7816 ("serial: sh-sci: Compute the regshift value
> for SCI ports")
> 
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2862,12 +2862,16 @@ static int sci_init_single(struct platform_device *dev,
> >         port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
> >         port->fifosize          = sci_port->params->fifosize;
> >
> > +#if !defined(CONFIG_H8300)
> >         if (port->type = PORT_SCI) {
> >                 if (sci_port->reg_size >= 0x20)
> >                         port->regshift = 2;
> >                 else
> >                         port->regshift = 1;
> >         }
> > +#else
> > +       port->regshift = 0;
> > +#endif
> 
> What about using reg_size instead?
> 
>         if (sci_port->reg_size >= 0x20)
>                 port->regshift = 2;
>         else if (sci_port->reg_size >= 0x10)
>                 port->regshift = 1;
>         else
>                 port->regshift = 0;
> 
> >         /*
> >          * The UART port needs an IRQ value, so we peg this to the RX IRQ
> 

It looks more better fix.
And works fine of h8300.

Thanks.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Aug 2018 17:52:10 +0000
Subject: Re: [PATCH v2] serial: sh-sci: byte allocated register support
Message-Id: <CAMuHMdUjai66HCP-uANqOCM2RvXfBW4Y_+xR3y7Qr3HBs0fVkQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180721143436.43675-1-ysato@users.sourceforge.jp>
In-Reply-To: <20180721143436.43675-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sato-san,

On Mon, Jul 23, 2018 at 10:17 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> CC gregkh, linux-serial
>
> On Sun, Jul 22, 2018 at 3:02 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> >
> > H8/300 SCI registers allocated byte address.
> > It must support to the case where shift count is 0.
> >
> > Changes v2.
> > more simply code.
> >
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2863,10 +2863,12 @@ static int sci_init_single(struct platform_device *dev,
> >         port->fifosize          = sci_port->params->fifosize;
> >
> >         if (port->type = PORT_SCI) {
> > -               if (sci_port->reg_size >= 0x20)
> > -                       port->regshift = 2;
> > -               else
> > -                       port->regshift = 1;
> > +               /*
> > +                * reg_size < 0x10: BYTE aligned (scale factor=1).
> > +                * reg_size >= 0x10 and < 0x20: WORD aligned (scale factor=2).
> > +                * reg_size >= 0x20: DWORD aligned (scale factor=4).
> > +                */
> > +               port->regshift = sci_port->reg_size >> 4;
> >         }
> >
> >         /*

Considering the regshift issues introduced by RZ/A2 SCIF support, I think it's
better to not rely on the reg_size value, and change the check to

       if (!dev->dev.of_node && port->type = PORT_SCI)

If/when SuperH receives DT support, SCI ports with regshift 1 or 2 instantiated
from DT can be supported using "reg-shift = <1>" or "reg-shift = <2>" in DT.

Reference: https://www.spinics.net/lists/linux-serial/msg31573.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

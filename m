From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Nov 2015 00:18:01 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <11321076.yAsIxzsHHx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com> <CAMuHMdWSiq3Pna3yxRSYFgZeTMeLYgHaxp115qA-zxw=Ri-BXg@mail.gmail.com> <877flmjnp5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877flmjnp5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Morimoto-san,

On Friday 13 November 2015 08:47:07 Kuninori Morimoto wrote:
> Hi Geert, Laurent
> 
> > > #define _PORT_GP_CFG_2(bank, pin, fn, sfx, cfg) \
> > > -        _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 1,
> > > fn, sfx, cfg) +        _PORT_GP_CFG_1(bank, pin, fn, sfx, cfg)
> > > _PORT_GP_CFG_1(bank, pin + 1, fn, sfx, cfg)
> (snip)
> 
> > > I noticed it seems difficult, because it is based on
> > > 
> > >         #define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin,
> > >         GP_##bank##_##pin, sfx, cfg)> >         
> > >                                     ~~~                                 
> > >                                               ~~~
> > > 
> > > we can't use (pin + x) style.
> > > It seems we need all 0 - 32 definition anyway...
> > 
> > Oh right. CPP cannot evaluate the pin number arithmetic :-(
> > 
> > Then your previous patch is indeed the best we can do, I'm afraid.
> 
> I think your idea was good, but unfortunately we can't use it.
> Laurent, what do you think about this patch ?

It would be great to have a more powerful C preprocessor to create a single 
macro that would take the number of pins as a parameter. I think C++ templates 
could do so ;-)

I think your patch is indeed the best that can be done.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart


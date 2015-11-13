From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Nov 2015 04:02:30 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <876116k0vi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
	<87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXoAd4TFZNzcycisXSg0gd9nWKLRK0UQyAog4HWHJr5yg@mail.gmail.com>
	<87d1vekao8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1vekao8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>


Hi Geert

> > I think this still can be improved upon...
> > 
> > ideally you just need log2(32) defines.
> (snip)
> >  #define PORT_GP_CFG_1(bank, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg)
> >  #define PORT_GP_CFG_2(bank, fn, sfx, cfg) _PORT_GP_CFG_2(bank, 0, fn, sfx, cfg)
> >  #define PORT_GP_CFG_4(bank, pin, fn, sfx, cfg) _PORT_GP_CFG_4(bank,
> > 0, fn, sfx, cfg)
> > ...
> >  #define PORT_GP_CFG_32(bank, fn, sfx, cfg) _PORT_GP_CFG_32(bank, 0,
> > fn, sfx, cfg)
> > 
> > and
> > 
> >  #define PORT_GP_1(bank, fn, sfx) _PORT_GP_CFG_1(bank, 0, fn, sfx, 0)
> >  #define PORT_GP_2(bank, fn, sfx) _PORT_GP_CFG_2(bank, 0, fn, sfx, 0)
> >  #define PORT_GP_4(bank, fn, sfx) _PORT_GP_CFG_4(bank, 0, fn, sfx, 0)
> > ...
> >  #define PORT_GP_32(bank, fn, sfx) _PORT_GP_CFG_32(bank, 0, fn, sfx, 0)
> > 
> > and for the special (non-power-of-two) numbers e.g.
> > 
> > #define PORT_GP_12(bank, fn, sfx) \
> >         _PORT_GP_CFG_8(bank, 0, fn, sfx, 0) _PORT_GP_CFG_4(bank, 8, fn, sfx, 0)
> 
> Ahh indeed, make sense !
> I will use this idea. Thanks !

Hmm... I'm tring this, but...
Can I confirm ? Your idea was this

#define _PORT_GP_CFG_2(bank, pin, fn, sfx, cfg) \
        _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 1, fn, sfx, cfg)

But I think you want this ?

#define _PORT_GP_CFG_2(bank, pin, fn, sfx, cfg) \
-        _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 1, fn, sfx, cfg)
+        _PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) _PORT_GP_CFG_1(bank, pin + 1, fn, sfx, cfg)

I noticed it seems difficult, because it is based on

	#define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin, GP_##bank##_##pin, sfx, cfg)
	                            ~~~                                            ~~~
we can't use (pin + x) style.
It seems we need all 0 - 32 definition anyway...

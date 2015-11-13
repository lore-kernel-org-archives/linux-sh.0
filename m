From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Nov 2015 00:30:52 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <87d1vekao8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
	<87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXoAd4TFZNzcycisXSg0gd9nWKLRK0UQyAog4HWHJr5yg@mail.gmail.com>
In-Reply-To: <CAMuHMdXoAd4TFZNzcycisXSg0gd9nWKLRK0UQyAog4HWHJr5yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>


Hi Geert

> I think this still can be improved upon...
> 
> ideally you just need log2(32) defines.
(snip)
>  #define PORT_GP_CFG_1(bank, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg)
>  #define PORT_GP_CFG_2(bank, fn, sfx, cfg) _PORT_GP_CFG_2(bank, 0, fn, sfx, cfg)
>  #define PORT_GP_CFG_4(bank, pin, fn, sfx, cfg) _PORT_GP_CFG_4(bank,
> 0, fn, sfx, cfg)
> ...
>  #define PORT_GP_CFG_32(bank, fn, sfx, cfg) _PORT_GP_CFG_32(bank, 0,
> fn, sfx, cfg)
> 
> and
> 
>  #define PORT_GP_1(bank, fn, sfx) _PORT_GP_CFG_1(bank, 0, fn, sfx, 0)
>  #define PORT_GP_2(bank, fn, sfx) _PORT_GP_CFG_2(bank, 0, fn, sfx, 0)
>  #define PORT_GP_4(bank, fn, sfx) _PORT_GP_CFG_4(bank, 0, fn, sfx, 0)
> ...
>  #define PORT_GP_32(bank, fn, sfx) _PORT_GP_CFG_32(bank, 0, fn, sfx, 0)
> 
> and for the special (non-power-of-two) numbers e.g.
> 
> #define PORT_GP_12(bank, fn, sfx) \
>         _PORT_GP_CFG_8(bank, 0, fn, sfx, 0) _PORT_GP_CFG_4(bank, 8, fn, sfx, 0)

Ahh indeed, make sense !
I will use this idea. Thanks !


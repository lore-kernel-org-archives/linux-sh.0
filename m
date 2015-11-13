From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Nov 2015 07:44:10 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <CAMuHMdWSiq3Pna3yxRSYFgZeTMeLYgHaxp115qA-zxw=Ri-BXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
	<87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXoAd4TFZNzcycisXSg0gd9nWKLRK0UQyAog4HWHJr5yg@mail.gmail.com>
	<87d1vekao8.wl%kuninori.morimoto.gx@renesas.com>
	<876116k0vi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876116k0vi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Morimoto-san,

On Fri, Nov 13, 2015 at 5:02 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > I think this still can be improved upon...
>> >
>> > ideally you just need log2(32) defines.
>> (snip)
>> >  #define PORT_GP_CFG_1(bank, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg)
>> >  #define PORT_GP_CFG_2(bank, fn, sfx, cfg) _PORT_GP_CFG_2(bank, 0, fn, sfx, cfg)
>> >  #define PORT_GP_CFG_4(bank, pin, fn, sfx, cfg) _PORT_GP_CFG_4(bank,
>> > 0, fn, sfx, cfg)
>> > ...
>> >  #define PORT_GP_CFG_32(bank, fn, sfx, cfg) _PORT_GP_CFG_32(bank, 0,
>> > fn, sfx, cfg)
>> >
>> > and
>> >
>> >  #define PORT_GP_1(bank, fn, sfx) _PORT_GP_CFG_1(bank, 0, fn, sfx, 0)
>> >  #define PORT_GP_2(bank, fn, sfx) _PORT_GP_CFG_2(bank, 0, fn, sfx, 0)
>> >  #define PORT_GP_4(bank, fn, sfx) _PORT_GP_CFG_4(bank, 0, fn, sfx, 0)
>> > ...
>> >  #define PORT_GP_32(bank, fn, sfx) _PORT_GP_CFG_32(bank, 0, fn, sfx, 0)
>> >
>> > and for the special (non-power-of-two) numbers e.g.
>> >
>> > #define PORT_GP_12(bank, fn, sfx) \
>> >         _PORT_GP_CFG_8(bank, 0, fn, sfx, 0) _PORT_GP_CFG_4(bank, 8, fn, sfx, 0)
>>
>> Ahh indeed, make sense !
>> I will use this idea. Thanks !
>
> Hmm... I'm tring this, but...
> Can I confirm ? Your idea was this
>
> #define _PORT_GP_CFG_2(bank, pin, fn, sfx, cfg) \
>         _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 1, fn, sfx, cfg)
>
> But I think you want this ?
>
> #define _PORT_GP_CFG_2(bank, pin, fn, sfx, cfg) \
> -        _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 1, fn, sfx, cfg)
> +        _PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) _PORT_GP_CFG_1(bank, pin + 1, fn, sfx, cfg)

Yes, sorry, that's what I meant.

> I noticed it seems difficult, because it is based on
>
>         #define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin, GP_##bank##_##pin, sfx, cfg)
>                                     ~~~                                            ~~~
> we can't use (pin + x) style.
> It seems we need all 0 - 32 definition anyway...

Oh right. CPP cannot evaluate the pin number arithmetic :-(

Then your previous patch is indeed the best we can do, I'm afraid.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

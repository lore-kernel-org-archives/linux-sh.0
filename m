From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2015 12:17:47 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <CAMuHMdXoAd4TFZNzcycisXSg0gd9nWKLRK0UQyAog4HWHJr5yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
	<87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Morimoto-san,

On Wed, Nov 11, 2015 at 6:29 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Many SoC needs each PORT_GP_x() macros, but we can share/reuse
> same one.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks!

I think this still can be improved upon...

ideally you just need log2(32) defines.

> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -205,22 +205,68 @@ struct sh_pfc_soc_info {
>  #define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin, GP_##bank##_##pin, sfx, cfg)
>  #define PORT_GP_1(bank, pin, fn, sfx)  PORT_GP_CFG_1(bank, pin, fn, sfx, 0)

"PORT_GP_1()" takes a "pin" parameter...

> -#define PORT_GP_CFG_32(bank, fn, sfx, cfg)                             \
> +#define PORT_GP_CFG_4(bank, fn, sfx, cfg)                                              \

... while "PORT_GP_CFG_X()" (with "X" > 1) don't.

>         PORT_GP_CFG_1(bank, 0,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 1,  fn, sfx, cfg),   \
> -       PORT_GP_CFG_1(bank, 2,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 3,  fn, sfx, cfg),   \
> +       PORT_GP_CFG_1(bank, 2,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 3,  fn, sfx, cfg)
> +#define PORT_GP_4(bank, fn, sfx)       PORT_GP_CFG_4(bank, fn, sfx, 0)
> +
> +#define PORT_GP_CFG_8(bank, fn, sfx, cfg)                                              \
> +       PORT_GP_CFG_4(bank, fn, sfx, cfg),                                              \
>         PORT_GP_CFG_1(bank, 4,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 5,  fn, sfx, cfg),   \
> -       PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg),   \
> +       PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg)
> +#define PORT_GP_8(bank, fn, sfx)       PORT_GP_CFG_8(bank, fn, sfx, 0)

Hence you can't simply define PORT_GP_8() in terms of PORT_GP_CFG_4().

So what about:

#define _PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin,
GP_##bank##_##pin, sfx, cfg)
#define _PORT_GP_CFG_2(bank, pin, fn, sfx, cfg) \
        _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 1,
fn, sfx, cfg)
#define _PORT_GP_CFG_4(bank, pin, fn, sfx, cfg) \
        _PORT_GP_CFG_2(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_2(bank, 2,
fn, sfx, cfg)
...
#define _PORT_GP_CFG_32(bank, pin, fn, sfx, cfg) \
        _PORT_GP_CFG_16(bank, 0, fn, sfx, cfg) _PORT_GP_CFG_16(bank,
16, fn, sfx, cfg)

All the rest (only the ones we really need) can be defined in terms of
the above.
E.g.

 #define PORT_GP_CFG_1(bank, fn, sfx, cfg) _PORT_GP_CFG_1(bank, 0, fn, sfx, cfg)
 #define PORT_GP_CFG_2(bank, fn, sfx, cfg) _PORT_GP_CFG_2(bank, 0, fn, sfx, cfg)
 #define PORT_GP_CFG_4(bank, pin, fn, sfx, cfg) _PORT_GP_CFG_4(bank,
0, fn, sfx, cfg)
...
 #define PORT_GP_CFG_32(bank, fn, sfx, cfg) _PORT_GP_CFG_32(bank, 0,
fn, sfx, cfg)

and

 #define PORT_GP_1(bank, fn, sfx) _PORT_GP_CFG_1(bank, 0, fn, sfx, 0)
 #define PORT_GP_2(bank, fn, sfx) _PORT_GP_CFG_2(bank, 0, fn, sfx, 0)
 #define PORT_GP_4(bank, fn, sfx) _PORT_GP_CFG_4(bank, 0, fn, sfx, 0)
...
 #define PORT_GP_32(bank, fn, sfx) _PORT_GP_CFG_32(bank, 0, fn, sfx, 0)

and for the special (non-power-of-two) numbers e.g.

#define PORT_GP_12(bank, fn, sfx) \
        _PORT_GP_CFG_8(bank, 0, fn, sfx, 0) _PORT_GP_CFG_4(bank, 8, fn, sfx, 0)

What do you think?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

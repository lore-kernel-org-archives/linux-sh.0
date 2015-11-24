From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Nov 2015 08:57:18 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <CAMuHMdVWG=0fm3_8xSCiSrOYdEwsR_UeD+AL7e+CXO1TGKNzhQ@mail.gmail.com>
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
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -205,22 +205,68 @@ struct sh_pfc_soc_info {
>  #define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin, GP_##bank##_##pin, sfx, cfg)
>  #define PORT_GP_1(bank, pin, fn, sfx)  PORT_GP_CFG_1(bank, pin, fn, sfx, 0)
>
> -#define PORT_GP_CFG_32(bank, fn, sfx, cfg)                             \
> +#define PORT_GP_CFG_4(bank, fn, sfx, cfg)                                              \
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
> +
> +#define PORT_GP_CFG_9(bank, fn, sfx, cfg)                                              \
> +       PORT_GP_CFG_8(bank, fn, sfx, cfg),                                              \
> +       PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg)
> +#define PORT_GP_9(bank, fn, sfx)       PORT_GP_CFG_9(bank, fn, sfx, 0)
> +
> +#define PORT_GP_CFG_12(bank, fn, sfx, cfg)                                             \
> +       PORT_GP_CFG_8(bank, fn, sfx, cfg),                                              \
>         PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 9,  fn, sfx, cfg),   \
> -       PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg),   \
> -       PORT_GP_CFG_1(bank, 12, fn, sfx, cfg), PORT_GP_CFG_1(bank, 13, fn, sfx, cfg),   \
> -       PORT_GP_CFG_1(bank, 14, fn, sfx, cfg), PORT_GP_CFG_1(bank, 15, fn, sfx, cfg),   \
> -       PORT_GP_CFG_1(bank, 16, fn, sfx, cfg), PORT_GP_CFG_1(bank, 17, fn, sfx, cfg),   \
> +       PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg)
> +#define PORT_GP_12(bank, fn, sfx)      PORT_GP_CFG_12(bank, fn, sfx, 0)

The *_8 and *_12 definitions don't seem to be used (except for defining
later variants in the series)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

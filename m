From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Jul 2014 07:50:36 +0000
Subject: Re: [PATCH] sh-pfc: sh73a0: Introduce the use of devm_regulator_register
Message-Id: <CAMuHMdULhp2kmJU-OnNzJL8g_sYi9RKGVqkAsgmG1jA7q1kPAw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140707160916.GA9238@himangi-Dell>
In-Reply-To: <20140707160916.GA9238@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himangi Saraogi <himangi774@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Linux-sh list <linux-sh@vger.kernel.org>

CC linux-sh

On Mon, Jul 7, 2014 at 6:09 PM, Himangi Saraogi <himangi774@gmail.com> wrote:
> This patch moves data allocated using regulator_register to
> devm_regulator_register and does away the calls to regulator_unregister.
> The sh73a0_pinmux_soc_exit function is no longer needed and is removed.
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
> To send to: Linus Walleij <linus.walleij@linaro.org>,linux-kernel@vger.kernel.org
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> index ee370de..0bd8f44 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> @@ -3842,7 +3842,8 @@ static int sh73a0_pinmux_soc_init(struct sh_pfc *pfc)
>         cfg.init_data = &sh73a0_vccq_mc0_init_data;
>         cfg.driver_data = pfc;
>
> -       data->vccq_mc0 = regulator_register(&sh73a0_vccq_mc0_desc, &cfg);
> +       data->vccq_mc0 = devm_regulator_register(pfc->dev,
> +                                                &sh73a0_vccq_mc0_desc, &cfg);
>         if (IS_ERR(data->vccq_mc0)) {
>                 ret = PTR_ERR(data->vccq_mc0);
>                 dev_err(pfc->dev, "Failed to register VCCQ MC0 regulator: %d\n",
> @@ -3855,16 +3856,8 @@ static int sh73a0_pinmux_soc_init(struct sh_pfc *pfc)
>         return 0;
>  }
>
> -static void sh73a0_pinmux_soc_exit(struct sh_pfc *pfc)
> -{
> -       struct sh73a0_pinmux_data *data = pfc->soc_data;
> -
> -       regulator_unregister(data->vccq_mc0);
> -}
> -
>  static const struct sh_pfc_soc_operations sh73a0_pinmux_ops = {
>         .init = sh73a0_pinmux_soc_init,
> -       .exit = sh73a0_pinmux_soc_exit,
>         .get_bias = sh73a0_pinmux_get_bias,
>         .set_bias = sh73a0_pinmux_set_bias,
>  };
> --
> 1.9.1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

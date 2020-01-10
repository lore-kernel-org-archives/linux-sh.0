From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jan 2020 13:22:47 +0000
Subject: Re: [PATCH 13/13] pinctrl: sh-pfc: checker: Add function GPIO checks
Message-Id: <CAMuHMdWPH=O0z6tFQRHR9+ud+ZE_yPaD4iEJY_v2YOfSaGpa2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be> <20200110131927.1029-14-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-14-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Fri, Jan 10, 2020 at 2:19 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add checks for legacy function GPIO descriptors:
>   1. Function GPIOs must have a name,
>   2. Names must be unique,
>   3. Enum ID values must be unique.
>
> This exposes bugs like those fixed in
>   - commit 884caadad128efad ("pinctrl: sh-pfc: sh7734: Fix duplicate
>     TCLK1_B"),
>   - commit 55b1cb1f03ad5eea ("pinctrl: sh-pfc: sh7264: Fix CAN function
>     GPIOs"),
>   - commit 02aeb2f21530c98f ("pinctrl: sh-pfc: sh7269: Fix CAN function
>     GPIOs"),
>   - commit db9c07272c8245a2 ("sh: sh7264: Remove bogus SSU GPIO function
>     definitions"),
>   - commit b4fba344a2930769 ("sh: sh7269: Remove bogus SSU GPIO function
>     definitions").
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pinctrl/sh-pfc/core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 34d3d210c7347336..5343729574849531 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -802,6 +802,13 @@ static int __init __sh_pfc_check_enum(const char *drvname, u16 enum_id)
>         return 0;
>  }
>
> +static void __init sh_pfc_check_enum(const char *drvname, const char *name,
> +                                    u16 enum_id)
> +{
> +       if (__sh_pfc_check_enum(drvname, enum_id))
> +               sh_pfc_err("%s enum_id %u conflict\n", name, enum_id);
> +}

Oops, I just realize this will be unused when CONFIG_PINCTRL_SH_FUNC_GPIO=n,
causing a compiler warning.
Will absorb into its sole caller below.

> +
>  static void __init sh_pfc_check_reg_enums(const char *drvname, u32 reg,
>                                           const u16 *enums, unsigned int n)
>  {
> @@ -1012,6 +1019,24 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
>                                        info->data_regs[i].enum_ids,
>                                        info->data_regs[i].reg_width);
>         }
> +
> +#ifdef CONFIG_PINCTRL_SH_FUNC_GPIO
> +       /* Check function GPIOs */
> +       for (i = 0; i < info->nr_func_gpios; i++) {
> +               const struct pinmux_func *func = &info->func_gpios[i];
> +
> +               if (!func->name) {
> +                       sh_pfc_err("empty function gpio %u\n", i);
> +                       continue;
> +               }
> +               for (j = 0; j < i; j++) {
> +                       if (same_name(func->name, info->func_gpios[j].name))
> +                               sh_pfc_err("func_gpio %s: name conflict\n",
> +                                          func->name);
> +               }
> +               sh_pfc_check_enum(drvname, func->name, func->enum_id);
> +       }
> +#endif
>  }
>
>  static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

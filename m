From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2015 10:04:39 +0000
Subject: Re: [PATCH 2/3] pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
Message-Id: <CAMuHMdXUHzZ3uWjQpW7VseJTrOmQoAvp9v=JtTW0sisGQoW8GA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426854638-9187-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1426854638-9187-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 20, 2015 at 1:30 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c

> +static const struct {
> +       u16 reg;
> +       u16 bit;
> +} pullups[] = {
> +       [RCAR_GP_PIN(0,  6)] = { PUPR0,  0 },   /* A0 */
> +       [RCAR_GP_PIN(0,  7)] = { PUPR0,  1 },   /* A1 */

...

> +};
> +
> +static unsigned int r8a7778_pinmux_get_bias(struct sh_pfc *pfc,
> +                                           unsigned int pin)
> +{
> +       void __iomem *addr;
> +
> +       BUG_ON(!pullups[pin].reg);

This looks a bit strong to me.

As pinconf_ops.pin_config_[gs]et() do return error codes, perhaps
sh_pfc_soc_operations.[gs]et_bias() should be changed to allow the
return of error codes, too, so you can return -ENOTSUPP here?

If you really feel the need to scream, I'd use WARN_ON_ONCE() instead.

> +       addr = pfc->windows->virt + pullups[pin].reg;
> +
> +       if (ioread32(addr) & BIT(pullups[pin].bit))
> +               return PIN_CONFIG_BIAS_PULL_UP;
> +       else
> +               return PIN_CONFIG_BIAS_DISABLE;
> +}
> +
> +static void r8a7778_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
> +                                  unsigned int bias)
> +{
> +       void __iomem *addr;
> +       u32 value;
> +       u32 bit;
> +
> +       BUG_ON(!pullups[pin].reg);

Same here.

> +       addr = pfc->windows->virt + pullups[pin].reg;
> +       bit = BIT(pullups[pin].bit);
> +
> +       value = ioread32(addr) & ~bit;
> +       if (bias = PIN_CONFIG_BIAS_PULL_UP)
> +               value |= bit;
> +       iowrite32(value, addr);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

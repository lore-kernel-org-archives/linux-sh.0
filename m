From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 14:08:23 +0000
Subject: Re: [PATCH 21/25] sh-pfc: Implement generic pinconf support
Message-Id: <CACRpkdZy6MOAJR4LH13qGR9-+R-MZHxLLbdB1Kj5gJhaVYcQ-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The existing PFC pinconf implementation, tied to the PFC-specific pin
> types, isn't used by drivers or boards. Replace it with the generic
> pinconf types to implement bias (pull-up/down) setup. Other pin
> configuration options can be implemented later if needed.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Basically really nice.

> +       select GENERIC_PINCONF

Especially that it uses generic pinconf.

>  static int sh_pfc_pinconf_get(struct pinctrl_dev *pctldev, unsigned _pin,
>                               unsigned long *config)
>  {
>         struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
>         struct sh_pfc *pfc = pmx->pfc;
> -       int idx = sh_pfc_get_pin_index(pfc, _pin);
> -       struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
> +       enum pin_config_param param = pinconf_to_config_param(*config);

This looks weird.

This function is supposed to read the hardware and return the
configuration from the hardware registers, not to validate
any configs? Especially the *config here should not be
read, only written.

> +       unsigned long flags;
> +       unsigned int bias;
> +
> +       if (!sh_pfc_pinconf_validate(pfc, _pin, param))
> +               return -ENOTSUPP;

This doesn't make any sense for the same reason.

> -       *config = cfg->type;
> +       switch (param) {
> +       case PIN_CONFIG_BIAS_DISABLE:
> +       case PIN_CONFIG_BIAS_PULL_UP:
> +       case PIN_CONFIG_BIAS_PULL_DOWN:
> +               if (!pfc->info->ops || !pfc->info->ops->get_bias)
> +                       return -ENOTSUPP;
> +
> +               spin_lock_irqsave(&pfc->lock, flags);
> +               bias = pfc->info->ops->get_bias(pfc, _pin);
> +               spin_unlock_irqrestore(&pfc->lock, flags);
> +
> +               if (bias != param)
> +                       return -EINVAL;
> +
> +               *config = 0;

Zero? I don't get it...

Nominally you should do something like:
*config = PIN_CONF_PACKED(param, arg);

here.

>  static const struct pinconf_ops sh_pfc_pinconf_ops = {
> -       .pin_config_get         = sh_pfc_pinconf_get,
> -       .pin_config_set         = sh_pfc_pinconf_set,
> -       .pin_config_dbg_show    = sh_pfc_pinconf_dbg_show,
> +       .is_generic                     = true,
> +       .pin_config_get                 = sh_pfc_pinconf_get,
> +       .pin_config_set                 = sh_pfc_pinconf_set,
> +       .pin_config_group_set           = sh_pfc_pinconf_group_set,
> +       .pin_config_config_dbg_show     = pinconf_generic_dump_config,
>  };

So the docs for pin_config_get may need improvement
if the intended usecase is not clear...

It can be used for example from debugfs to display the current
configuration of all pins.

Yours,
Linus Walleij

From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2014 14:53:59 +0000
Subject: Re: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify DT params
Message-Id: <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Additionally to the generic DT parameters, allow drivers to provide
> driver-specific DT parameters to be used with the generic parser
> infrastructure.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

I like the looks of this, but the patch description is a bit terse.
I'd like it to describe some of the refactorings being done
to the intrinsics, because I have a hard time following the patch.

First please rebase onto the "devel" branch in the pin control
tree, and notice that drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
which is merged there is actually doing this already:


        for_each_child_of_node(np_config, np) {
                ret =3D pinconf_generic_dt_subnode_to_map(pctldev, np, map,
                                                        &reserv, nmaps, typ=
e);
                if (ret)
                        break;

                ret =3D pmic_gpio_dt_subnode_to_map(pctldev, np, map, &rese=
rv,
                                                  nmaps, type);
                if (ret)
                        break;
        }

So it should be patched to illustrate the point of this code.

I'd like feedback from Ivan+Bj=C3=B6rn on the code too if possible.

> -       ret =3D pinconf_generic_parse_dt_config(np, &configs, &nconfigs);
> +       ret =3D pinconf_generic_parse_dt_config(np, pctldev, &configs, &n=
configs);
>         if (nconfigs)
>                 has_config =3D 1;
>         np_config =3D of_parse_phandle(np, "ste,config", 0);
>         if (np_config) {
> -               ret =3D pinconf_generic_parse_dt_config(np_config, &confi=
gs,
> -                               &nconfigs);
> +               ret =3D pinconf_generic_parse_dt_config(np_config, pctlde=
v,
> +                               &configs, &nconfigs);

This code is patched upstream so that ABx500 only uses generic config.
Again rebase on "devel"

> -void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
> -                             struct seq_file *s, unsigned pin)
> +static void _pinconf_generic_dump(struct pinctrl_dev *pctldev,
> +                                 struct seq_file *s, const char *gname,
> +                                 unsigned pin,
> +                                 const struct pin_config_item *items,
> +                                 int nitems)

Don't use functions named _foo, actually the underscore is for
preprocessor and compiler things in my book, just give it an intuitive
name instead. Like pinconf_generic_dump_one() if that is suitable
or whatever.

This changes the function signature from something quite intuitively
understood to something pretty hard to understand, so you need to
add kerneldoc to it. (That also enhance my understanding of the
patch.)

> -void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
> -                             struct seq_file *s, const char *gname)
> +static void pinconf_generic_dump(struct pinctrl_dev *pctldev,
> +                                struct seq_file *s, const char *gname,
> +                                unsigned pin)

This looks intuitive and nice.

> +       _pinconf_generic_dump(pctldev, s, gname, pin,
> +                             conf_items, ARRAY_SIZE(conf_items));
> +       if (pctldev->desc->num_dt_params) {
> +               BUG_ON(!pctldev->desc->conf_items);

Don't use BUG_ON() like that, it's nasty. Always try to
recover and bail out instead.

> +void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
> +                             struct seq_file *s, unsigned pin)
> +{
> +       pinconf_generic_dump(pctldev, s, NULL, pin);
> +}
> +
> +void pinconf_generic_dump_group(struct pinctrl_dev *pctldev,
> +                             struct seq_file *s, const char *gname)
> +{
> +       pinconf_generic_dump(pctldev, s, gname, 0);
> +}

Do you really need these helpers? Isn't it simpler just
to call the generic function with the different arguments?

> @@ -148,17 +132,22 @@ void pinconf_generic_dump_config(struct pinctrl_dev=
 *pctldev,
>                 seq_printf(s, "%s: 0x%x", conf_items[i].display,
>                            pinconf_to_config_argument(config));
>         }
> +
> +       if (!pctldev->desc->num_dt_params)
> +               return;
> +
> +       BUG_ON(!pctldev->desc->conf_items);

No BUG_ON() dev_err() and exit.

> +static void _parse_dt_cfg(struct device_node *np,
> +                         const struct pinconf_generic_dt_params *params,
> +                         unsigned int count,
> +                         unsigned long *cfg,
> +                         unsigned int *ncfg)

Should return an error code right? Kerneldoc doesn't hurt either.

> +{
> +       int i;
> +
> +       for (i =3D 0; i < count; i++) {
> +               u32 val;
> +               int ret;
> +               const struct pinconf_generic_dt_params *par =3D &params[i=
];
> +
> +               ret =3D of_property_read_u32(np, par->property, &val);

Not checking this return value. Alter the function to return an
int value on success.

> +
> +               /* property not found */
> +               if (ret =3D -EINVAL)
> +                       continue;
> +
> +               /* use default value, when no value is specified */
> +               if (ret)
> +                       val =3D par->default_value;
> +
> +               pr_debug("found %s with value %u\n", par->property, val);
> +               cfg[*ncfg] =3D pinconf_to_config_packed(par->param, val);
> +               (*ncfg)++;
> +       }
> +}

There is something very unintuitive about this loop. You pass two
counter indexes (count, ncfg) in basically, that is looking weird,
does it have to look like that? Especially since there is no
bounds check on ncfg!

Just use one index in the loop please. Assign  *ncfg =3D ... after
the loop has *successfully* iterated.

>  int pinconf_generic_parse_dt_config(struct device_node *np,
> +                                   struct pinctrl_dev *pctldev,
>                                     unsigned long **configs,
>                                     unsigned int *nconfigs)

This is a good refactoring, but no _foo naming!

>  {
>         unsigned long *cfg;
> -       unsigned int ncfg =3D 0;
> +       unsigned int max_cfg, ncfg =3D 0;
>         int ret;
> -       int i;
> -       u32 val;
>
>         if (!np)
>                 return -EINVAL;
>
>         /* allocate a temporary array big enough to hold one of each opti=
on */
> -       cfg =3D kzalloc(sizeof(*cfg) * ARRAY_SIZE(dt_params), GFP_KERNEL);
> +       max_cfg =3D ARRAY_SIZE(dt_params);
> +       if (pctldev)
> +               max_cfg +=3D pctldev->desc->num_dt_params;
> +       cfg =3D kcalloc(max_cfg, sizeof(*cfg), GFP_KERNEL);

Aha this looks good...

> +       _parse_dt_cfg(np, dt_params, ARRAY_SIZE(dt_params), cfg, &ncfg);
> +       if (pctldev && pctldev->desc->num_dt_params) {
> +               BUG_ON(!pctldev->desc->params);

No BUG_ON()

> +               _parse_dt_cfg(np, pctldev->desc->params,
> +                             pctldev->desc->num_dt_params, cfg, &ncfg);

This looks similar to what Qualcomm's driver is doing.

Yours,
Linus Walleij

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Jan 2016 14:20:46 +0000
Subject: Re: [RFC v2 3/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <CAMuHMdUuiuXPFJQpUB+Y3xF34KnqhzdZ+x-E7zL1ywp=sAQWXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
	<1452088285-6427-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-4-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Hi Wolfram,

On Wed, Jan 6, 2016 at 2:51 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This driver allows an I2C bus to switch between multiple masters. This
> is not hot-swichting because connected I2C slaves will be

switching

> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affetcing your use case.

affecting

> --- /dev/null
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -0,0 +1,276 @@
> +/*
> + * Pinctrl based I2C DeMultiplexer
> + *
> + * Copyright (C) 2015-16 by Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
> + * Copyright (C) 2015-16 by Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2 of the License.
> + *
> + * See the bindings doc for DTS setup.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +struct i2c_demux_pinctrl_chan {
> +       struct device_node *parent_np;
> +       struct i2c_adapter *parent_adap;
> +       struct of_changeset chgset;
> +};
> +
> +struct i2c_demux_pinctrl_priv {
> +       int cur_chan;
> +       int num_chan;

This is always positive, so you can make num_chan and a few loop counters
unsigned.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

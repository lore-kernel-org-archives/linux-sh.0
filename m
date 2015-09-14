From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 07:14:19 +0000
Subject: Re: [PATCH] clk: add CS2000 Fractional-N driver
Message-Id: <CAMuHMdX=vDeUSWy2sOmLQxOSGLJ7REXEAAdXO-p4pLT5zdf7EA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twqxk92u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twqxk92u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Mon, Sep 14, 2015 at 4:55 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch adds CS2000 Fractional-N driver as clock provider.
> It is useful if it supports runtime clock setting, but it supports
> fixed clock rate only at this point.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cs2000-cp.txt
> @@ -0,0 +1,20 @@
> +CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier
> +
> +Required properties:
> +
> +- compatible:          "cirrus,cs2000-cp"
> +- reg:                 The chip select number on the I2C bus
> +- clocks:              common clock binding for CLK_IN, XTI/REF_CLK

As you have multiple inputs, I think it makes sense to use "clock-names".

> --- /dev/null
> +++ b/drivers/clk/clk-cs2000-cp.c
> @@ -0,0 +1,379 @@
> +/*
> + * CS2000  --  CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier
> + *
> + * Copyright (C) 2015 Renesas Electronics Corporation
> + * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/i2c.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +
> +#define CLK_MAIN       0 /* CLK_IN  on datasheet */
> +#define CLK_IN         1 /* REF_CLK on datasheet */

Why do you call them differently from the datasheet?
Especially the different CLK_IN can be confusing.

> +#define cs2000_read(c, addr)           i2c_smbus_read_byte_data(c, addr)
> +static void cs2000_write(struct i2c_client *client, u8 addr, u8 val)
> +{
> +       struct device *dev = &client->dev;
> +
> +       dev_dbg(dev, "0x%02x : 0x%02x\n", addr, val);
> +
> +       i2c_smbus_write_byte_data(client, addr, val);

This can fail, so the error should be propagated, and checked in all
callers of cs2000_write().

> +}
> +
> +static void cs2000_bset(struct i2c_client *client, u8 addr, u8 mask, u8 val)
> +{
> +       u32 data;

i2c_smbus_read_byte_data returns s32, and the return value will be
negative in case of a failure.

> +       data = cs2000_read(client, addr);

Should check for failure.

> +       data &= ~mask;
> +       data |= (val & mask);
> +
> +       cs2000_write(client, addr, data);
> +}

> +static int cs2000_ratio_set(struct i2c_client *client,
> +                           int ch, u32 rate_in, u64 rate_out)
> +{
> +       u32 val;
> +       int i;

unsigned int i

> +       if (CH_ERR(ch))

I think it's more readable to drop the CH_ERR() macro, and open code
"(ch < 0) || (ch >= CH_MAX)" (also in cs2000_ratio_select()).

> +               return -EINVAL;
> +
> +       /*
> +        * ratio = rate_out / rate_in * 2^20
> +        *
> +        * To avoid over flow, rate_out is u64
> +        * The result should be u32
> +        */
> +
> +       val = rate_out * (1 << 20) / rate_in;

Please use do_div() for 64-by-32 divides, as full 64-bit divisions are
usually not available on 32-bit architectures.

> +static int cs2000_clk_get(struct i2c_client *client,
> +                         u32 *rate_in, u32 *rate_out)
> +{
> +       struct cs2000_priv *priv = i2c_get_clientdata(client);
> +       struct device *dev = &client->dev;
> +       struct device_node *np = dev->of_node;
> +       struct clk *clk_main, *clk_in;
> +
> +       clk_main = of_clk_get(np, CLK_MAIN);
> +       /* not yet provided */
> +       if (IS_ERR(clk_main))
> +               return -EPROBE_DEFER;
> +
> +       clk_in = of_clk_get(np, CLK_IN);
> +       if (IS_ERR(clk_in))
> +               return PTR_ERR(clk_in);

Named clk_get(), for both?

> +static int cs2000_wait_pll_lock(struct i2c_client *client)
> +{
> +       struct device *dev = &client->dev;
> +       u32 val;
> +       int i;

unsigned int

> +static int cs2000_version_print(struct i2c_client *client)
> +{
> +       struct device *dev = &client->dev;
> +       u32 val = cs2000_read(client, DEVICE_ID);

"s32 val", and please check for failures.

> +       char *revision;

const char *revision;

> +       /* CS2000 should be 0x0 */
> +       if (0 != (val >> 3))
> +               return -EIO;
> +
> +       switch (val & 0x7) {
> +       case 0x4:
> +               revision = "B2 / B3";
> +               break;
> +       case 0x6:
> +               revision = "C1";
> +               break;
> +       default:
> +               return -EIO;
> +       }
> +
> +       dev_info(dev, "revision - %s\n", revision);
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

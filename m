From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 15 Sep 2015 00:02:47 +0000
Subject: Re: [PATCH v3] clk: add CS2000 Fractional-N driver
Message-Id: <20150915000247.GJ23081@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1xljmn7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1xljmn7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org

On 09/14, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch adds CS2000 Fractional-N driver as clock provider.
> It is useful if it supports runtime clock setting, but it supports
> fixed clock rate only at this point.

Makes it sound pretty useless!

> 
> diff --git a/Documentation/devicetree/bindings/clock/cs2000-cp.txt b/Documentation/devicetree/bindings/clock/cs2000-cp.txt
> new file mode 100644
> index 0000000..a4479f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cs2000-cp.txt
> @@ -0,0 +1,22 @@
> +CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier

Is there a public datasheet for this somewhere?

> +
> +Required properties:
> +
> +- compatible:		"cirrus,cs2000-cp"
> +- reg:			The chip select number on the I2C bus
> +- clocks:		common clock binding for CLK_IN, XTI/REF_CLK
> +- clock-names:		CLK_IN : clk_in, XTI/REF_CLK : ref_clk
> +- clock-frequency:	clock frequency of CLK_OUT

Is this an assigned rate for the clock? Why isn't this node a
clock provider with clock-cells = 0? The code seems to indicate
that it is, but the binding doesn't.

And if it is the assigned rate of the one clock output, why isn't
that being done through assigned rates, or by whoever the
consumer is of the clock?

> +
> +Example:
> +
> +&i2c2 {
> +	...
> +	cs2000: clk_multiplier@0x4f {

Drop the 0x part.

	cs2000: clk_multiplier@4f {

> +		compatible = "cirrus,cs2000-cp";
> +		reg = <0x4f>;
> +		clocks = <&rcar_sound 0>, <&x12_clk>;
> +		clock-names = "clk_in", "ref_clk";
> +		clock-frequency = <24576000>; /* 1/1 divide */
> +	};
> +};
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 42f7120..5933e5f 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -95,6 +95,12 @@ config COMMON_CLK_CDCE925
>  	  Given a target output frequency, the driver will set the PLL and
>  	  divider to best approximate the desired output.
>  
> +config COMMON_CLK_CS2000_CP
> +	tristate "Clock driver for CS2000 Fractional-N Clock Synthesizer & Clock Multiplier"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the CS2000 clock multiplier

Please add a full stop "." here.

> diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
> new file mode 100644
> index 0000000..163b0cb
> --- /dev/null
> +++ b/drivers/clk/clk-cs2000-cp.c
> @@ -0,0 +1,383 @@
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

Hm... generally we don't want providers doing clk consumer
things.

> +#include <linux/i2c.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
[...]
> +
> +static int cs2000_ratio_set(struct i2c_client *client,
> +			    int ch, u32 rate_in, u32 rate_out)
> +{
> +	u64 val;
> +	unsigned int i;
> +	int ret;
> +
> +	if (CH_SIZE_ERR(ch))
> +		return -EINVAL;
> +
> +	/*
> +	 * ratio = rate_out / rate_in * 2^20
> +	 *
> +	 * To avoid over flow, rate_out is u64
> +	 * The result should be u32
> +	 */
> +	val = (u64)rate_out << 20;
> +	do_div(val, rate_in);
> +	for (i = 0; i < 4; i++) {
> +		ret = cs2000_write(client,
> +				   Ratio_Add(ch, i),
> +				   Ratio_Val(val, i));
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs2000_ratio_select(struct i2c_client *client, int ch)
> +{
> +	int ret;
> +
> +	if (CH_SIZE_ERR(ch))
> +		return -EINVAL;
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * this driver supports static ratio mode only
> +	 * at this point
> +	 */
> +	ret = cs2000_bset(client, DEVICE_CFG1, RSEL_MASK, RSEL(ch));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cs2000_write(client, DEVICE_CFG2, 0x0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

These are close to what would be done for a clk_set_rate()
implementation so why can't we have real clk_ops?

> +
> +static int cs2000_enable_dev_config(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = cs2000_bset(client, DEVICE_CFG1, ENDEV1, ENDEV1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cs2000_bset(client, GLOBAL_CFG,  ENDEV2, ENDEV2);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int cs2000_clk_get(struct i2c_client *client,
> +			  u32 *rate_in, u32 *rate_out)
> +{
> +	struct cs2000_priv *priv = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
> +	struct clk *clk_in, *ref_clk;
> +
> +	clk_in = devm_clk_get(dev, "clk_in");
> +	/* not yet provided */
> +	if (IS_ERR(clk_in))
> +		return -EPROBE_DEFER;
> +
> +	ref_clk = devm_clk_get(dev, "ref_clk");
> +	if (IS_ERR(ref_clk))
> +		return PTR_ERR(ref_clk);
> +
> +	*rate_in = clk_get_rate(ref_clk);
> +
> +	if (of_property_read_u32(np, "clock-frequency", rate_out))
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "%d -> %d\n",
> +		*rate_in, *rate_out);

These two lines could fit on one line.

> +
> +	priv->clk_in	= clk_in;
> +	priv->ref_clk	= ref_clk;
> +
> +	return 0;
> +}
> +
> +static int cs2000_clk_in_bound_rate(struct i2c_client *client,
> +				    u32 rate_in)
> +{
> +	u32 val;
> +
> +	if ((32000000 <= rate_in) &&
> +	    (56000000 >  rate_in))
> +		val = 0x0;

Please drop useless parentheses.

	if (32000000 <= rate_in && 56000000 > rate_in)

> +	else if ((16000000 <= rate_in) &&
> +		 (28000000 >  rate_in))
> +		val = 0x1;
> +	else if ((8000000 <= rate_in) &&
> +		 (14000000 > rate_in))
> +		val = 0x2;

Same for these two.

> +	else
> +		return -EINVAL;
> +
> +	return cs2000_bset(client, FUNC_CFG1, 0x3 << 3, val << 3);
> +}
[..]
> +
> +static int cs2000_clk_register(struct i2c_client *client)
> +{
> +	struct cs2000_priv *priv = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
> +	struct clk *clk;
> +	const char *parent_clk_name = __clk_get_name(priv->ref_clk);
> +	u32 rate;
> +
> +	if (of_property_read_u32(np, "clock-frequency", &rate))
> +		return -EINVAL;
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * register this driver as fixed rate clock
> +	 * at this point
> +	 */
> +	clk = clk_register_fixed_rate(dev, "clk_out", parent_clk_name,
> +				      (parent_clk_name) ? 0 : CLK_IS_ROOT,
> +				      rate);

So are there consumers for this clock? To keep DT backwards
compatibility it may be better to use the assigned clock rates
property, but not register the of_clk_provider until this driver
is ready to register a proper clock with clk_ops.

> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	priv->clk_out = clk;
> +	of_clk_add_provider(np, of_clk_src_simple_get, clk);

What if of_clk_add_provider() fails?

> +
> +	return 0;
> +}
> +
> +static void cs2000_clk_unregister(struct i2c_client *client)
> +{
> +	struct cs2000_priv *priv = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	of_clk_del_provider(np);
> +	clk_put(priv->clk_out);

We never called clk_get() to get this clock, so don't call
clk_put() on it here. Perhaps you meant clk_unregister()?

> +
> +	priv->clk_out = NULL;

Is there any use to do this?

> +}
> +
> +static int cs2000_version_print(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	s32 val = cs2000_read(client, DEVICE_ID);
> +	const char *revision;
> +
> +	if (val < 0)
> +		return val;
> +
> +	/* CS2000 should be 0x0 */
> +	if (0 != (val >> 3))
> +		return -EIO;
> +
> +	switch (val & 0x7) {
> +	case 0x4:
> +		revision = "B2 / B3";
> +		break;
> +	case 0x6:
> +		revision = "C1";
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	dev_info(dev, "revision - %s\n", revision);
> +
> +	return 0;
> +}
> +
> +static int cs2000_remove(struct i2c_client *client)
> +{
> +	cs2000_clk_unregister(client);
> +
> +	return 0;
> +}

What's the point of this function? Just use
cs2000_clk_unregister() and change the return code of that
function to return 0?

> +
> +static int cs2000_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct cs2000_priv *priv;
> +	struct device *dev = &client->dev;
> +	u32 rate_in = 0;
> +	u32 rate_out = 0;
> +	int ret;
> +	int ch = 0;

Does this ever change?

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, priv);
> +
> +	ret = cs2000_clk_get(client, &rate_in, &rate_out);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cs2000_enable_dev_config(client);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_clk_in_bound_rate(client, rate_in);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_ratio_set(client, ch, rate_in, rate_out);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_ratio_select(client, ch);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_wait_pll_lock(client);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_clk_out_enable(client);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_clk_register(client);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	ret = cs2000_version_print(client);
> +	if (ret < 0)
> +		goto probe_err;
> +
> +	return 0;
> +
> +probe_err:
> +	cs2000_remove(client);

We don't register the clock and provider until
cs2000_clk_register() but this remove call undoes those things
even if there's an error in ratio_set() or earlier.

> +
> +	return ret;
> +}
> +
> +static struct i2c_driver cs2000_driver = {
> +	.driver = {
> +		.name = "cs2000-cp",
> +		.owner = THIS_MODULE,

This can be dropped. module_i2c_driver() does it already.

> +		.of_match_table = cs2000_of_match,
> +	},
> +	.probe		= cs2000_probe,
> +	.remove		= cs2000_remove,
> +	.id_table	= cs2000_id,
> +};
> +
> +module_i2c_driver(cs2000_driver);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

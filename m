From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 02 Oct 2015 00:38:51 +0000
Subject: Re: [PATCH v4] clk: add CS2000 Fractional-N driver
Message-Id: <20151002003851.GH12338@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <871te03x17.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871te03x17.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org

On 09/15, Kuninori Morimoto wrote:
> +
> +static int cs2000_clk_register(struct cs2000_priv *priv)
> +{
> +	struct device *dev = priv_to_dev(priv);
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data init;
> +	const char *name = np->name;
> +	struct clk *clk;
> +	static const char *parent_names[CLK_MAX];
> +	int ret;
> +
> +	of_property_read_string(np, "clock-output-names", &name);
> +
> +	parent_names[CLK_IN]	= __clk_get_name(priv->clk_in);
> +	parent_names[REF_CLK]	= __clk_get_name(priv->ref_clk);
> +
> +	init.name		= name;
> +	init.ops		= &cs2000_ops;
> +	init.flags		= CLK_IS_BASIC | CLK_SET_RATE_GATE;

It's not basic.

> +	init.parent_names	= parent_names;
> +	init.num_parents	= ARRAY_SIZE(parent_names);
> +
> +	priv->hw.init = &init;
> +
> +	clk = clk_register(NULL, &priv->hw);

How about using devm_clk_register() and passing the i2c device
down to this function?

> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +	if (ret < 0) {
> +		clk_unregister(clk);
> +		return ret;
> +	}
> +
> +	priv->clk_out = clk;
> +
> +	return 0;
> +}
> +
> +static int cs2000_clk_init(struct cs2000_priv *priv)
> +{
> +	struct device *dev = priv_to_dev(priv);
> +	struct device_node *np = dev->of_node;
> +	u32 rate;
> +	int ch = 0; /* it uses ch0 only at this point */
> +	int ret;
> +
> +	if (of_property_read_u32(np, "clock-frequency", &rate))

Why can't we do this with DT assigned rates?

> +		return 0;
> +
> +	ret = __cs2000_set_rate(priv, ch, rate, clk_get_rate(priv->ref_clk));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __cs2000_enable(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

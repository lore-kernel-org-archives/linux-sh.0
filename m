From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Oct 2015 01:11:09 +0000
Subject: Re: [PATCH v4] clk: add CS2000 Fractional-N driver
Message-Id: <87twqarsdf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871te03x17.wl%kuninori.morimoto.gx@renesas.com>
	<20151002003851.GH12338@codeaurora.org>
In-Reply-To: <20151002003851.GH12338@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org


Hi Stephen

Thank you for your review

> > +	init.parent_names	= parent_names;
> > +	init.num_parents	= ARRAY_SIZE(parent_names);
> > +
> > +	priv->hw.init = &init;
> > +
> > +	clk = clk_register(NULL, &priv->hw);
> 
> How about using devm_clk_register() and passing the i2c device
> down to this function?

Can I confirm ?
Does this "i2c device down" means call i2c_set_clientdata()
in this function ?

> > +static int cs2000_clk_init(struct cs2000_priv *priv)
> > +{
> > +	struct device *dev = priv_to_dev(priv);
> > +	struct device_node *np = dev->of_node;
> > +	u32 rate;
> > +	int ch = 0; /* it uses ch0 only at this point */
> > +	int ret;
> > +
> > +	if (of_property_read_u32(np, "clock-frequency", &rate))
> 
> Why can't we do this with DT assigned rates?

What doesn this "DT assigned rates" mean ?
this rate will be used as default output

From: Stephen Boyd <sboyd@codeaurora.org>
Date: Fri, 02 Oct 2015 18:11:23 +0000
Subject: Re: [PATCH v4] clk: add CS2000 Fractional-N driver
Message-Id: <20151002181123.GM12338@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <871te03x17.wl%kuninori.morimoto.gx@renesas.com>
 <20151002003851.GH12338@codeaurora.org>
 <87twqarsdf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twqarsdf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org

On 10/02, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> Thank you for your review
> 
> > > +	init.parent_names	= parent_names;
> > > +	init.num_parents	= ARRAY_SIZE(parent_names);
> > > +
> > > +	priv->hw.init = &init;
> > > +
> > > +	clk = clk_register(NULL, &priv->hw);
> > 
> > How about using devm_clk_register() and passing the i2c device
> > down to this function?
> 
> Can I confirm ?
> Does this "i2c device down" means call i2c_set_clientdata()
> in this function ?

I mean passing a struct device pointer to this function and then
using it here in the clk_register() function.

> 
> > > +static int cs2000_clk_init(struct cs2000_priv *priv)
> > > +{
> > > +	struct device *dev = priv_to_dev(priv);
> > > +	struct device_node *np = dev->of_node;
> > > +	u32 rate;
> > > +	int ch = 0; /* it uses ch0 only at this point */
> > > +	int ret;
> > > +
> > > +	if (of_property_read_u32(np, "clock-frequency", &rate))
> > 
> > Why can't we do this with DT assigned rates?
> 
> What doesn this "DT assigned rates" mean ?
> this rate will be used as default output

See the "Assigned clock parents and rates" section of
Documentation/devicetree/bindings/clock/clock-bindings.txt and
commit 86be408bfbd8 (clk: Support for clock parents and rates
assigned from device tree, 2014-06-18).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

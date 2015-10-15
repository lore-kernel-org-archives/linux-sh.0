From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Oct 2015 01:35:19 +0000
Subject: Re: [PATCH v4] clk: add CS2000 Fractional-N driver
Message-Id: <87r3kwor4d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871te03x17.wl%kuninori.morimoto.gx@renesas.com>
	<20151002003851.GH12338@codeaurora.org>
	<87twqarsdf.wl%kuninori.morimoto.gx@renesas.com>
	<20151002181123.GM12338@codeaurora.org>
In-Reply-To: <20151002181123.GM12338@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org


Hi Stephen

> > Can I confirm ?
> > Does this "i2c device down" means call i2c_set_clientdata()
> > in this function ?
>
> I mean passing a struct device pointer to this function and then
> using it here in the clk_register() function.

I understand. will fix in v5

> > > > +static int cs2000_clk_init(struct cs2000_priv *priv)
> > > > +{
> > > > +	struct device *dev = priv_to_dev(priv);
> > > > +	struct device_node *np = dev->of_node;
> > > > +	u32 rate;
> > > > +	int ch = 0; /* it uses ch0 only at this point */
> > > > +	int ret;
> > > > +
> > > > +	if (of_property_read_u32(np, "clock-frequency", &rate))
> > >
> > > Why can't we do this with DT assigned rates?
> >
> > What doesn this "DT assigned rates" mean ?
> > this rate will be used as default output
>
> See the "Assigned clock parents and rates" section of
> Documentation/devicetree/bindings/clock/clock-bindings.txt and
> commit 86be408bfbd8 (clk: Support for clock parents and rates
> assigned from device tree, 2014-06-18).

I understand. If my understanding is correct, user driver
setups/enables this clock.
If so, I still want this "clock-frequency" feature.
because this clock requests other clock on my board.
And requested clock requests this clock too.
Thus, these clocks have dead lock on probe time

	cs2000: clk_multiplier@4f {
		...
		clocks = <&rcar_sound 0>, ...
		...
	};

	&rcar_sound {
		...
		assigned-clocks = <&cs2000>;
	        assigned-clock-rates = <24576000>;
		...
	};



Best regards
---
Kuninori Morimoto

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 Jun 2013 14:52:28 +0000
Subject: Re: [PATCH 2/2] regulators: max8973: initial DT support
Message-Id: <Pine.LNX.4.64.1306211651120.27277@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306210825040.27277@axis700.grange>
 <Pine.LNX.4.64.1306210827090.27277@axis700.grange> <20130621144423.GX27646@sirena.org.uk>
In-Reply-To: <20130621144423.GX27646@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Mark

Thanks for the review

On Fri, 21 Jun 2013, Mark Brown wrote:

> On Fri, Jun 21, 2013 at 08:30:26AM +0200, Guennadi Liakhovetski wrote:
> 
> > +Required properties:
> > +
> > +- compatible:	must be "maxium,max8973"
> > +- reg:		the i2c slave address of the regulator. It should be 0x1b.
> > +- regulators:	a subnode with a single regulator descriptor in it called "dcdc"
> 
> Why make this a subnode - if there's only one regulator on the device
> then it may as well just put all the regulator properties there?

Right, I wasn't sure about this, I thought it was kind of a common 
practice even for just one regulator. Will embed, sure.

> 
> > +	if (!regulators) {
> > +		dev_err(dev, "regulator node not found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = of_regulator_match(dev, regulators,
> > +				 &max8973_regulator_match, 1);
> > +	of_node_put(regulators);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Error parsing regulator init data: %d\n", ret);
> > +		return ret;
> > +	}
> > +	if (!ret) {
> > +		dev_err(dev, "No regulator configuration found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> 
> This would simplify the code here, the driver can just call
> of_get_regulator_init_data() directly with the node.

Ok, I'll look at it.

> > -	if (!pdata->enable_ext_control) {
> > +	if (!pdata || !pdata->enable_ext_control) {
> >  		max->desc.enable_reg = MAX8973_VOUT;
> >  		max->desc.enable_mask = MAX8973_VOUT_ENABLE;
> >  		max->ops.enable = regulator_enable_regmap;
> 
> A common approach here is just to embed the platform data in the
> driver data then copy actual platform data in there or parse the device
> tree bindings (when added) into the structure.  This means that most of
> the driver can just assume there's platform data which makes life a bit
> simpler.

But we can do this later, when we add DT support for those parameters, 
right?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 24 Jun 2013 21:10:30 +0000
Subject: Re: [PATCH v2 2/2] regulators: max8973: initial DT support
Message-Id: <Pine.LNX.4.64.1306242305150.26438@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306241246580.19735@axis700.grange>
 <51C88E96.2010408@cogentembedded.com>
In-Reply-To: <51C88E96.2010408@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Mon, 24 Jun 2013, Sergei Shtylyov wrote:

> Hello.
> 
> On 06/24/2013 02:50 PM, Guennadi Liakhovetski wrote:
> 
> > This patch adds primitive DT support to the max8973 regulator driver. None
> > of the configuration parameters, supported in the platform data are yet
> > available in DT, therefore no configuration is performed if booting with
> > no platform data. This means, that DT instantiation can only be used on
> > boards, where no run-time configuration of the chip is required. In such
> > cases the driver can be used to scale its output voltage. In the future
> > support for configuration parameters should be added.
> 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> 
> > v2: as suggested by Mark, regulator bindings are now directly under the
> > main max8973 I2C device node.
> 
> >   .../bindings/regulator/max8973-regulator.txt       |   21 +++++++++++
> >   drivers/regulator/max8973-regulator.c              |   37
> > +++++++++++++------
> >   2 files changed, 46 insertions(+), 12 deletions(-)
> >   create mode 100644
> > Documentation/devicetree/bindings/regulator/max8973-regulator.txt
> 
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
> > b/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
> > new file mode 100644
> > index 0000000..8d38ab2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/max8973-regulator.txt
> > @@ -0,0 +1,21 @@
> > +* Maxim MAX8973 Voltage Regulator
> > +
> > +Required properties:
> > +
> > +- compatible:	must be "maxium,max8973"
> 
>    I see only "maxim" and "dallas" for Maxim Integrated Products in
> Documentation/devicetree/bindings/vendor-prefixes.txt. Is "maxium" some new,
> unknown vendor?

Yeah, it's an alias ;-) No, sure, it's a typo, thanks for catching. In 
fact, it still works, becaus I2C OF parsing doesn't use the vendor string, 
but it's better to get it right.

Mark, you said you'd already applied this. Would you prefer an incremental 
patch or shall I send an updated version?

> 
> > +- reg:		the i2c slave address of the regulator. It should be
> > 0x1b.
> > +
> > +Any standard regulator properties can be used to configure the single
> > max8973
> > +DCDC.
> > +
> > +Example:
> > +
> > +	max8973@1b {
> > +		compatible = "maxium,max8973";
> > +		reg = <0x1b>;
> > +
> > +		regulator-min-microvolt = <935000>;
> > +		regulator-max-microvolt = <1200000>;
> > +		regulator-boot-on;
> > +		regulator-always-on;
> > +	};
> > diff --git a/drivers/regulator/max8973-regulator.c
> > b/drivers/regulator/max8973-regulator.c
> > index b2dbdd7..0c5195a 100644
> > --- a/drivers/regulator/max8973-regulator.c
> > +++ b/drivers/regulator/max8973-regulator.c
> [...]
> > @@ -439,16 +447,21 @@ static int max8973_probe(struct i2c_client *client,
> [...]
> > +	if (pdata) {
> > +		ret = max8973_init_dcdc(max, pdata);
> > +		if (ret < 0) {
> > +			dev_err(max->dev, "Max8973 Init failed, err = %d\n",
> > ret);
> 
>    Not "MAX8973"?

If you hadn't removed the "-" lines, you would've seen, that I didn't 
invent this string but just moved it from one place to another.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

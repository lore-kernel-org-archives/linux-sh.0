From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 07 Aug 2014 00:36:37 +0000
Subject: Re: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <8761i5kuel.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
	<87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
	<20140807001805.GE32652@verge.net.au>
In-Reply-To: <20140807001805.GE32652@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>


Hi Simon

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > This patch adds DT compatible for Renesas R-Car Gen1/Gen2.
> > Current driver has SoC level .compatible
> > (r8a7778/r8a7779/r8a7790/r8a7791/r8a7792/r8a7793/r8a7794),
> > but these can be match as generation level.
> 
> Hi Morimoto-san,
> 
> is this compatibility explicitly documented somewhere?

?
Do you mean ${LINUX}/Documentation/devicetree/bindings/xxx ?
[1/5] patch have it, but is it not enough ?

> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    4 +++-
> >  drivers/i2c/busses/i2c-rcar.c                      |    2 ++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > index 16b3e07..0f9e812 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > @@ -3,6 +3,8 @@ I2C for R-Car platforms
> >  Required properties:
> >  - compatible: Must be one of
> >  	"renesas,i2c-rcar"
> > +	"renesas,i2c-rcar-gen1"
> > +	"renesas,i2c-rcar-gen2"
> >  	"renesas,i2c-r8a7778"
> >  	"renesas,i2c-r8a7779"
> >  	"renesas,i2c-r8a7790"
> > @@ -24,7 +26,7 @@ Examples :
> >  i2c0: i2c@e6508000 {
> >  	#address-cells = <1>;
> >  	#size-cells = <0>;
> > -	compatible = "renesas,i2c-r8a7791";
> > +	compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
> >  	reg = <0 0xe6508000 0 0x40>;
> >  	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
> >  	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
> > diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> > index f3c7139..6f805f8 100644
> > --- a/drivers/i2c/busses/i2c-rcar.c
> > +++ b/drivers/i2c/busses/i2c-rcar.c
> > @@ -487,6 +487,8 @@ static const struct i2c_algorithm rcar_i2c_algo = {
> >  
> >  static const struct of_device_id rcar_i2c_dt_ids[] = {
> >  	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
> > +	{ .compatible = "renesas,i2c-rcar-gen1", .data = (void *)I2C_RCAR_GEN1 },
> > +	{ .compatible = "renesas,i2c-rcar-gen2", .data = (void *)I2C_RCAR_GEN2 },
> >  	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
> >  	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
> >  	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
> > -- 
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Simon Horman <horms@verge.net.au>
Date: Thu, 07 Aug 2014 01:10:28 +0000
Subject: Re: [PATCH 1/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <20140807011025.GA3284@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
 <87r40uw7rp.wl%kuninori.morimoto.gx@renesas.com>
 <20140807001805.GE32652@verge.net.au>
 <8761i5kuel.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761i5kuel.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux-SH <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Aug 06, 2014 at 05:36:37PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > This patch adds DT compatible for Renesas R-Car Gen1/Gen2.
> > > Current driver has SoC level .compatible
> > > (r8a7778/r8a7779/r8a7790/r8a7791/r8a7792/r8a7793/r8a7794),
> > > but these can be match as generation level.
> > 
> > Hi Morimoto-san,
> > 
> > is this compatibility explicitly documented somewhere?
> 
> ?
> Do you mean ${LINUX}/Documentation/devicetree/bindings/xxx ?
> [1/5] patch have it, but is it not enough ?

Sorry for not being clearer.

At our face-to-face meeting in Montpellier we discussed the
idea of generation bindings. And my recollection is that Magnus
and I had strong reservations about declaring what generation compatibility
is without it being explicitly stated in hardware documentation.

From observation we can say that the i2c controllers on r8a7778 and r8a7779
appear to be compatible. But can we say that in fact they are in fact
compatible hardware. That they are different hardware instances of a common
i2c controller whose name may or may not be is known to us? If not
I do not think that using a common binding describes the hardware,
which is the intention of DT bindings.

A second problem is the using the generation as a name.  Assuming the
answer to the above question is yes can we further say with certainty
that all variants of Gen1 SoCs that currently exist or will exist in the
future are compatible?  If not then using Gen1 as the name does not seem
to accurately describe the hardware.

> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > >  Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    4 +++-
> > >  drivers/i2c/busses/i2c-rcar.c                      |    2 ++
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > > index 16b3e07..0f9e812 100644
> > > --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > > +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> > > @@ -3,6 +3,8 @@ I2C for R-Car platforms
> > >  Required properties:
> > >  - compatible: Must be one of
> > >  	"renesas,i2c-rcar"
> > > +	"renesas,i2c-rcar-gen1"
> > > +	"renesas,i2c-rcar-gen2"
> > >  	"renesas,i2c-r8a7778"
> > >  	"renesas,i2c-r8a7779"
> > >  	"renesas,i2c-r8a7790"
> > > @@ -24,7 +26,7 @@ Examples :
> > >  i2c0: i2c@e6508000 {
> > >  	#address-cells = <1>;
> > >  	#size-cells = <0>;
> > > -	compatible = "renesas,i2c-r8a7791";
> > > +	compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";
> > >  	reg = <0 0xe6508000 0 0x40>;
> > >  	interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
> > >  	clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
> > > diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> > > index f3c7139..6f805f8 100644
> > > --- a/drivers/i2c/busses/i2c-rcar.c
> > > +++ b/drivers/i2c/busses/i2c-rcar.c
> > > @@ -487,6 +487,8 @@ static const struct i2c_algorithm rcar_i2c_algo = {
> > >  
> > >  static const struct of_device_id rcar_i2c_dt_ids[] = {
> > >  	{ .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
> > > +	{ .compatible = "renesas,i2c-rcar-gen1", .data = (void *)I2C_RCAR_GEN1 },
> > > +	{ .compatible = "renesas,i2c-rcar-gen2", .data = (void *)I2C_RCAR_GEN2 },
> > >  	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
> > >  	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
> > >  	{ .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
> > > -- 
> > > 1.7.9.5
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

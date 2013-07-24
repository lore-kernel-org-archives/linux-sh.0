From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Jul 2013 00:26:55 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: 32-bit control register support
Message-Id: <20130724002655.GA532@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374207810.git.horms+renesas@verge.net.au>
 <2792cc6f22031110f6959c02d42d7b6116105a71.1374207810.git.horms+renesas@verge.net.au>
 <51ECAF43.80200@linaro.org>
In-Reply-To: <51ECAF43.80200@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Jul 22, 2013 at 06:04:19AM +0200, Daniel Lezcano wrote:
> On 07/19/2013 06:36 AM, Simon Horman wrote:
> > From: Magnus Damm <damm@opensource.se>
> >=20
> > Add support for CMT hardware with 32-bit control and counter
> > registers, as found on r8a73a4 and r8a7790. To use the CMT
> > with 32-bit hardware a second I/O memory resource needs to
> > point out the CMSTR register and it needs to be 32 bit wide.
> >=20
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
>=20
> In the future, can you Cc drivers/clocksource maintainers please ?

Yes of course, sorry for that oversight.

> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Olof, Arnd, please let me know if you wish me to re-send the pull
request with Daniel's Reviewed-by added to this patch.

>=20
> >  drivers/clocksource/sh_cmt.c |   50 ++++++++++++++++++++++++++++++----=
--------
> >  1 file changed, 36 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> > index 08d0c41..0965e98 100644
> > --- a/drivers/clocksource/sh_cmt.c
> > +++ b/drivers/clocksource/sh_cmt.c
> > @@ -37,6 +37,7 @@
> > =20
> >  struct sh_cmt_priv {
> >  	void __iomem *mapbase;
> > +	void __iomem *mapbase_str;
> >  	struct clk *clk;
> >  	unsigned long width; /* 16 or 32 bit version of hardware block */
> >  	unsigned long overflow_bit;
> > @@ -79,6 +80,12 @@ struct sh_cmt_priv {
> >   * CMCSR 0xffca0060 16-bit
> >   * CMCNT 0xffca0064 32-bit
> >   * CMCOR 0xffca0068 32-bit
> > + *
> > + * "32-bit counter and 32-bit control" as found on r8a73a4 and r8a7790:
> > + * CMSTR 0xffca0500 32-bit
> > + * CMCSR 0xffca0510 32-bit
> > + * CMCNT 0xffca0514 32-bit
> > + * CMCOR 0xffca0518 32-bit
> >   */
> > =20
> >  static unsigned long sh_cmt_read16(void __iomem *base, unsigned long o=
ffs)
> > @@ -109,9 +116,7 @@ static void sh_cmt_write32(void __iomem *base, unsi=
gned long offs,
> > =20
> >  static inline unsigned long sh_cmt_read_cmstr(struct sh_cmt_priv *p)
> >  {
> > -	struct sh_timer_config *cfg =3D p->pdev->dev.platform_data;
> > -
> > -	return p->read_control(p->mapbase - cfg->channel_offset, 0);
> > +	return p->read_control(p->mapbase_str, 0);
> >  }
> > =20
> >  static inline unsigned long sh_cmt_read_cmcsr(struct sh_cmt_priv *p)
> > @@ -127,9 +132,7 @@ static inline unsigned long sh_cmt_read_cmcnt(struc=
t sh_cmt_priv *p)
> >  static inline void sh_cmt_write_cmstr(struct sh_cmt_priv *p,
> >  				      unsigned long value)
> >  {
> > -	struct sh_timer_config *cfg =3D p->pdev->dev.platform_data;
> > -
> > -	p->write_control(p->mapbase - cfg->channel_offset, 0, value);
> > +	p->write_control(p->mapbase_str, 0, value);
> >  }
> > =20
> >  static inline void sh_cmt_write_cmcsr(struct sh_cmt_priv *p,
> > @@ -676,7 +679,7 @@ static int sh_cmt_register(struct sh_cmt_priv *p, c=
har *name,
> >  static int sh_cmt_setup(struct sh_cmt_priv *p, struct platform_device =
*pdev)
> >  {
> >  	struct sh_timer_config *cfg =3D pdev->dev.platform_data;
> > -	struct resource *res;
> > +	struct resource *res, *res2;
> >  	int irq, ret;
> >  	ret =3D -ENXIO;
> > =20
> > @@ -694,6 +697,9 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, stru=
ct platform_device *pdev)
> >  		goto err0;
> >  	}
> > =20
> > +	/* optional resource for the shared timer start/stop register */
> > +	res2 =3D platform_get_resource(p->pdev, IORESOURCE_MEM, 1);
> > +
> >  	irq =3D platform_get_irq(p->pdev, 0);
> >  	if (irq < 0) {
> >  		dev_err(&p->pdev->dev, "failed to get irq\n");
> > @@ -707,6 +713,15 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, str=
uct platform_device *pdev)
> >  		goto err0;
> >  	}
> > =20
> > +	/* map second resource for CMSTR */
> > +	p->mapbase_str =3D ioremap_nocache(res2 ? res2->start :
> > +					 res->start - cfg->channel_offset,
> > +					 res2 ? resource_size(res2) : 2);
> > +	if (p->mapbase_str =3D NULL) {
> > +		dev_err(&p->pdev->dev, "failed to remap I/O second memory\n");
> > +		goto err1;
> > +	}
> > +
> >  	/* request irq using setup_irq() (too early for request_irq()) */
> >  	p->irqaction.name =3D dev_name(&p->pdev->dev);
> >  	p->irqaction.handler =3D sh_cmt_interrupt;
> > @@ -719,11 +734,17 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, st=
ruct platform_device *pdev)
> >  	if (IS_ERR(p->clk)) {
> >  		dev_err(&p->pdev->dev, "cannot get clock\n");
> >  		ret =3D PTR_ERR(p->clk);
> > -		goto err1;
> > +		goto err2;
> >  	}
> > =20
> > -	p->read_control =3D sh_cmt_read16;
> > -	p->write_control =3D sh_cmt_write16;
> > +	if (res2 && (resource_size(res2) =3D 4)) {
> > +		/* assume both CMSTR and CMCSR to be 32-bit */
> > +		p->read_control =3D sh_cmt_read32;
> > +		p->write_control =3D sh_cmt_write32;
> > +	} else {
> > +		p->read_control =3D sh_cmt_read16;
> > +		p->write_control =3D sh_cmt_write16;
> > +	}
> > =20
> >  	if (resource_size(res) =3D 6) {
> >  		p->width =3D 16;
> > @@ -752,22 +773,23 @@ static int sh_cmt_setup(struct sh_cmt_priv *p, st=
ruct platform_device *pdev)
> >  			      cfg->clocksource_rating);
> >  	if (ret) {
> >  		dev_err(&p->pdev->dev, "registration failed\n");
> > -		goto err2;
> > +		goto err3;
> >  	}
> >  	p->cs_enabled =3D false;
> > =20
> >  	ret =3D setup_irq(irq, &p->irqaction);
> >  	if (ret) {
> >  		dev_err(&p->pdev->dev, "failed to request irq %d\n", irq);
> > -		goto err2;
> > +		goto err3;
> >  	}
> > =20
> >  	platform_set_drvdata(pdev, p);
> > =20
> >  	return 0;
> > -err2:
> > +err3:
> >  	clk_put(p->clk);
> > -
> > +err2:
> > +	iounmap(p->mapbase_str);
> >  err1:
> >  	iounmap(p->mapbase);
> >  err0:
> >=20
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

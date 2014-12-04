From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Thu, 04 Dec 2014 17:21:13 +0000
Subject: Re: [PATCH v2 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
Message-Id: <81806c6b34a940c7a0378ed77c49b495@BN1AFFO11FD048.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
 <1417611812.30615.28.camel@mm-sol.com>
 <d3d1b263bf6242aa9a1a0876be455cce@BN1BFFO11FD021.protection.gbl>
 <1417685458.22963.1.camel@mm-sol.com>
In-Reply-To: <1417685458.22963.1.camel@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, 2014-12-04 at 11:30AM +0200, Ivan T. Ivanov wrote:
>=20
> On Wed, 2014-12-03 at 09:38 -0800, S=C3=B6ren Brinkmann wrote:
> > On Wed, 2014-12-03 at 03:03PM +0200, Ivan T. Ivanov wrote:
> > > On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> > > > Instead of the driver caring about implementation details like devi=
ce
> > > > tree, just provide information about driver specific pinconf parame=
ters
> > > > to pinconf-generic which takes care of parsing the DT.
> > > >=20
> > > > Signed-off-by: Soren Brinkmann brinkmann@xilinx.com>
> > > > ---
> > > > This is compile tested only. So, it's likely that it needs more twe=
aking
> > > > to make it actually work on HW. But it illustrates the potential
> > > > benefits of the pinconf-generic changes in this series.
> > > > ---
> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 125 +++----------------=
------------
> > > >  1 file changed, 11 insertions(+), 114 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pin=
ctrl/qcom/pinctrl-spmi-
> > > > gpio.c
> > > > index b863b5080890..2db85e53ef73 100644
> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > @@ -131,14 +131,14 @@ struct pmic_gpio_state {
> > > >         struct gpio_chip chip;
> > > >  };
> > > >=20
> > > > -struct pmic_gpio_bindings {
> > > > -       const char*property;
> > > > -       unsigned      param;
> > > > +static const struct pinconf_generic_dt_params pmic_gpio_bindings[]=
 =3D {
> > > > +       {"qcom,pull-up-strength",PMIC_GPIO_CONF_PULL_UP,0},
> > > > +       {"qcom,drive-strength",PMIC_GPIO_CONF_STRENGTH,0},
> > > >  };
> > > >=20
> > > > -static struct pmic_gpio_bindings pmic_gpio_bindings[] =3D {
> > > > -       {"qcom,pull-up-strength",PMIC_GPIO_CONF_PULL_UP},
> > > > -       {"qcom,drive-strength",PMIC_GPIO_CONF_STRENGTH},
> > > > +static const struct pin_config_item pmic_conf_items[] =3D {
> > > > +       PCONFDUMP(PMIC_GPIO_CONF_PULL_UP,  "pull-up-strength", NULL=
, true),
> > >=20
> > > s/pull-up-strength/qcom,pull-up-strength/
> >=20
> > This is used for the debugfs output. I don't think you want the qcom
> > prefix here, do you?
>=20
> Then at lest lets make it "pull up strength".

Ok. Will change it.

>=20
> >=20
> > > > +       PCONFDUMP(PMIC_GPIO_CONF_STRENGTH, "drive-strength", NULL, =
true),
> > > >  };
> > > >=20
> > >=20
> > >=20
> > >=20
> > > I am not happy that we have to define the same think two times.
> >=20
> > It's not really the same thing. One is the actual DT binding the other
> > how the property is displayed in debugfs. Two different things. It's how
> > the core does it. That's not new.
>=20
> This didn't make me more happy :-). Could both be merged?

That's definitely beyond the scope of this series.

	Soren

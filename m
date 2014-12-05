From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 05 Dec 2014 17:08:21 +0000
Subject: Re: [PATCH v2 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
Message-Id: <bc08b9044a3f46f5a575dca2fa18a663@BY2FFO11FD057.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
 <1417766393.22963.9.camel@mm-sol.com>
In-Reply-To: <1417766393.22963.9.camel@mm-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, 2014-12-05 at 09:59AM +0200, Ivan T. Ivanov wrote:
>=20
> On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> >=20
> >  static const struct pinconf_ops pmic_gpio_pinconf_ops =3D {
> > +       .is_generic=3D true,
> >         .pin_config_group_get=3D pmic_gpio_config_get,
> >         .pin_config_group_set=3D pmic_gpio_config_set,
> >         .pin_config_group_dbg_show=3D pmic_gpio_config_dbg_show,
> > @@ -848,6 +742,9 @@ static int pmic_gpio_probe(struct platform_device *=
pdev)
> >         pctrldesc->name =3D dev_name(dev);
> >         pctrldesc->pins =3D pindesc;
> >         pctrldesc->npins =3D npins;
> > +       pctrldesc->num_dt_params =3D ARRAY_SIZE(pmic_gpio_bindings);
> > +       pctrldesc->params =3D pmic_gpio_bindings;
> > +       pctrldesc->conf_items =3D pmic_conf_items;
> >=20
>=20
> What will happen if number of conf_items is less than number of params?

I suppose bad things :) You're right, that should probably be checked
somewhere. Let me see whether I find a good place to put such a check.

	Thanks,
	S=C3=B6ren

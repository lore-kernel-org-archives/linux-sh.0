From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Date: Wed, 19 Nov 2014 07:49:39 +0000
Subject: Re: [PATCH 3/7] pinctrl: pinconf-generic: Allow driver to specify DT params
Message-Id: <1416383379.30131.14.camel@mm-sol.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-4-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdYfj2ydLQ4q_FKwXo73jzNsvj9u2Aem9EiuEw-OCvurrg@mail.gmail.com>
 <1416300621.30131.6.camel@mm-sol.com>
 <995406b8e0244c63a3ef8e58314e81f6@BL2FFO11FD037.protection.gbl>
In-Reply-To: <995406b8e0244c63a3ef8e58314e81f6@BL2FFO11FD037.protection.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org


On Tue, 2014-11-18 at 09:25 -0800, S=C3=B6ren Brinkmann wrote:
> On Tue, 2014-11-18 at 10:50AM +0200, Ivan T. Ivanov wrote:
> >=20
> > On Tue, 2014-11-11 at 15:53 +0100, Linus Walleij wrote:
> > > On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
> > > brinkmann@xilinx.com> wrote:
> > >=20
> > > > Additionally to the generic DT parameters, allow drivers to=20
> > > > provide driver-specific DT parameters to be used with the=20
> > > > generic parser infrastructure.
> > > >=20
> > > > Signed-off-by: Soren Brinkmann brinkmann@xilinx.com>
> > >=20
> > > I like the looks of this, but the patch description is a bit=20
> > > terse. I'd like it to describe some of the refactorings being=20
> > > done
> > > to the intrinsics, because I have a hard time following the=20
> > > patch.
> > >=20
> > > First please rebase onto the "devel" branch in the pin control=20
> > > tree, and notice that drivers/pinctrl/qcom/pinctrl-spmi-gpio.c=20
> > > which is merged there is actually doing this already:
> > >=20
> > >=20
> > >         for_each_child_of_node(np_config, np) {
> > >                 ret =3D pinconf_generic_dt_subnode_to_map(pctldev,=20
> > > np, map,
> > >                                                         &reserv,=20
> > > nmaps, type);
> > >                 if (ret)
> > >                         break;
> > >=20
> > >                 ret =3D pmic_gpio_dt_subnode_to_map(pctldev, np,=20
> > > map, &reserv,
> > >                                                   nmaps, type);
> > >                 if (ret)
> > >                         break;
> > >         }
> > >=20
> > > So it should be patched to illustrate the point of this code.
> > >=20
> >=20
> > I like the idea, but have issues with implementations :-).
> > =20
> > It is supposed that additional parameters are not generic,
> > otherwise they will be part of enum pin_config_param, right?
> >=20
> > Probably it will be better if clients could pass array with
> > driver specific dt bindings to pinconf_generic_dt_node_to_map()?
>=20
> My idea was to hide that API from the driver. You just pass those=20
> parameters as part of the struct pctldev and the parser - whether=20
> this generic one or anything else - would do the right thing. I=20
> don't think calling the parser from the driver is the right approach.

Drivers already know about dt_node_to_map(). My proposal will make
drivers, which register non-standard bindings, little bit simpler.

With your approach probably we can remove dt_node_to_map() and
dt_free_map() callbacks?

Regards,
Ivan



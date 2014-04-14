From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Apr 2014 07:13:13 +0000
Subject: Re: [PATCH v2 1/5] pinctrl: pfc: r8a7790: add i2c0 muxing
Message-Id: <20140414071311.GA2993@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
List-Id: <linux-sh.vger.kernel.org>
References: <1395773789-17249-1-git-send-email-wsa@the-dreams.de>
 <1395773789-17249-2-git-send-email-wsa@the-dreams.de>
 <3524931.MdjU7RgFNq@avalon>
In-Reply-To: <3524931.MdjU7RgFNq@avalon>
To: linux-arm-kernel@lists.infradead.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2014 at 03:00:39PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Tuesday 25 March 2014 19:56:25 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >=20
> > Add the muxing for the last missing i2c rcar core. Fix the sorting for
> > SH_PFC_PIN_NAMED while we are here.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Forgot to add LinusW to CC. Linus, shall I resend?

>=20
> > ---
> > Change since V1:
> >=20
> > * sorted SH_PFC_PIN_NAMED pins
> >=20
> >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index c381ae63c508..bcb47d138b02
> > 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > @@ -782,6 +782,7 @@ enum {
> >  	USB1_PWEN_MARK, AUDIO_CLKOUT_D_MARK, USB1_OVC_MARK,
> >  	TCLK1_B_MARK,
> >=20
> > +	I2C0_SCL_MARK, I2C0_SDA_MARK,
> >  	I2C3_SCL_MARK, I2C3_SDA_MARK,
> >  	PINMUX_MARK_END,
> >  };
> > @@ -1722,6 +1723,9 @@ static const u16 pinmux_data[] =3D {
> >  	PINMUX_IPSR_DATA(IP16_7, USB1_OVC),
> >  	PINMUX_IPSR_MODSEL_DATA(IP16_7, TCLK1_B, SEL_TMU1_1),
> >=20
> > +	PINMUX_DATA(I2C0_SCL_MARK, FN_SEL_IIC0_1),
> > +	PINMUX_DATA(I2C0_SDA_MARK, FN_SEL_IIC0_1),
> > +
> >  	PINMUX_DATA(I2C3_SCL_MARK, FN_SEL_IICDVFS_1),
> >  	PINMUX_DATA(I2C3_SDA_MARK, FN_SEL_IICDVFS_1),
> >  };
> > @@ -1735,8 +1739,10 @@ static const struct sh_pfc_pin pinmux_pins[] =3D=
 {
> >  	PINMUX_GPIO_GP_ALL(),
> >=20
> >  	/* Pins not associated with a GPIO port */
> > -	SH_PFC_PIN_NAMED(ROW_GROUP_A('J'), 15, AJ15),
> > +	SH_PFC_PIN_NAMED(ROW_GROUP_A('F'), 15, AF15),
> > +	SH_PFC_PIN_NAMED(ROW_GROUP_A('G'), 15, AG15),
> >  	SH_PFC_PIN_NAMED(ROW_GROUP_A('H'), 15, AH15),
> > +	SH_PFC_PIN_NAMED(ROW_GROUP_A('J'), 15, AJ15),
> >  };
> >=20
> >  /* - AUDIO CLOCK
> > ------------------------------------------------------------ */ @@ -205=
4,6
> > +2060,14 @@ static const unsigned int hscif1_ctrl_b_pins[] =3D { static=
 const
> > unsigned int hscif1_ctrl_b_mux[] =3D {
> >  	HRTS1_N_B_MARK, HCTS1_N_B_MARK,
> >  };
> > +/* - I2C0
> > ------------------------------------------------------------------- */
> > +static const unsigned int i2c0_pins[] =3D {
> > +	/* SCL, SDA */
> > +	PIN_A_NUMBER('G', 15), PIN_A_NUMBER('F', 15),
> > +};
> > +static const unsigned int i2c0_mux[] =3D {
> > +	I2C0_SCL_MARK, I2C0_SDA_MARK,
> > +};
> >  /* - I2C1
> > ------------------------------------------------------------------- */
> > static const unsigned int i2c1_pins[] =3D {
> >  	/* SCL, SDA */
> > @@ -3626,6 +3640,7 @@ static const struct sh_pfc_pin_group pinmux_group=
s[] =3D
> > { SH_PFC_PIN_GROUP(hscif1_data_b),
> >  	SH_PFC_PIN_GROUP(hscif1_clk_b),
> >  	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
> > +	SH_PFC_PIN_GROUP(i2c0),
> >  	SH_PFC_PIN_GROUP(i2c1),
> >  	SH_PFC_PIN_GROUP(i2c1_b),
> >  	SH_PFC_PIN_GROUP(i2c1_c),
> > @@ -3895,6 +3910,10 @@ static const char * const hscif1_groups[] =3D {
> >  	"hscif1_ctrl_b",
> >  };
> >=20
> > +static const char * const i2c0_groups[] =3D {
> > +	"i2c0",
> > +};
> > +
> >  static const char * const i2c1_groups[] =3D {
> >  	"i2c1",
> >  	"i2c1_b",
> > @@ -4203,6 +4222,7 @@ static const struct sh_pfc_function pinmux_functi=
ons[]
> > =3D { SH_PFC_FUNCTION(eth),
> >  	SH_PFC_FUNCTION(hscif0),
> >  	SH_PFC_FUNCTION(hscif1),
> > +	SH_PFC_FUNCTION(i2c0),
> >  	SH_PFC_FUNCTION(i2c1),
> >  	SH_PFC_FUNCTION(i2c2),
> >  	SH_PFC_FUNCTION(i2c3),
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTS4qHAAoJEBQN5MwUoCm2in0P/3dfJLfSdwgMo/F2zaTFsCJk
rqUkExiaOCpg1FK6fglnmCPXJP1dKPgPQnqLqL4kiGtsb22ipYDybdPJeKbNQ3SW
G88pXu6GQMC5N9ZIOx4wHnLZEJVQJ0/dVOx08yXdoR9dTWfLS7EOtHnklj3jW6+c
Wueu2eKM6UDm93CDn5K9ul/K1MtRceRcaDUaavpN1WsT7ZRx8tn3pVcPvnL9hj1q
bXOPx1+ZB14Q8iTJdf0/oUO5FfYkloM0apfr8EcUdLxZ6SR+LIyLBHgMc4jo5Ou/
OrhUWU5jQwp4slh9v1SBuBBWcziUKeQQRmbLdkERbrtgoBwawQHetjeczBcmU31c
7A15aW6aQVD5rdn9a0qBGFdU4lP1ECJgIY0xyp9JE4PAyzEYLSGqcBOHDeoRlkeW
Pdy8IutmJINhYzBYWmFMBhjOn/epphcx1FkwMrTGKXwCMwDbl77mawUT8QvIApXA
jpSOKk5VL3hbr18IR78Fk1V0pH5s0DtFxVQHJjMC7Ug130Vxmf/DZibAkeXjw3+A
pzyd4e587Z3Zbf7F8JMrvtJtOY6avE39OX025F44XesU4XfH+CoRUknnD+6nL2ri
K1Gu8jBSKOCHK0POwxQ6yPEuDR7EXsdbrc+bGXOnhP4AuXbHYFL51yD0sihy3rNz
onzAKgZXSFv4KPQWdMRW
=j8fn
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Apr 2014 07:14:42 +0000
Subject: Re: [PATCH v2 2/5] pinctrl: pfc: r8a7790: add mux data for IIC(B) cores
Message-Id: <20140414071440.GB2993@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
List-Id: <linux-sh.vger.kernel.org>
References: <1395773789-17249-1-git-send-email-wsa@the-dreams.de>
 <1395773789-17249-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1395773789-17249-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 07:56:26PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Forgot to add LinusW to CC. Linus, shall I resend?

> ---
> Change since V1:
>=20
> * renamed i2c4-7 to iic0-3
>=20
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 118 +++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pf=
c/pfc-r8a7790.c
> index bcb47d138b02..99b62b1ee752 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -782,8 +782,8 @@ enum {
>  	USB1_PWEN_MARK, AUDIO_CLKOUT_D_MARK, USB1_OVC_MARK,
>  	TCLK1_B_MARK,
> =20
> -	I2C0_SCL_MARK, I2C0_SDA_MARK,
> -	I2C3_SCL_MARK, I2C3_SDA_MARK,
> +	IIC0_SCL_MARK, IIC0_SDA_MARK, I2C0_SCL_MARK, I2C0_SDA_MARK,
> +	IIC3_SCL_MARK, IIC3_SDA_MARK, I2C3_SCL_MARK, I2C3_SDA_MARK,
>  	PINMUX_MARK_END,
>  };
> =20
> @@ -1723,9 +1723,13 @@ static const u16 pinmux_data[] =3D {
>  	PINMUX_IPSR_DATA(IP16_7, USB1_OVC),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_7, TCLK1_B, SEL_TMU1_1),
> =20
> +	PINMUX_DATA(IIC0_SCL_MARK, FN_SEL_IIC0_0),
> +	PINMUX_DATA(IIC0_SDA_MARK, FN_SEL_IIC0_0),
>  	PINMUX_DATA(I2C0_SCL_MARK, FN_SEL_IIC0_1),
>  	PINMUX_DATA(I2C0_SDA_MARK, FN_SEL_IIC0_1),
> =20
> +	PINMUX_DATA(IIC3_SCL_MARK, FN_SEL_IICDVFS_0),
> +	PINMUX_DATA(IIC3_SDA_MARK, FN_SEL_IICDVFS_0),
>  	PINMUX_DATA(I2C3_SCL_MARK, FN_SEL_IICDVFS_1),
>  	PINMUX_DATA(I2C3_SDA_MARK, FN_SEL_IICDVFS_1),
>  };
> @@ -2134,6 +2138,80 @@ static const unsigned int i2c3_pins[] =3D {
>  static const unsigned int i2c3_mux[] =3D {
>  	I2C3_SCL_MARK, I2C3_SDA_MARK,
>  };
> +/* - IIC0 (I2C4) -------------------------------------------------------=
----- */
> +static const unsigned int iic0_pins[] =3D {
> +	/* SCL, SDA */
> +	PIN_A_NUMBER('G', 15), PIN_A_NUMBER('F', 15),
> +};
> +static const unsigned int iic0_mux[] =3D {
> +	IIC0_SCL_MARK, IIC0_SDA_MARK,
> +};
> +/* - IIC1 (I2C5) -------------------------------------------------------=
----- */
> +static const unsigned int iic1_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(1, 16), RCAR_GP_PIN(1, 17),
> +};
> +static const unsigned int iic1_mux[] =3D {
> +	IIC1_SCL_MARK, IIC1_SDA_MARK,
> +};
> +static const unsigned int iic1_b_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
> +};
> +static const unsigned int iic1_b_mux[] =3D {
> +	IIC1_SCL_B_MARK, IIC1_SDA_B_MARK,
> +};
> +static const unsigned int iic1_c_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(4, 30), RCAR_GP_PIN(4, 27),
> +};
> +static const unsigned int iic1_c_mux[] =3D {
> +	IIC1_SCL_C_MARK, IIC1_SDA_C_MARK,
> +};
> +/* - IIC2 (I2C6) -------------------------------------------------------=
----- */
> +static const unsigned int iic2_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
> +};
> +static const unsigned int iic2_mux[] =3D {
> +	IIC2_SCL_MARK, IIC2_SDA_MARK,
> +};
> +static const unsigned int iic2_b_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1),
> +};
> +static const unsigned int iic2_b_mux[] =3D {
> +	IIC2_SCL_B_MARK, IIC2_SDA_B_MARK,
> +};
> +static const unsigned int iic2_c_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
> +};
> +static const unsigned int iic2_c_mux[] =3D {
> +	IIC2_SCL_C_MARK, IIC2_SDA_C_MARK,
> +};
> +static const unsigned int iic2_d_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
> +};
> +static const unsigned int iic2_d_mux[] =3D {
> +	IIC2_SCL_D_MARK, IIC2_SDA_D_MARK,
> +};
> +static const unsigned int iic2_e_pins[] =3D {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(2, 18), RCAR_GP_PIN(2, 19),
> +};
> +static const unsigned int iic2_e_mux[] =3D {
> +	IIC2_SCL_E_MARK, IIC2_SDA_E_MARK,
> +};
> +/* - IIC3 (I2C7) -------------------------------------------------------=
----- */
> +static const unsigned int iic3_pins[] =3D {
> +/* SCL, SDA */
> +	PIN_A_NUMBER('J', 15), PIN_A_NUMBER('H', 15),
> +};
> +static const unsigned int iic3_mux[] =3D {
> +	IIC3_SCL_MARK, IIC3_SDA_MARK,
> +};
>  /* - INTC --------------------------------------------------------------=
----- */
>  static const unsigned int intc_irq0_pins[] =3D {
>  	/* IRQ */
> @@ -3650,6 +3728,16 @@ static const struct sh_pfc_pin_group pinmux_groups=
[] =3D {
>  	SH_PFC_PIN_GROUP(i2c2_d),
>  	SH_PFC_PIN_GROUP(i2c2_e),
>  	SH_PFC_PIN_GROUP(i2c3),
> +	SH_PFC_PIN_GROUP(iic0),
> +	SH_PFC_PIN_GROUP(iic1),
> +	SH_PFC_PIN_GROUP(iic1_b),
> +	SH_PFC_PIN_GROUP(iic1_c),
> +	SH_PFC_PIN_GROUP(iic2),
> +	SH_PFC_PIN_GROUP(iic2_b),
> +	SH_PFC_PIN_GROUP(iic2_c),
> +	SH_PFC_PIN_GROUP(iic2_d),
> +	SH_PFC_PIN_GROUP(iic2_e),
> +	SH_PFC_PIN_GROUP(iic3),
>  	SH_PFC_PIN_GROUP(intc_irq0),
>  	SH_PFC_PIN_GROUP(intc_irq1),
>  	SH_PFC_PIN_GROUP(intc_irq2),
> @@ -3932,6 +4020,28 @@ static const char * const i2c3_groups[] =3D {
>  	"i2c3",
>  };
> =20
> +static const char * const iic0_groups[] =3D {
> +	"iic0",
> +};
> +
> +static const char * const iic1_groups[] =3D {
> +	"iic1",
> +	"iic1_b",
> +	"iic1_c",
> +};
> +
> +static const char * const iic2_groups[] =3D {
> +	"iic2",
> +	"iic2_b",
> +	"iic2_c",
> +	"iic2_d",
> +	"iic2_e",
> +};
> +
> +static const char * const iic3_groups[] =3D {
> +	"iic3",
> +};
> +
>  static const char * const intc_groups[] =3D {
>  	"intc_irq0",
>  	"intc_irq1",
> @@ -4226,6 +4336,10 @@ static const struct sh_pfc_function pinmux_functio=
ns[] =3D {
>  	SH_PFC_FUNCTION(i2c1),
>  	SH_PFC_FUNCTION(i2c2),
>  	SH_PFC_FUNCTION(i2c3),
> +	SH_PFC_FUNCTION(iic0),
> +	SH_PFC_FUNCTION(iic1),
> +	SH_PFC_FUNCTION(iic2),
> +	SH_PFC_FUNCTION(iic3),
>  	SH_PFC_FUNCTION(intc),
>  	SH_PFC_FUNCTION(mmc0),
>  	SH_PFC_FUNCTION(mmc1),
> --=20
> 1.9.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTS4rgAAoJEBQN5MwUoCm24d8P/2MEwIR1lhX7OzrZxfe+P6B2
1w9X85cEoKJrPNY7iNo8Kn+nEB5492r2cifGYWRHAaB5pPsLVIqxHRDvosXq3/CS
Du9CIejs2kfz7+vZRa7xjpcYA9EsdqenPPU1pwBTWbXboaxP3GzqUd+G7r7Zi2Vk
t3bomBmE88vGGGJbsDnY/YFzW3Ranw+SYalI4sN06zypcBLYbEkY2m5Sbgs2vG6u
iv2xV7IuiwNEvpjaY6NaA6PSprBC617wlX3wroYn0e+ymq0r/DXovIbhmda4WzUL
jR9Ips62IM4oD8HYXl1SDYiuOnMg5PFCvodGLzlJ+2brlppUPRSazivmSf1MAbx7
vbDe9USDf615WHSYnyPtqP2vge570M3LSg7FicjbdrAk2naTiThqMc2+4ZzLbVM1
VBqw/2Ie/F7RroJxpb1kNeBHDGPGhYjN1xGwKHlHGkKpdpIWSqqYBj+3WxRUcpcS
mCLjKlqMYPrGKYm0edRMssXorDzpNR2s5Hup9cu/sSXoIbCZB0VliGItLKroVuo+
f8JdUr9ynfIT1U6ia0bj16OwFzROe6atCR/sdkAzKxrU3kwwrQiAg+0BKR8hN16I
aEGnbVk67zwdAgylgMhR7a8WRCTnuyqHMm8NmnuHMJjgWz7XOap14OrIKWracxtg
IEzvFm8ozqhUu1KDPXD7
=4gym
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 09:15:11 +0000
Subject: Re: [RFC 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <20150202091511.GA1058@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 10:05:37AM +0100, Geert Uytterhoeven wrote:
> On Sun, Feb 1, 2015 at 3:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -123,6 +123,13 @@
> >                 interrupts =3D <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_=
LEVEL_HIGH)>;
> >         };
> >
> > +       wdt0: wdt@e6020000 {
> > +               compatible =3D "renesas,rwdt-r8a7790", "renesas,rwdt-rc=
ar";
> > +               reg =3D <0 0xe6020000 0 0x0c>;
>=20
> The RWDT hardware block also has an interrupt:
>=20
>         interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;

Well, it is not used in the driver. I'd suggest to skip until it is
really needed.


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz0AfAAoJEBQN5MwUoCm2Xr8P/R9cJaFmUct4ozE8VqhVXVPk
8X04p1ZSmy2HiTK66tZ/ak8eAp1GfF4Y5A/+tzKyuxDIYvnPgn4MuwGdP/Cak8/R
g9Ng46Wl7ayFzweqPsHdGvtzhyv+aQk4nfLlP0pPgpiX8J/hGAoE3uXIe4CV21G9
K1hhXwyqmQKbgvHGFgkLbsZ9K8QIYjajhcHVlgOufC4g+cTAiYM7YwRrPGdC2lbV
wicXbsFxeHq85ix/zVIirPa3eU76Pvm9fAXgMHKQEoNzdfwIXIvWBuoEXB3PeULU
bo5l03DR8z90qRl8csG1bVUMkQkm+idHiTvGr+YBdLRzJl5EevGd6QwFeAT0MqG+
2yX4jjQ2a+ite4xNKYFfjzLJUCavQuolFzPb9SYfaZOsd2GcaiDnAt7G2Lj5og6t
FLcPuquYjvW30FhbRL7Rd0+A4bChFR1Gp/wFy/SNce8hQSJ+aiVahHfUkXg/JXUd
GzfK+SBCDE3FTINGXaQGY3FuqamI1kYcKhQ8xiWJFFWACZwoiO53ag4NJEmctDYS
WkNCQBaDHNQOY6n0EoYJcUEaqdDsQ2uhD61k5xH6V9vm98j++jgpieXjyPGneYSj
ccZB+yAIaqz26ltsXekm+zdMb6ODretbmZLKqKUskedg//uIgw4mWPuSdyD6MGg2
1tmmCx2+G20aMvuxp3To
=47GX
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

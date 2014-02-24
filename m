From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 24 Feb 2014 10:34:19 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7791: add IIC(B) cores to dtsi
Message-Id: <20140224103419.GB4445@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mojUlQ0s9EVzWg2t"
List-Id: <linux-sh.vger.kernel.org>
References: <1393159224-14377-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1393159224-14377-3-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	i2c6: i2c@e60b0000 {
> > +		/* doesn't need pinmux */
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		compatible =3D "renesas,i2cB-r8a7791", "renesas,rmobile-iic";
>=20
> Wouldn't "renesas,iic-r8a7791" be more appropriate ? It would be closer t=
o=20
> "renesas,rmobile-iic".

Yes, that is better probably. Still a bit confusing, yet better.


--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTCyArAAoJEBQN5MwUoCm2K4oP/0zPzz/Wfh9qILFdW0oNEBS3
gNEt1QQ41yE49+BH2mUAUfZ95AE4gigAuazgTllD0uaqfaj+Z4rgKNYKkibIR6u2
C7ohWFgHr14X/bD+Y1ChQIKJW03f/tpvmLmQAyRMMX57mXWkd61k5kJjBhwYHi35
s2FXrPY+7fwF8RuJ4XTBQd+WTNgOR8QY0SrHQ8XBbtHNkeFVaUwQbZOvqciIctOG
fho2eXhZQuyyX2tr59jz7h93k6v0IFN1UKFCKRa4ljeT7qDsBQ9+fP+mch5LoN8L
6t7e95386C5/rh6vdjJ0iWSr0rz5ReD4peZAEjnNq8aq8MdO7R2al1DGRrhguxuG
ewU0RnC/7MaLCfxE7rYc69IZNLw1B70QOrxhI59I9js8VYkkdNMpoVKN+8HjsiCL
7MnRLldWz2Kgz6hFvd06HVzmHCGN7chW2awtg++OZmDUz835gzFl6UKyh8ZbHbip
FrgLBlzBUzC/FT1p05z58SvKjlG5mtt8FyygVpH3WhUTpp8L0BVMely+9qOaAoyc
HNeXsk9TRXeshjWpkFRFC7jabzb0R6vY/E6penPfnLGZ5oCr9xJNsOV+rS7vh1H/
1ChAnWq6yLiAvPg3DciFvU8JxSEhXjv5gy4jOPyAp+1uf12LD1cGFJk4BVu+u4m2
YgP0NFiFz25XXrlr9D60
=t75g
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

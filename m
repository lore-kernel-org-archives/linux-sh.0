From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 13 Jan 2016 13:02:28 +0000
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <20160113130227.GG1540@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WkfBGePaEyrk4zXB"
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
 <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
 <1452185798.2915.44.camel@pengutronix.de>
In-Reply-To: <1452185798.2915.44.camel@pengutronix.de>
To: Jan =?utf-8?B?TMO8YmJl?= <jlu@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> > +Required properties:
> > +- compatible: "i2c-demux-pinctrl"
> > +- i2c-parent: List of phandles of I2C masters available for selection.=
 The first
> > +	      one will be used as default.
> > +- i2c-bus-name: The name of this bus. Also needed as pinctrl-name for =
the I2C
> > +		parents.
> [...]
> > +	i2chdmi: i2c@8 {
> > +		compatible =3D "i2c-demux-pinctrl";
> > +		i2c-parent =3D <&gpioi2c>, <&iic2>, <&i2c2>;
> > +		i2c-bus-name =3D "i2c-hdmi";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> [...]
> > +	gpioi2c: i2c@9 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		compatible =3D "i2c-gpio";
> [...]
> > +&i2c2	{
> > +	pinctrl-0 =3D <&i2c2_pins>;
> > +	pinctrl-names =3D "i2c-hdmi";
> > +
> > +	clock-frequency =3D <100000>;
> > +};
> [...]
> > +&iic2	{
> > +	pinctrl-0 =3D <&iic2_pins>;
> > +	pinctrl-names =3D "i2c-hdmi";
> > +
> > +	clock-frequency =3D <100000>;
> > +};
> [...]
>=20
> It seems that the demux-pinctrl driver reconfigures the pinctrl settings
> for the parent devices. I would have expected to have alternative
> pinctrl state on the demux node support switching the same external pins
> between the different controllers. Wouldn't it be possible to have
> pinctrl conflicts between &i2c2_pins and &iic2_pins otherwise?

I don't think so. Before i2c2 is enabled, iic2 gets disabled (status =3D
"disabled" via OF_DYNAMIC) and thus the pins get free. Doing it this
way, you could even have something like this:

	pinctrl-0 =3D <&iic2_pins>, <&iic2_c_pins>;
	pinctrl-names =3D "i2c-hdmi", "i2c-sensors";

which allows you to demux this controller to this or that bus. I haven't
tested this, though.

   Wolfram


--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWlkrjAAoJEBQN5MwUoCm2X/kP/jSsfBpuaKdOC/o5BJDqD5S4
yIMmK5h6B3RektVBK9N4h4IsQ+Fn/CpoRsZzmS/Pz6FwzuKuK1SDzMXDdzHmkrqX
Zvok6pVinyPg5c88Rl8etZw19OjPBLYkxL3YjEhX/tI2+yLJKPRkQHMQiw2a1Jih
ki34btRsifN2khpwu/p6B6iykGkDak+L82uqFYOwiTYgbQb2aWtThKDXVFzuNaSv
oor9/2WWT06UYvGe2jfK0njHKF2UnbP6lJ7dcOHgkviiW+eYzdEXB8jTYvBKhkQp
O12aVPCuiSRw1yLPMW5MRoSzVBmpFqqkQm8W7yDMiFwMJ2McXNjzHWWc7Hq1v07B
o988kafEexfLP3haphH3ViE4pebzqMF9pcPl1i95K0I/tq/iNLpeF8OH0Nlwtxxz
/3oZrowOwEgUfjv0usafZlxADFGiyKImbLF/+OddBhUIohxcq4770d8mji8n8v8q
/xVVq3qcfsYwxxnACaaar2L8wY+1a9XKiR5srzzwHU+sYu++HwDKH37r/WCNDIe4
od21vAW98UiyFCRh0sehv6F5tmgv4o5p84s57IzNoGijwoLQUaLf6gVNn52saAkR
ZmbwbLwmMUAD1EQZ93iGtNHEtRHCpS3rnsvIw7S+itFxy/daite6PFPBFZuEjwnc
yWkj39pR/JSltLHeOWw7
=P3xr
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--

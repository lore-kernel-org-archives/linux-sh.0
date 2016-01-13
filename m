From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 13 Jan 2016 12:52:27 +0000
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <20160113125227.GD1540@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="k4f25fnPtRuIRUb3"
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
 <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdUdxk6yjYAr3i7sjdMa-WJxrbOhsEz3JidY9aZVhaoURw@mail.gmail.com>
In-Reply-To: <CAMuHMdUdxk6yjYAr3i7sjdMa-WJxrbOhsEz3JidY9aZVhaoURw@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2016 at 03:30:39PM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Wed, Jan 6, 2016 at 2:51 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > These bindings allow an I2C bus to switch between multiple masters. This
> > is not hot-swichting because connected I2C slaves will be
> > re-instantiated. It is meant to select the best I2C core at runtime once
> > the task is known. Example: Prefer i2c-gpio over another I2C core
> > because of HW errata affetcing your use case.
>=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
> > @@ -0,0 +1,155 @@
>=20
> > +Here is a snipplet for a bus to be demuxed. It contains various i2c cl=
ients for
>=20
> snippet
>=20
> > +HDMI, so the bus is named "i2c-hdmi":
> > +
> > +       i2chdmi: i2c@8 {
>=20
> Would it make sense to call the node "i2c-bus@8"?

That sounds like a question for our EPapr expert Sergei (CCed) :)

> > +
> > +               compatible =3D "i2c-demux-pinctrl";
> > +               i2c-parent =3D <&gpioi2c>, <&iic2>, <&i2c2>;
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWlkiKAAoJEBQN5MwUoCm2QFwP/iVzEihmrsB535lLhpSJDpUX
HsPFGkVYGrwwLEWnNh6das/1/E6p21FvxL1SJdTqvw2+PGvQBrxUeZ2cYgQuchlq
Y2TvnL/df6kqHanaFVjwopx6as+i+4iodWDfqzYR4uVeTLFzuuRrIgs9fcdIu6DL
j6MuDyNViyykPGtvlNEWfOLvD3+VRBPmSu0oBOmDxXfjIrQVl7vPgWaRTZA71WK+
neTGNgP4JCFPL68towtD8SwsyzWDjDUREuBlSeM+mx0bne0qIKRINxk1NIi1KnxL
njdYiNajMajg0OZpmGTAmXQ/ODdgABWKbdlkUePbsMkpXyQWCKdNyW/DfCYpfZ+X
Z2YBMABrU79Kyp6wmpeKFK8gRx8wZ2SfrK66N9WRC25kPpxobXvNh8vJdBqvwXuD
Z07NGAZnSNysJppWUJ3wkcAduDCStUvSJXgLIzSqqp1j79eU0pfZs1Ffbkbn5krA
DuBaq8HTjJyWb/gZj0kbKSIIL8b4Ow/ZRhYmpIB7vUJCTk4ZqEuMV9J1af766A69
HiLQEV0abiXpiQV3zW1wfykleoQWrX5YX0Xo+OIZhSXlWihxBl0EUZtIes9g3+vV
XnmUTzW9s42S4gdrWBt+UmWls87aGAiblokELFLErQxQwYrx55y8aHvLqq39R0r+
5ZusL+Tfj83SH8V8iveK
=0WWz
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

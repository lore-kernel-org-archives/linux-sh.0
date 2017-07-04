From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 04 Jul 2017 14:07:06 +0000
Subject: Re: [PATCH 5/6] i2c: pca-platform: use device_property_read_u32
Message-Id: <20170704140706.p3yvxzc6722jeexs@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rcnbahvgpyccu534"
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc+6WGFiJifEExjv3jSFsy+ORGtRoDPmv31sSFN=zkHMg@mail.gmail.com>
 <20170630090354.6s6ahpjhis7ptbfg@ninjato>
 <CAHp75Ve1daNFe4PLAMpqMudE9d+Ss2JpeZ=Sy5x5ij99gAVs_w@mail.gmail.com>
 <942893991cc34410bf1515a6a970c5c2@svr-chch-ex1.atlnz.lc>
In-Reply-To: <942893991cc34410bf1515a6a970c5c2@svr-chch-ex1.atlnz.lc>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--rcnbahvgpyccu534
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> Frankly, I am not a big fan of converting board files if we cannot test
> >> the changes.
> >=20
> > So, if no one is using that old boards, should we really take care
> > more than just compile test?
> >=20
> > P.S. Legacy platform data makes a burden of development nowadays.
> > Built-in device properties API (as a part of Unified Device
> > Properties) is exactly for getting rid of legacy stuff and make things
> > much cleaner.
>=20
> We could probably go with an approach of making the device properties=20
> the default which would suit the new style and leave the platform_data=20
> to override things if it is present.
>=20
> If/when the older platforms go away we can drop struct=20
> i2c_pca9564_pf_platform_data.

I don't have a super strong opinion, so we can discuss this for 4.14.
For 4.13, I picked the two easy patches already. Thanks!


--rcnbahvgpyccu534
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllboQoACgkQFA3kzBSg
KbZFdg/9HWSBsv5ac0+p7QQw4RvY8KD1H2AgUxVhSTbs5h5t8MrHre29waCLElui
xCDtfIunYs0KaRL9usOEvUld9Jxgd2OFxItpJXRjIFnHP2Atx5ptBE7RoqQTutwS
tP83FYCjlDGvorO2ZmDgbL4ay+SLIBoUbzR9HyRY1tl2E3llnv+vX+KMawff1rnF
c4iD4kA2BPSIIFZXkgzFcRi+/NtNzlNQwhmuu7OKTIIApJ7VE7Rp0YOQe+dcaoPN
AZy3dXNQiuDAMYAErQiaaAHVt5krz2ADbnEN+TTr5oauBkxket9lrtJ87NZIG/3Q
OEC1h+f38Lf30ZB8t+CE/45Cp87V8fglBNQp/aUCoRPzovp0KXvHhO1PY3E5QvL3
92Oe6tG4gw/JutIr3yFdGB8LeOV9DsSttqMWGf/RZGrkJ6GQwc70xcWaWorQNmRj
vTYYf/M/11FzQM63DcS43tWC+WgDFTn5BOpnoBvEuWz2LxjYsogFqcxhE5o0DXnJ
3ka/DgJ7WqNW4K3oPELUzgkVvqhPd4bx4A8Q2Vl9y2JTWtJB7UyK9p2Fu37ZFELw
8V0NpyzVKpy2z1eeO+1+6X2O7daB16sXUL159I9Kfc1Nh+nY82BV0pcRKtDuK9/b
IVxKD6vESLsVR+lpy7fKkmFHjCxXCMKT0zE+5YchSrJ54a9f+Lg=
=4nFf
-----END PGP SIGNATURE-----

--rcnbahvgpyccu534--

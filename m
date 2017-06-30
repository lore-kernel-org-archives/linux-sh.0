From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 30 Jun 2017 09:03:55 +0000
Subject: Re: [PATCH 5/6] i2c: pca-platform: use device_property_read_u32
Message-Id: <20170630090354.6s6ahpjhis7ptbfg@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qq5nbduvabei5q57"
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc+6WGFiJifEExjv3jSFsy+ORGtRoDPmv31sSFN=zkHMg@mail.gmail.com>
In-Reply-To: <CAHp75Vc+6WGFiJifEExjv3jSFsy+ORGtRoDPmv31sSFN=zkHMg@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--qq5nbduvabei5q57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -               i2c->algo_data.i2c_clock =3D 59000;
> > +               ret =3D device_property_read_u32(&pdev->dev, "clock-fre=
quency",
> > +                                              &i2c->algo_data.i2c_cloc=
k);
> > +               if (ret)
> > +                       i2c->algo_data.i2c_clock =3D 59000;
>=20
> My idea is to get rid of legacy platform data completely.
> That's why I suggested device_* in the first place.
>=20
> In similar way like you did with GPIO lookup table, you may use
> PROPERTY_ENTRY*() macros in the board files.
>=20
> Does it make sense?

Frankly, I am not a big fan of converting board files if we cannot test
the changes.


--qq5nbduvabei5q57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllWE/oACgkQFA3kzBSg
KbZ+mg/9HiJeVWAZlhH8PrUuRhuL6x6YwBPV196+ziXxc8MmaCGeO8b+7yYSPfWZ
zSecMUBFLmXaFljK8T4BpB89V2bR8Vo3TvSJWP46eIN0rHtxDQwGWHX3yfwJcitN
6FojbfZfxve0hui0CkH2EE2XlgbSDS6Dd3FjZCOtlOdG1RWvz+cYqxXLnVN9k75s
xfbx0yWpUhlmvxtqDzla/lZPoqYvR7iZJ152djs8eyaVWgkslJX0YHMcR46+5l2i
rnYpMQP9RxZMX7IXJjaY/oC+MqlXnxG7F8pDAN7CYRVGz3r6Ev5qB7iXTF+rUG63
mMI7ufju9IEKoO112/o3bZNw3jPt+MO9p0pc23egYPLZSAZ6ICZidkywUMBzMFlw
ayCOM6/Wlpubw/XF9eQxiYJjhb5hytjTPS2jHN8n9aabJ9rLRzaAqJZjQqSvY3+L
m76ZccYhUTHWcwtn+Trdc8AP9juv07VKCnmq/S8d8v0vUj9zfP5JhLic6x5mAezN
uYGu1w4gG3mIKEoCV9hezzb6adreBuD2tooexhKKFGoJoX24Hpz336O8aBIBWtwb
FsuK/J9GWL275tE8xHeUv1SwhqEBSilF6kgiV0VdYdGhRZz3M8Oj7UTJZcCeBldE
sSdrXgPYdE0V57y37JBA5tgi24lQKN17Ksbhjth0807N+3HoLco=
=8IhU
-----END PGP SIGNATURE-----

--qq5nbduvabei5q57--

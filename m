From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 30 Jun 2017 09:01:34 +0000
Subject: Re: [PATCH 3/6] i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
Message-Id: <20170630090133.np56eweoa62xg2ph@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7kvrtiw7xay2m3cx"
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
 <CAHp75VejpMcgsyncpbFnDXbwYcwdD1BPqy53s98xcNmfAnJTFw@mail.gmail.com>
In-Reply-To: <CAHp75VejpMcgsyncpbFnDXbwYcwdD1BPqy53s98xcNmfAnJTFw@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--7kvrtiw7xay2m3cx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 11:40:51AM +0300, Andy Shevchenko wrote:
> On Fri, Jun 30, 2017 at 3:54 AM, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> > Rather than returning -ENODEV if i2c_pca_add_numbered_bus() fails,
> > propagate the error to aid debugging.
> >
>=20
> + Suggested-by ?
>=20
> You or Wolfram can use below if you agree on it (I'm fine either way):
>=20
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I'll pick it.


--7kvrtiw7xay2m3cx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllWE2oACgkQFA3kzBSg
KbYewhAAmyur87Hbqdf5X+Wpmp2OBW6jLTsZJ5YNoOet6M9hY8FridBuz/lfz9EI
kEsxwtSvrKubCGkkoYSs8AqidxJHJTTzrfXAXan6gMGEXwN7SY1IcLa9lG8qJLiG
FVjYx+l3CFtqDPob4rX2gpK8UZ8uiNMbf2sLijB6SgQ9t4FlQylwPOpcrlWeK7CI
4jVmTIOk/4JVox8xQNTBIvrMgSMWHoNWLKQ56JCkGliBJRO3/OKXZNE7U9ESS9Hc
xWk5OztKGxcLuRqb8BX+lz5wymkKJTW4bxaKJtxqDd1HnZspMPezgHKPQr531j0E
5LqCLkD8kieG1JwzyjnKEVJOv37TL5sFwzYjmp/K9MTcIv4QDlj+C5T2Bc7NNPJS
xVtYrQOK68Ar7Ynljd3eFhq/dMBTVz7qRyTeisH03LNuhLniFvO7HNLRtsnV5a/8
eByOn6XbJNMjG6pZ5070iltzuwckvNFL1WRQvh3EtaMKxQ+ReB06Yrn6aE/qOFn4
waFs9AI1Z4qkFBOC+jCQR+P39Y5uS/lBGfmv3nVUdOytMik5lW/Wzn1OKVczZCIU
5CEjlH1jzHXboRhE/Jyv7kWU/00+N/Tfx8BTzPTllgWJQsVgr568oHjfhLNNrgwC
i6iY50xdRzhzIPRfrFA0knS9gwhYSbD7IJ/O6UWp6AwoIeb6xAA=
=eOLS
-----END PGP SIGNATURE-----

--7kvrtiw7xay2m3cx--

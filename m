From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Sep 2014 09:44:27 +0000
Subject: Re: [PATCH v2 2/3] i2c-rcar: make rcar_i2c_prepare_msg() *void*
Message-Id: <20140920094427.GI1612@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nO3oAMapP4dBpMZi"
List-Id: <linux-sh.vger.kernel.org>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
 <3369447.JH8v9DUGDl@wasted.cogentembedded.com>
In-Reply-To: <3369447.JH8v9DUGDl@wasted.cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2014 at 12:15:46AM +0400, Sergei Shtylyov wrote:
> rcar_i2c_prepare_msg() always returns 0, so we can make this function ret=
urn
> *void* and thus remove the result check in rcar_i2c_master_xfer().
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20

Applied to for-next, thanks!


--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHUx6AAoJEBQN5MwUoCm2QdQP/2AUpBrOOOiiweXTELJQwzwE
0aWrJYjzJcSTCM1nuD0BOJIBrQj0sCAkJUwfigRRblcXQNqwCTb2p/5z8GVC/bNh
cDxQjab3eEzf+2fn+xyQtEphYK39KcKSHgIKz97K45wWQXydH43mkJNuhnZtoFC6
9gUm7n3pqxbpuqeTMUHpqW3OQPflhNgd14/koEq7l8ru/UxZwp1r/DiOBccWXUuL
IviTuFcVH2waLkKT9rPvf9lynSATT0j4r9JZvW1V0kPwy0I40g+2jYWvPSEzgV1H
MIEdJr00qA0mos3uCTLvzwaZugV2yJgMB72VnGDWNMDiHeztZy1ZlohKqvHlNjB3
GU+zRcv7BF13s+1uNI+S9UI8x8UT8OSHK3TsLtCYxlWzugmKIkJ5TRTxgI+ioEBj
ADzA58AFOUkMO9oNQuHn6VS+xdaUDB2CrSTIAec3Q4vwfHJ1tyL15sPmSr2oFTGO
xGcFEpu2qrN3vKCBWzDi+ogEx1dqgBfNhwykhXVRe3FKboE+fR/2zUfSGgQtO9/Y
Ug2T8DV/o5YbbBj7WLAd4cfRlUmxSJXRkJqlEJryHgjxzPZttHdSKGaIFnErJPR4
ljDxR03+t9J4HzV4utIqbRTn/8V/XfC+oKi5zIni5ru5svOwrq4pvQiUGFQNO2Eo
uSdFAFSLyDmLJkeW6F3L
=JPvN
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--

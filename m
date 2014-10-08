From: Felipe Balbi <balbi@ti.com>
Date: Wed, 08 Oct 2014 18:05:13 +0000
Subject: Re: [PATCH v3 2/3] ARM: shmobile: koelsch: enable HS-USB
Message-Id: <20141008180513.GJ22688@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="I/5syFLg1Ed7r+1G"
List-Id: <linux-sh.vger.kernel.org>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
 <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
In-Reply-To: <8674731.7YYzQeH0h1@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org

--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2014 at 10:02:44PM +0400, Sergei Shtylyov wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Enable HS-USB device for the Koelsch board, defining the GPIO that the dr=
iver
> should check when probing (which is the ID output from MAX3355 OTG chip).
>=20
> Note that there will be pinctrl-related error messages if both internal P=
CI
> and HS-USB drivers are enabled but they should be just ignored.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> [Sergei: added pin function/group and prop, moved device node, fixed summ=
ary,
> added changelog]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> Changes in version 3:
> - added pinctrl-related properties;

did you miss pinctrl here ?

--=20
balbi

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNXzZAAoJEIaOsuA1yqREpwYP/jIuyFmwo+mS0VUDwsEqRfTm
icWV9Ul9xuSeE2JxUceo9UyITWxCtPzcLImptfTRQqSBVngnw2xo3dRewvE94TEt
j2Ck5/mVzOxdqUKLI+0CDfpC4O2ID7nz7RjGlaTg3Gc8hdKxyN2qgxwjWbaJ0cfW
j/uvk5i10+XO0QXPf3/D3J3OvMNjlgxHK+A1W/d+AeE/fk90qWvS8m6WCb+xIRv3
dyAOkqOB3TTAKIBLTjPF3QJ0UcCAP47VstGv27q0SCS8ABYrfo71tqCHjceP3/e/
2OBszAuYJl20H/ICqf/7z6DdnnVPvOHL7zNorKXAFDalHFOTiCkjzkez6/g8tGMZ
nkINt852ZmXPNfNVYh60IPmOn+BHUqsvQkuZbN6DtG8drFXDBqpqEXG5npRvPGyY
pD+1QENSLO78hU+Mta9OrtL25aMFXhqYL8SkKKZTxZnUaEvBjjny6opD52NqHwDJ
VxstqMWc8cB+PX/8mzB4gQ/wyD26xWWFl/JMNUuNdTOccAjqCT7IAmMufrUF6oMs
txJkeKMnYVx9M91Hh+mbn+yj36B2h+flpo9jwQe6qx1a9O9ORAQ5U4dGDt7m0eTD
Ll1HK98GOYnY2s2FvbU/5gAbZLtXs/NvmM7RFhZ/g+vF32LiwKRen45IkILH8bnJ
r9CfGvwcy9jdpyx1/33E
=tl/+
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--

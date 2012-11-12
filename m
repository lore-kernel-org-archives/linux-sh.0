From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Mon, 12 Nov 2012 15:17:35 +0000
Subject: Re: [PATCH v3 1/3] mtd: sh_flctl: Minor cleanups
Message-Id: <1352733455.2262.0.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-rvHTxkHiqfN7N8WCUWsA"
List-Id: <linux-sh.vger.kernel.org>
References: <1350641736-18192-1-git-send-email-hechtb@gmail.com>
 <1350641736-18192-2-git-send-email-hechtb@gmail.com>
In-Reply-To: <1350641736-18192-2-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--=-rvHTxkHiqfN7N8WCUWsA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-10-19 at 12:15 +0200, Bastian Hecht wrote:
> Some small fixes to avoid sparse and smatch complain. Other cosmetic fixe=
s
> as well.
>=20
> - Change of the type of the member index in struct sh_flctl from signed
> to unsigned. We use index by addressing array members, so unsigned is mor=
e
> concise here. Adapt functions relying on sh_flctl::index.
> - Remove a blurring cast in write_fiforeg().
> - Apply consistent naming scheme when refering to the data buffer.
> - Shorten some unnecessarily verbose functions.
> - Remove spaces at start of lines.
>=20
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-rvHTxkHiqfN7N8WCUWsA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQoRMPAAoJECmIfjd9wqK0mEEQALwBlkt0dtFHg3ukenZ7Fc1e
Fd0/tHX8eqg2A/E71Ev7BZC7RzbU9361QAOfozW1DyYWIq5MLoQBzkxCvVu4NcJy
SN1IpChmspEFiUnGnC5m4dUsXmB7+aAfrUod6v36OVmu6A78+LmPq8fD1LtpGqUD
TxPkBR+k6jWaGRVR3jv3Q6dVZOP4o3/2bW3raj66B6XUKoLDH0uKjxh5NHiUGLku
x29kcWfxlD43gjiYLSwgI3CKBMmbiBMKaHEwi45oP45L3IjFNokGCHB/qagA7Q9x
yl8oSfYSk7FsBKUS1qzKtTvxflWNAxBGnlJ4GxIRT0dyPygCcnXPGsOJcbVeGvyK
nej3vE4foy3yZnWhqoSMBq9RfgiHwJyQxgiTs+6RaaaruIaU+hQgVOsOJo1XpX5D
bEVBlEGDQCVGbuV5R582M+HFDyh3/wwfd+edX1hCHGGIG2JGI9uzMgMpQ5NSmfzH
vheu/eqJEQAPxFUu0/mMZOa3eHCNFnD2A8Ze1GJnMT0wy1osP86wxZBrToTh2aH6
YuHtQIkAcmh3gYvMnBT9k5kQNqYcMfdz5PRjX+xp7JJY9ZwZymqXqT86fAekkpmo
Hzzk3r480vvnTcQF8gRUWSYlKqfff/bgALnkOJXFR/Z8ypJXnIjfehTlc7EACIRy
9OutnhzHu9wmB+MW4pr9
=en0j
-----END PGP SIGNATURE-----

--=-rvHTxkHiqfN7N8WCUWsA--


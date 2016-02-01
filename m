From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 01 Feb 2016 13:31:20 +0000
Subject: Re: [PATCH v2 0/3] drm: adv7511: edid read fixes
Message-Id: <20160201133119.GB10607@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wzJLGUyc3ArbnUjN"
List-Id: <linux-sh.vger.kernel.org>
References: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
To: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, David Airlie <airlied@linux.ie>, Hans Verkuil <hans.verkuil@cisco.com>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 10:56:47PM +0100, Wolfram Sang wrote:
> So, here is my V2 of this series. Changes:
>=20
> * Added tags. Thanks to Laurent and Lars-Peter for review and to Archit f=
or
>   testing. Much appreciated!
> * rephrased the comment and commit message in patch 1 to be hopefully less
>   confusing :)
>=20
> No code changes!
>=20
> Thanks,
>=20
>    Wolfram
>=20
>=20
> Wolfram Sang (3):
>   drm: adv7511: really enable interrupts for EDID detection
>   drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
>   drm: adv7511: it's HPD, not HDP
>=20
>  drivers/gpu/drm/i2c/adv7511.c | 48 ++++++++++++++++++++++++++-----------=
------
>  drivers/gpu/drm/i2c/adv7511.h | 12 +++++------
>  2 files changed, 35 insertions(+), 25 deletions(-)

Adding Hans to CC of the proper mail, not patch 1. Sorry for the noise!


--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWr14nAAoJEBQN5MwUoCm2rSoP/0bOBtTmxW+49hY89L/99aUP
XCN6TzgxBQe6G0U8h2eT54MMNfgKLefvPzNwiz21q8YR00zXInxmrY91sgLzNz2H
eyWs/V/2Z9Gi8S67f+ieu4+2kivYRyh79LEIemx07TvVeQXbBoaa2GEl+uGsf4+A
OUhtDuF0kYiCH8C30fxEw7bsaWUpBnJcimVJumr3U0W3pJs3v0ungiahsKU9DjIz
MCLdnXp8mPTEl6ZQj2s16kYI9TvU5LMSvNaYMW1R7e+ovn6b9lsE5Dw+hX/T9osU
hYK1QzrCD8b0VlAn6X9mjPTOr+EU9upe8gYcLKhr/njRvfOY8malZ/5I6Snp/HSw
4opunamWEkc2/v6bVfU92lGcJn7vHhG8ILzZWuUFHbg4FS1V0D6h+mdAReHcottN
VpOt0yi0Nepg0CVxMwq6mDeCSLGxQmQgUvSAcUTETr/msZsFmDu9nzbj4vbdGrXP
tX/NNwjN3+3RfAPBTRs6SUgDtpuhLLVgdMqUZpBHxM6ojExrk/Er96rxwCJjhYc7
0iShL1/cF2gSvBkRZt5IRzF75xlIj2V2+vUBB6rnpibsh5K2d+pOQz7cTLxa+Rzr
naPzAsd2cRYWdjMISNjkzxr2Wd8Y/+pZv5XmIG4k+HHigSWxdV/JuSZb1mVjYD3o
InEDUCMVrniuwRAQR+KD
=SD1D
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 10 Jul 2014 12:25:58 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <9184799.0kesuWAK5g@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1994725.boiimcIMQd"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--nextPart1994725.boiimcIMQd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Thursday 03 July 2014 10:48:34 Wolfram Sang wrote:
> Hi,
>=20
> > With dynamic debug, these flags dont make much sense unless you wan=
t
> > something to be printed *always* during boot.
>=20
> Yes, this was exactly what I wanted.

Why is that ? My understanding is that the purpose of the=20
CONFIG_DMADEVICES_DEBUG option is to enable debug messages for debuggin=
g. As=20
it requires recompiling the kernel, wouldn't dynamic printk be a better=
=20
alternative ?

> So, for consistency reasons I copied the existing mechanism over to s=
h. If
> it turns out that the desired default is something different, I'll se=
nd
> patches for that.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1994725.boiimcIMQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTvoZmAAoJEIkPb2GL7hl1GHoH+QEnhs6AwShgfYXe08dqRw3f
IXRggP4zzyBEXonawG8g8staW1gTk0UXA3pqQR4YYAVow00itQoxtX8lQ5YkWx+6
mEMLGpeE6tmUMLLRpXaVZAbkHPnfLUnqTydFu/xf3oyfDvjX99Tt6tEq2mOoXq/d
e0iuTFboL/S2sSZr4PsiZv18cojQusKmdoY1oXCpOJ6J5SHYvocURmRV2/xJmXFT
ZXylZhLswMRGEWpoBfPGoM/434oqtJzrgkLrqSRK+mk6EavCQlH6m6ppIqvzp72L
MvsmwiFhNDDpDQkOcocED2grhQgZpKdKjqAdJJ6xMV7N/k1Yqc3wzmHH3qfQah0=
=Y2Xr
-----END PGP SIGNATURE-----

--nextPart1994725.boiimcIMQd--


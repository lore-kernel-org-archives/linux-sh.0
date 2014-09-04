From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 04 Sep 2014 18:05:59 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <20140904180559.GA3754@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
In-Reply-To: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2014 at 12:44:09AM +0400, Sergei Shtylyov wrote:
> This reverts commit 150b8be3cda54412ad7b54f5392b513b25c0aaa7.
>=20
> The I2C core's per-adapter locks can't protect from IRQs, so the driver s=
till
> needs a spinlock to protect the register accesses.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org # 3.16+
>=20

Applied to for-current, thanks!


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUCKoHAAoJEBQN5MwUoCm2tFEP/2IpyChREeKuSX7HgVVv+TQ9
O13iv8B501HD3A0/xZ9llfRRNicGKbO5s07mNAyXR5weZQmwodKA5xEatlQBzO1K
y3riabvJrEpT/9QcOvfrIg4xbcWX8EwIHJh9XC/dmI8W5r8NjvxqVEIgoQCxRzOe
HThH11gao+xVSDKog9cKY0k9/JXTEl2VXI1+Z2nbfi8t6llzxB6EWYmsYWvPuKex
qwNa4a+pv8dTctXpDVk6LkO56l458V+H3CIhgQBKU0MKTptRycjA1GkDQOVUzhYB
jjeFArGwN3Jn6wdG55GAAgTAdtVo4qljY4hFiq/1HzfG9/bh2ZlnQaGDsM+ap59W
sN1cRco5gJRx/grVsl4BBf5oexz1KiZ753hlPYLZXpl9aXPBLr9ylxzQfTCCqCnD
TZwkj40E76R5vtEOHozFNLNBtq6sDzOKLauMymLAwGtj9XukfqrhUi5OhNaB07l5
w4pLjctEb4Xebe8Kz+QKBJxt8mEhZZW2FooHd4SWJafQKSRMz2Lg5ff9WelGh5Yx
n+tcsgyymJKUonPoYKRUu6PfLx/RE4EQ5XTQ1/CUvjseERrHOQlOlpPmnKhphM7v
pHO3CGSQfBZJwksrPPdpET/X53Z32+r2X+ChEzj3aTOXrpk+LkkAwc8b0rQeLpar
P52SITCe6gsJPwR/kUKs
=zmkX
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 24 Aug 2014 06:45:20 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <20140824064520.GA2578@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
In-Reply-To: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2014 at 12:44:09AM +0400, Sergei Shtylyov wrote:
> This reverts commit 150b8be3cda54412ad7b54f5392b513b25c0aaa7.
>=20
> The I2C core's per-adapter locks can't protect from IRQs, so the driver s=
till
> needs a spinlock to protect the register accesses.

Looks to me like a plain revert. What about the issues you mentioned?
Don't you want to fix them? Confused...


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+YoAAAoJEBQN5MwUoCm2I9AP/3U4vvRRB1klX4xQSQtVQ1F6
CtNGnhiG99cNCsSw6I5VaONAyGKxMka0mpF9F/GaG5Wtzc0uKA9AWyd1qmv7j+rh
i703jBrfSG3AmRI28BYgm9ITBVe0eR2Oc13XACmCSa+N5E/AQ/VAmi7DuwMThm/3
RZbMyaX8MFtEbjf3Bb6L4BDWgF9CU+TNg4ShIShPk4qVWGtyT6aH9HPiW+79omCD
e01E53TYJP8kAxXESCWrYNlf0W6JJtmIncDfE2DOdyEsCX/hg2pYJNIBtX9eo8BC
fVnjvev9cIMZKbBOsid2MMapAw78KLvrRd/2L9GRCVim596zjSb+DINoGBfPiQdP
GQsIwidwSSPJCA+q/XJAFmJulhmIT1/bVsy4BC2f01TNc3ew6FOAJBRvttU4mOGq
iEitR5CVkusm6npNjIfy9AGlLalDfSnwhZeg3MCinA4Q0eN9JWiTErqKnlufWRL8
HGaUl9P/+JfZ8VhbNuKsruPT3soyNh/DFBn1YmmWqOk7KLUAn9UOTHxTHtgKXhXL
mrK+8NkS0i+YWjSETQGDs/jNZWynPWbuf/iFrVlyVTpwj+rQZJndB0VZcGZ7XMu6
tUPxSVyp+Sk2NSAajho2T3ik/LNW0DuUG7s+dfqLTR8PjQ3Jh2NXqs+x0wVeZnTB
PvRSlaZG0B3/GL1FPKV/
=fjpP
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

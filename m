From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 23 Jun 2015 17:51:45 +0000
Subject: Re: [PATCH 0/4] generic timeout handling for Renesas drivers
Message-Id: <20150623175145.GA3326@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
List-Id: <linux-sh.vger.kernel.org>
References: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434827002-25918-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2015 at 09:03:18PM +0200, Wolfram Sang wrote:
> Here is a small patch series to make I2C timeout handling easier for user=
s. It
> is not so amazingly huge anymore and it can be modified via i2c-dev if wa=
nted.
> While at it, fix the type of the timeout variable to the proper one.
> This time build-tested twice!
>=20
> Wolfram Sang (4):
>   i2c: rcar: use adapter default for timeout
>   i2c: rcar: use proper type for timeout
>   i2c: sh_mobile: use adapter default for timeout
>   i2c: sh_mobile: use proper type for timeout

Applied to for-next, thanks!


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJViZyxAAoJEBQN5MwUoCm2dVoP/0U8ox3Mb9hUucwT4bEVZ8sw
5nWWTxUAmhzuiMUdXnvamYijxnWINPvwk8Wuvx64rUgdsIo2mWM1frR5TRZZ20Ty
KM3s/ldtFQgSx1OxDyBF9cWyWPbZIRYa6vYXj39mGqYQ783YWm4l7RtXbJJLEd2t
zYLagoQZpdxzeXyiXGWK5a+bZnnquHngbPMpzx7d9/HpyqBT8KxZ4viZs7ohkV7M
dijT7rppsIerAF4QB+uYMbC8GR9X4nnjocL6J3E1GwK4mD+CNOBghKvB3GIsDfuX
QlSvmfTphVZQCfhrzIfCitpo6yqGepLm1/ZyD94c4esBbtxskuwnMzPfFx8BFIxw
+lAuieRY308hLgVzYswBAu6rWbGfmMzUspOxuQthVijaDBmNljQnmvVRysS2aIaM
q34GSsJphz88ufYAxNghBEiRzAbP9T2heQ0aMw8ywGJ/5Pb4L8S/QAOFu8hCe1Fc
L0o4DBbBjEIHZERo+U2zxI6yyB9HOeRQ8I0a47aasV72rxqOkIdS6cJSTTarrAXc
paOiLwY5jkj3tM5syregA0NqYBo5GqlYu9Q1muoTuqQftW2DAqjD7sPn+L8YCmS1
ETJLPZwxDLYvak0vLunST3h2+nWM2ekP9HjJwDwBawPJD59NqC6f5ZlD2qxofY8n
GQ1QYNtAnEJbP83QMINj
=Sels
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

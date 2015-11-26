From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 09:00:55 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
Message-Id: <20151126090055.GA1531@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
List-Id: <linux-sh.vger.kernel.org>
References: <1448511980-12173-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448511980-12173-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2015 at 01:26:20PM +0900, Simon Horman wrote:
> Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
> declares the above property deprecated. That was more than 2 years ago.
> Remove it, so it doesn't get copied around needlessly.
>=20
> Based on similar work for the r8a7791 and r8a7794 by Wolfram Sang.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVspHAAoJEBQN5MwUoCm2T68P/2I5sTK0FOAAKX2SisrTili9
qn2GIeUacZz+n4HexuP8qGAlRL6/4BJkJHbLi4KjAKYSDyllHAHF3O5mnE7hEPJ9
ZKh/h07iCf5oHgLpGZMUZn9EhTWlXvgz9IkyOZaFGBWnDpICWgNXLyl/gc1v+Vas
L/CiQia5RbkPY9jWa7k6HSzxJ99/MEu3aeAdLsfGG6DI0Me/18mIyERfi1iTerNX
oQNGVrPu8YIZdLqHW1mayQUhz8k64dW5NHLFdAHYh+M55lS+G0WCFpEjs+DBcFS4
td0Y47jkoati7L+YfbmsPM0KXpQjxT8pdBWUDvS+IwJAyY5Ycn6GKoRkgrVOrZ1R
wub0v8aEYp/UbFsp3Z8ru9a2JgVQzRBlcyBKu+cKy16V6vw5ouYwTjI2xr1KlC+G
lM4+7BUIjaHW6bVlsQAOuS4FQyp/aVeH4uXN5fQvmfJTTDIHlEan30rhSui/kOB3
0Ne6oAy16MEHh4ySu35490PY0KcZeQWsIC38m6QlhvGTyI0L/q3higEw8zHWyogG
+Rr196bHfVPxjKQLnzMdo8jCTXUEhUE+DLLfnfecWSqBgZOMWeDm1BnJILx4GbWx
XCHfjwYURkJeqq6fHmGLwj1qClzWj2PoSFxj4A8gUyihwOvlxHRRYQ0ZyIFDqEdy
m6EpiVdQ7YuPNa8iuhs3
=wR3Q
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

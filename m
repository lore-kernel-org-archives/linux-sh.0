From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Jan 2015 11:29:59 +0000
Subject: Re: [PATCH 5/9 v4] spi: rspi: remove slave_id settings for DMAEngine
Message-Id: <20150129112959.GX21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1dghmwL1sQeIkGYD"
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4flbjq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4flbjq.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--1dghmwL1sQeIkGYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 01:02:36AM +0000, Kuninori Morimoto wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Current rspi sets dma_slave_config :: slave_id field for DMAEngine,
> but it is no longer needed. Let's remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--1dghmwL1sQeIkGYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhm3AAoJECTWi3JdVIfQ/M8H/j02Ip9TF5UwBx4a67IkfvoR
oqo7TRUCqSphKztfO5lMQpZu1JQH3dqiqs2yg5dODh0PW5je8TZ0jwvAkDz9cGy8
MMSadahOuYiapwLt6DQH2DKm4fMbogN02vKKRU3zDk70fPZq3aixt/DoTJYf+x5a
shd5yT3PrFcJdk3PFQErmB9ZjZOjK0TPqa8FU/pS1yl12VNjnfoGh6i0BqRSy8LL
ZJ3p49zspxGQySzErlEPPTAcwx9dl9BbvkNgkaqYlBnQJgPZrak3WgdLZcBeClF2
gOpDKQKBqO7UBlcCzkv6vJsi1YCqpEoNeCL8G58kg3K5yN9oauk4bRVQU6+F5E0=
=KGtU
-----END PGP SIGNATURE-----

--1dghmwL1sQeIkGYD--

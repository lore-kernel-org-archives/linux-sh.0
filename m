From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Jan 2015 11:32:20 +0000
Subject: Re: [PATCH 6/9 v4] spi: sh-msiof: remove slave_id settings for DMAEngine
Message-Id: <20150129113220.GY21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jODBGeNiXGH/Zy53"
List-Id: <linux-sh.vger.kernel.org>
References: <87vbjzlbjb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbjzlbjb.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--jODBGeNiXGH/Zy53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 01:02:59AM +0000, Kuninori Morimoto wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Current sh-msiof sets dma_slave_config :: slave_id field for DMAEngine,
> but it is no longer needed. Let's remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--jODBGeNiXGH/Zy53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhpDAAoJECTWi3JdVIfQrVQH/2How8HjA08s54dldL5+03sM
7v41QpRT/TjaBK5w2qD/FtLrbV7lVFTbsDjmrmyYPDNcrxZIlpFreHT5hVMPfWtJ
4+qZmIaH9OFRNWudxg/b+RfaqVfQSGYv9JQcp18eE6LVSPRPBoZxWA649FzGARt/
Hr8J7gRrPBeqoX2B69n4CIsKdF0A7LS5zqp+F2MWE4SDsSaNQvlb4B4jkebpTBe+
okUntkDNRxrhKDCu8K/Jd7MzT2vFZkE2R398V2JgQjh7X3vKIVZkCbVywTDFUlNz
MY5Nb3amjKsq3lHp/uabV9zPMyf2doMixOORfFvU/Sprwcxm+ObZulq875eMXi0=
=QHJK
-----END PGP SIGNATURE-----

--jODBGeNiXGH/Zy53--

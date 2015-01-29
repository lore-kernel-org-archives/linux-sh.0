From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Jan 2015 11:32:35 +0000
Subject: Re: [PATCH 7/9 v4] ASoC: rsnd: remove slave_id settings for DMAEngine
Message-Id: <20150129113235.GZ21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xNfoxAF6BY6VsG0y"
List-Id: <linux-sh.vger.kernel.org>
References: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--xNfoxAF6BY6VsG0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 01:03:20AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current rsnd sets dma_slave_config :: slave_id field for DMAEngine,
> but it is no longer needed. Let's remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--xNfoxAF6BY6VsG0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhpTAAoJECTWi3JdVIfQA50H/02O7f63ahqmNDVcloUtVGBb
tWi6TvFW+c/1HyWJ5Md/fBnqQkimgtBtAxAwN5xn/xqDKl511rulDbBguP2fYw6M
Q/TGrcBOcXXe2x3pSVIOKCy2mOs5eZKQ2FkyacXqEXSnegwi1d+3292d8gepqUuT
6b3nE8gFfazgAQB620ulGp9YufuVhZEHTfsdsqKg3+Ui3RrsegQl63pS4qcIC3oB
8RWdW+GIHoKXE1e3LS2o5SGwd6mEu2XK9Gtvu9iUudSqnR+RTbY6OZ/ZwMPIT2bi
kQ2w4J5xxw31AhyKt00x3yYszuGxfRLmL6yxdlbPGmF2lAdbpHJliAgBj3j/MfA=
=e+FL
-----END PGP SIGNATURE-----

--xNfoxAF6BY6VsG0y--

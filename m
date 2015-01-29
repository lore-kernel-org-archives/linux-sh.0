From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Jan 2015 11:35:49 +0000
Subject: Re: [PATCH 9/9 v4] ASoC: fsi: Configure DMA slave settings
Message-Id: <20150129113549.GB21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kpPO918KLFLiDzif"
List-Id: <linux-sh.vger.kernel.org>
References: <87r3unlbhp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r3unlbhp.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--kpPO918KLFLiDzif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 01:04:09AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current FSI driver is assuming that dst_addr/src_addr of DMAEngine
> will be set by platform data. But it should be set via
> dmaengine_slave_config(). Special thanks to Arnd

Acked-by: Mark Brown <broonie@kernel.org>

--kpPO918KLFLiDzif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhsUAAoJECTWi3JdVIfQi/AH/3JlqVQ5NzfbmhctcN+IhmLT
olvKAQx8D+xtUnqGWfovjgKXNp4738n4Nbre4yOe669m0BoiLl7A6Qip5KfjqzUH
+HPgJ5SO4T1vW+V6t2d48VY5i9GPzrIOJF6vwkhsnAwO8C6fiewgx/xhFVhhyP/9
kamGyoHrd2f+Y74RxBLrkXt66kFpPm4rDGw+RvZ4wKP4hhz5+ckstI0FHpBWR+an
JEiM/ucHXEaOUWPv7UD19uOGmf9NJGQXLtuxGbg0/Fli+76lArCo6MeO6I8gt00v
aa81N+1ewGtgtRJuLvOuROC7IICXh+uAdw5uP4aDdcuS4bDeU1k5kmpEd4n6z7E=
=yYFj
-----END PGP SIGNATURE-----

--kpPO918KLFLiDzif--

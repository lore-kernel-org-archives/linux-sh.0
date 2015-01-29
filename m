From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Jan 2015 11:35:27 +0000
Subject: Re: [PATCH 8/9 v4] ASoC: fsi: remove slave_id settings for DMAEngine
Message-Id: <20150129113527.GA21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="F/AP0Ej8g8TT69LF"
List-Id: <linux-sh.vger.kernel.org>
References: <87sif3lbi7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sif3lbi7.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--F/AP0Ej8g8TT69LF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 01:03:42AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current fsi sets dma_slave_config :: slave_id field for DMAEngine,
> but it is no longer needed. Let's remove it.

Acked-by: Mark Brown <broonie@kernel.org>

--F/AP0Ej8g8TT69LF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhr+AAoJECTWi3JdVIfQV9MH/j3RIzKO9qRYh5dGvRjMv5xi
d9QyoT/GDB9AVWhHg7q4thPV0llRxSX67UwqKQH2fH3tQPm2Z1EJQ77uaBGQ78Xo
OtMX7ZvsDv63sWKi0kDaqoNuL/PpT/oqT1v6oz99ck0qdEQQ8mvYpGecs3HzlDUa
62nuLoAigfzYpd5t0u1XWfVuHtPLZoBeH5V4vYVrzlDORcJ87vU0T/vAkHMWZOhb
defV2BNYwIIb8cXL35CUQuKnZOoM+PyDSRf9QQdyUiuKk+/P6ISGe4NJMJgTOp60
+vq19Tm82+z+XU6tBuPXts+GFNIXhKDavVNM6JyEFMZZdKoxpHYte173bfxiexA=
=WxqW
-----END PGP SIGNATURE-----

--F/AP0Ej8g8TT69LF--

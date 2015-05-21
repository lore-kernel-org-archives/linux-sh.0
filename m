From: Mark Brown <broonie@kernel.org>
Date: Thu, 21 May 2015 10:46:09 +0000
Subject: Re: [PATCH 2/4 v2] ASoC: rsnd: indicate unknown HW start
Message-Id: <20150521104609.GT21577@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gIHggtDV96iaw8wO"
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <87617mtwvo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87617mtwvo.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org


--gIHggtDV96iaw8wO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 03:49:13AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> rsnd_ssi_hw_stop() should be called after rsnd_ssi_hw_start().
> This patch indicates unknown hw_stop as error

Applied, thanks.

--gIHggtDV96iaw8wO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXbdwAAoJECTWi3JdVIfQyXYH/ihmOCQknPk/ZK2NWAx4edug
G9JCCDlKaX0ZLdrPY7CQOc9G0d5Yn2zMqHsGKohW+Pbdy9ZogXP7th+VOYwlnR5d
APkALQwzcIL0WXnY6HD5uoj8Xzt2Ul7fpDn1/axIiyETkTFLs0zv/nruuVNeSd35
9d6GKAAgbwUa76+JDMhBl9MPY9roPSpynbOyiniOhzgpfl+sjWfKMDR0rcyPzpGt
fAaSj0Igd1PDSR8e46cE0fc3E5riVI5XwIfoPURBGt8530HJ5dAVeWVKhHSk5plf
WY94degpRSTj9/UzEwLuOUyxgK7EBmMSsoxCVNLNjsFxwIckDLCspyMACkmSj7g=
=wh10
-----END PGP SIGNATURE-----

--gIHggtDV96iaw8wO--

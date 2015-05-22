From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 May 2015 13:14:30 +0000
Subject: Re: [PATCH 1/4 v2] dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
Message-Id: <20150522131430.GC21391@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UvwuEPigQXXfOf7G"
List-Id: <linux-sh.vger.kernel.org>
References: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
 <877fs2twwm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fs2twwm.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org


--UvwuEPigQXXfOf7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 03:48:38AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current rcar-dmac driver is using spin_lock_irq() / spin_unlock_irq()
> in some functions. But, some other driver might call DMAEngine API

Applied, thanks.

--UvwuEPigQXXfOf7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyu1AAoJECTWi3JdVIfQqp0IAIETrPNeX1MlJ7jBU2mm6H+A
wqHtLuY1DGVIcIi5Qp1p6sYSLvrpusz408WhC1FPxjlkdA7pV4VBONYlZReMRdrc
GU/hVyNjcej4YWIgRMhxd3cswRXZkciIl74Os3RG9z/qGrelG3I4e5dJNK8BzO0s
67bGrIsqZsEaZs6VbfkETCCWoFS6Hi0Aspa/AgCmbA6zNXaQw8G1qNO9s/Xbt1vh
LGrHc+hmeIypARUnw5fKd899nStCgLJUIdTGbAkMToxp85psVFelbX3uxF7FItf3
ftZPdigs6L72Syrpa1hk8QdRwkQAOMh7idaT8c/nJZH3WuMNgLG+pZ3Mc1xtyJY=
=gpe5
-----END PGP SIGNATURE-----

--UvwuEPigQXXfOf7G--

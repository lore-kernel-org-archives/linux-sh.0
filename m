From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Mar 2015 15:03:24 +0000
Subject: Re: [PATCH 01/28 v3] dmaengine: export symbol of of_dma_request_slave_channel()
Message-Id: <20150307150323.GO28806@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NT59pYSnj1ZLVgEN"
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
 <87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
 <87bnkk162d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnkk162d.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org


--NT59pYSnj1ZLVgEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 12:54:16AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current DMAEngine implementation of DT bindings can't support
> DT subnode. This patch export symbols of of_dma_request_slave_channel()
> for subnode DMA DT bingings.

Applied, thanks.

--NT59pYSnj1ZLVgEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+xM7AAoJECTWi3JdVIfQI+oH/0FehomP6o9831IwE17iyf9l
vyk61Oj6oEISGDe9T9yV+od4aVn3SOgxmJ7jBHioUXkLWgiCs08ku6+PhTg89Ss9
HxveAP4ijCKEXLXvywaat6eNjnJU+XvKuhTvkZh6ogf4ArLWcw4RuQQhDjFnW4sS
VD41wH4vvlIjWQXz/h72tfFxU7rfvN9sGeH+5P939VjSy2ptfDZnqlJdy36ostkj
X978pL0HaF5mSO7klThpMQlLRjXdnL9hDVL2n8hCN5QO8J3avJ4fstW6NxaNn0YB
/URF4Ex+OcLyxFTq5o9AgxFxyW+CvGJY94fiTd9ZYB1hOKwe35oVKyTvwxIXPrs=
=uTLY
-----END PGP SIGNATURE-----

--NT59pYSnj1ZLVgEN--

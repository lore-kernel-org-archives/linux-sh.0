From: Mark Brown <broonie@kernel.org>
Date: Tue, 19 Nov 2013 19:07:32 +0000
Subject: Re: [PATCH] ASoC: rcar: fixup dma_async_issue_pending() timing
Message-Id: <20131119190732.GM2674@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t3tFFy74pA5/PEcJ"
List-Id: <linux-sh.vger.kernel.org>
References: <87k3g677if.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3g677if.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>


--t3tFFy74pA5/PEcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2013 at 06:45:16PM -0800, Kuninori Morimoto wrote:
> DMAEngine will stall without this patch
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.

--t3tFFy74pA5/PEcJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7bxAAoJELSic+t+oim903wP/A5gupcqHcHbJtErJnBHWXe4
oPlQSfuDjRKgnxRpTEH7yc2KBmP6ZsASup0M/pLdSxkW0gciOiZi5SDW9CvRaB3V
2Roz9hWHtucw9+ZXicakYNzXOxBGV9cFyfeOe8xAbkh71PnZD7glZp6pTmtVjkab
VgbTDkG67qnbU8A2LIVBv5CrGmzpZHq517XKtaY0yPC3CmkJwb8T7+K5W8zidghd
aHdGyylLEu5cvcQmxZGCww7JA05FXIfBT162Ev0/8WJhJUsL15XDXutiBAZORd+g
raHjDjRktI1rSjHESjpxUqv4trwA4UO1GnAmSueuLYmuH/IlTo2/PNbVfNLC1gdP
OnAj/yTS7rRQEYltRMLuYHIrVOY5IlXo+sEIGtQ7XJO7UfQD3kDLBfu6KYloLvM8
kIElbYKnIPC2GhrE+j9u3sN/c7E1ALgDzfy/cP5TrFcTEU7WYmEDL6aeLAwLD7//
H/fmjMsz9GTPIQXIbW3Xj2exTcT4Ud9ms8tmHn7tYEM3C6aLm4hL0Q1vcLf07H/0
JJvpWjlAs5IGz/9AE5GgTqCZyxh3ivVlG/TvmXcBvV5Ou9TMCPlMTsuTSAKP81FJ
nV31G+de14TeiEfWv1HrjuJ0EfJtqK6E1aTXlU6t3yApCGkAh5TENyXrGXvFp231
+NNszCBhu3NNicoZkun9
=wwj9
-----END PGP SIGNATURE-----

--t3tFFy74pA5/PEcJ--

From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Apr 2014 19:03:27 +0000
Subject: Re: [PATCH 7/7] ASoC: rsnd: remove compatibility code
Message-Id: <20140414190327.GE25182@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CGDBiGfvSTbxKZlW"
List-Id: <linux-sh.vger.kernel.org>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
 <87ioqc20ei.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ioqc20ei.wl%kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2014 at 05:57:27PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Now, all platform is using new style rsnd_dai_platform_info.
> Keeping compatibility is no longer needed.
> We can cleanup code.

This and the previous patch both look good.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTDD8AAoJELSic+t+oim9sI4QAIDgAaBP23UvyxIGo5U2c1Rc
8u5CbCH3Z6u4EwtNRCT/hhaW3DABTEMfXHbtZnffdhtBYK/htd59dPiCZgontAwq
iKvbAdMmDgSA0JADX2jXc1aVexvL27YhOnDv/W7kZ5qb+9hGC0cqfHnxrMR7Q5rR
Jv+F1ZGbJqpXKeHNn4aZJMqwDrO2orBk5FKgDxnaweFbRerd41DAY3k5YBEEXfy1
G5TSCq58RMlcnQh6g/orpxj07KtWXvrBPIgWhhHp0Lj2P7eJe5a+YakZNohkZtWp
jk6ek/TzrTOcHML+RnndklH8zkFX4uVfUSZ4EKPkAsATwe8xqrbgj9pwU2sGL5H6
caB21T7kGBkiRtSZKFkPiGkK13lNu0tHbfQ+fbC8ICblmVXp7Sb1ES8g4/nAxNJC
0cE4aJ2Xo4q23zVosIAvyzHLSywxRrLoKYo6m1fQC2H3cfrpRyE2kVWCyk0mdyuM
oKPQGSnHGtgD7ktGSuLqGqhcNwHgz1CPsdSlCF/GkMDlpCJjWVT5uCJ0rtrexFGQ
o8Zb7CZGXZFhmVyHqt72JuByh5cKTZq8+TVKajxcFOL/boylVPJwdzadaAKA/hY8
gYPF1+2Venb2VhLV8SHRPHujjAkp7lGg3HzTpvVth2I8iJL66BHBEYPwjmj60zb9
CwRGSHLLIQeU5e/bD39C
=lJRI
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
